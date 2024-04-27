import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/presentation/providers/providers.dart';
import 'package:hope_app/presentation/utils/utils.dart';
import 'package:hope_app/presentation/widgets/widgets.dart';

class ChildrenPage extends ConsumerWidget {
  const ChildrenPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final searchsPatients = ref.watch(searchPatients);
    final listPatients = ref.watch(patientsProvider.notifier);
    final TextEditingController controller =
        TextEditingController(text: searchsPatients);
    final textLength = controller.value.text.length;
    controller.selection = TextSelection.collapsed(offset: textLength);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: 70,
        title: Text(S.current.Ninos_asignados),
      ),
      body: SizedBox(
        height: size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              width: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(35),
              ),
              height: 40,
              child: TextFormField(
                controller: controller,
                textAlignVertical: TextAlignVertical.bottom,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(35),
                    ),
                    suffixIcon: searchsPatients.isEmpty
                        ? const Icon(
                            Icons.search,
                          )
                        : IconButton(
                            onPressed: () {
                              ref.read(searchPatients.notifier).state = '';
                            },
                            icon: const Icon(Icons.clear)),
                    hintText: S.current.Busqueda_por_nombre),
                onChanged: (value) =>
                    ref.read(searchPatients.notifier).state = value,
              ),
            ),
            DataTableDynamic(
              page: ref.read(patientsProvider).indexPage + 1,
              totalPage: ref.read(patientsProvider).pageCount,
              getNextData: () {
                listPatients.getNextPatients();
              },
              getPreviousData: () {
                listPatients.getPreviusPatients();
              },
              headersRows: headersRows,
              data: generatePatients(ref: ref),
            ),
            const Spacer(),
          ],
        ),
      ),
      drawer: const SideMenu(),
    );
  }
}

List<String> headersRows = [
  S.current.Nombre,
  S.current.Fase,
  S.current.Edad,
  S.current.Opciones
];

Iterable<TableRow> generatePatients({required WidgetRef ref}) {
  final listaPacientes = ref.watch(patientsProvider);

  final listaDataRow = listaPacientes.newPatients.map((item) => TableRow(
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(width: 0.5)),
        ),
        children: <Widget>[
          TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: Text(
              item.fullName,
            ),
          ),
          TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                item.fase,
              ),
            ),
          ),
          TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                item.edad,
              ),
            ),
          ),
          TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: MenuItems(
              idChild: int.parse(item.id),
              menuItems: menuPacientTutor,
            ),
          ),
        ],
      ));
  return listaDataRow;
}
