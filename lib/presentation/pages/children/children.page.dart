import 'package:flutter/material.dart';
import 'package:hope_app/domain/domain.dart';
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
        title: const Text('Niños asignados'),
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

Iterable<DataRow> generatePatients() {
  List<Patient> patients = [];
  for (int i = 0; i < 10; i++) {
    patients.add(Patient(
      id: 'ID$i',
      fullName: 'Patient $i',
      edad: '${20 + i}',
      fase: 'Fase ${i % 3}',
    ));
  }

  final listaDataRow = patients.map((item) => DataRow(cells: [
        DataCell(Text(item.fullName)),
        DataCell(Text(item.fase)),
        DataCell(Text(item.edad)),
        DataCell(MenuItems(
          menuItems: menuPacientTutor,
        )),
      ]));
  return listaDataRow;
}
