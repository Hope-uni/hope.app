import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/presentation/providers/providers.dart';
import 'package:hope_app/presentation/utils/utils.dart';
import 'package:hope_app/presentation/widgets/widgets.dart';

class ActivitiesPage extends ConsumerWidget {
  const ActivitiesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final searchActivity = ref.watch(searchNameActivity);
    final listPatients = ref.watch(activitiesProvider.notifier);
    final TextEditingController controller =
        TextEditingController(text: searchActivity);
    final textLength = controller.value.text.length;
    controller.selection = TextSelection.collapsed(offset: textLength);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: 70,
        title: Text(S.current.Actividades),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 5, left: 10, right: 10),
                  alignment: Alignment.centerRight,
                  child: ButtonTextIcon(
                    title: S.current.Crear_actividad,
                    icon: const Icon(Icons.add),
                    buttonColor: $colorSuccess,
                    onClic: () {},
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35),
                  ),
                  height: 40,
                  width: 250,
                  margin: const EdgeInsets.only(bottom: 10, top: 5, right: 10),
                  child: TextFormField(
                    controller: controller,
                    textAlignVertical: TextAlignVertical.bottom,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(35),
                        ),
                        suffixIcon: searchActivity.isEmpty
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
              ],
            ),
          ),
          DataTableDynamic(
            page: ref.read(activitiesProvider).indexPage + 1,
            totalPage: ref.read(activitiesProvider).pageCount,
            getNextData: () {
              listPatients.getNextActivities();
            },
            getPreviousData: () {
              listPatients.getPreviusActivities();
            },
            headersRows: headersRowsActivities,
            data: generateActivities(ref: ref),
          ),
          const Spacer(),
        ],
      ),
      drawer: const SideMenu(),
    );
  }
}

List<String> headersRowsActivities = [
  S.current.Nombre,
  S.current.Fase,
  S.current.Puntos,
  S.current.Opciones,
];

Iterable<TableRow> generateActivities({required WidgetRef ref}) {
  final listaActividades = ref.watch(activitiesProvider);

  final listaDataRow = listaActividades.newActivities.map((item) => TableRow(
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
              menuItems: menuActivity,
            ),
          ),
        ],
      ));
  return listaDataRow;
}
