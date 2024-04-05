import 'package:flutter/material.dart';
import 'package:hope_app/domain/domain.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/presentation/utils/utils.dart';
import 'package:hope_app/presentation/widgets/widgets.dart';

class ChildrenPage extends StatelessWidget {
  const ChildrenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 70,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(S.current.Ninos_asignados),
            Container(
              margin: const EdgeInsets.only(bottom: 10, top: 5, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35), // Ra ,
                      color: Colors.white,
                    ),
                    width: 300,
                    height: 40,
                    child: TextFormField(
                      textAlignVertical: TextAlignVertical.bottom,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                35), // Radio de los bordes
                          ),
                          suffixIcon:
                              true //TODO: Habilitar condicionalmente con un provider cuando este consumiendo el endpont correspondiente
                                  ? const Icon(
                                      Icons.search,
                                    )
                                  : IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.clear)),
                          hintText: S.current.Busqueda_por_nombre),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: DataTableDynamic(
        headersRows: headersRows,
        data: generatePatients(),
      ),
      drawer: const SideMenu(),
    );
  }
}

const List<String> headersRows = ['Nombre', 'Fase', 'Edad', 'Opciones'];

Iterable<TableRow> generatePatients() {
  List<Patient> patients = [];
  for (int i = 0; i < 10; i++) {
    patients.add(Patient(
      id: 'ID$i',
      fullName: 'Patient $i',
      edad: '${20 + i}',
      fase: 'Fase ${i % 3}',
    ));
  }

  final listaDataRow = patients.map((item) => TableRow(
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(width: 0.5)),
        ),
        children: <Widget>[
          TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: Text(item.fullName),
          ),
          TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: Text(item.fase),
          ),
          TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: Text(item.edad),
          ),
          TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: MenuItems(
              menuItems: menuPacientTutor,
            ),
          ),
        ],
      ));
  return listaDataRow;
}
