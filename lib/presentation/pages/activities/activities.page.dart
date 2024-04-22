import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/presentation/providers/providers.dart';
import 'package:hope_app/presentation/utils/constants_menu.dart';
import 'package:hope_app/presentation/widgets/widgets.dart';

class ActivityPage extends ConsumerWidget {
  const ActivityPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchActivity = ref.watch(searchNameActivity);
    final listPatients = ref.watch(activitiesProvider.notifier);
    final TextEditingController controller =
        TextEditingController(text: searchActivity);
    final textLength = controller.value.text.length;
    controller.selection = TextSelection.collapsed(offset: textLength);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 70,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(S.current.Actividades),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  alignment: Alignment.center,
                  width: 35,
                  height: 35,
                  child: IconButton(
                    iconSize: 20,
                    onPressed: () {},
                    icon: const Icon(Icons.add),
                    color: Colors.white,
                    tooltip: S.current.Crear_nuevas_actividades,
                    style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.green)),
                  ),
                )
              ],
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(35),
                color: Colors.white,
              ),
              width: 300,
              height: 40,
              margin: const EdgeInsets.only(bottom: 10, top: 5, right: 20),
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
      body: DataTableDynamic(
        page: ref.read(activitiesProvider).indexPage + 1,
        totalPage: ref.read(activitiesProvider).pageCount,
        getNextData: () {
          listPatients.getNextActivities();
        },
        getPreviousData: () {
          listPatients.getPreviusActivities();
        },
        headersRows: headersRowsActivity,
        data: generateActivity(ref: ref),
      ),
      drawer: const SideMenu(),
    );
  }
}

List<String> headersRowsActivity = [
  S.current.Nombre,
  S.current.Fase,
  S.current.Puntos,
  S.current.Opciones,
];

Iterable<TableRow> generateActivity({required WidgetRef ref}) {
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
