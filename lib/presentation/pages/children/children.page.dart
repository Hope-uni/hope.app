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
    final searchsPatients = ref.watch(searchPatients);
    final listPatients = ref.watch(patientsProvider.notifier);
    final TextEditingController controller =
        TextEditingController(text: searchsPatients);
    final textLength = controller.value.text.length;
    controller.selection = TextSelection.collapsed(offset: textLength);

    return Scaffold(
      appBar: AppBar(title: Text(S.current.Ninos_asignados)),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 13),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Expanded(child: SizedBox()),
                Expanded(
                  child: Container(
                    margin:
                        const EdgeInsets.only(bottom: 10, top: 10, right: 20),
                    width: 250,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35),
                    ),
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
                                    ref.read(searchPatients.notifier).state =
                                        '';
                                  },
                                  icon: const Icon(Icons.clear)),
                          hintText: S.current.Busqueda_por_nombre),
                      onChanged: (value) =>
                          ref.read(searchPatients.notifier).state = value,
                    ),
                  ),
                ),
              ],
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
  bool isColor = false;
  final listaDataRow = listaPacientes.newPatients.map((item) {
    isColor = !isColor;

    return TableRow(
      decoration: BoxDecoration(color: isColor ? null : $colorRowTable),
      children: <Widget>[
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Container(
            margin: const EdgeInsets.only(left: 15),
            child: Text(
              item.fullName,
            ),
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
          child: Container(
            margin: const EdgeInsets.only(right: 15),
            child: MenuItems(
              idChild: int.parse(item.id),
              menuItems: menuPacientTutor,
            ),
          ),
        ),
      ],
    );
  });

  return listaDataRow;
}
