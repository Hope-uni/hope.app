import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/presentation/providers/providers.dart';
import 'package:hope_app/presentation/utils/utils.dart';
import 'package:hope_app/presentation/widgets/widgets.dart';

class ActivitiesPage extends ConsumerWidget {
  const ActivitiesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchActivity = ref.watch(searchNameActivity);
    final listPatients = ref.watch(activitiesProvider.notifier);
    final TextEditingController controller =
        TextEditingController(text: searchActivity);
    final textLength = controller.value.text.length;
    controller.selection = TextSelection.collapsed(offset: textLength);

    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.Actividades),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 13),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Container(
                    margin:
                        const EdgeInsets.only(bottom: 10, top: 10, right: 10),
                    alignment: Alignment.centerRight,
                    child: ButtonTextIcon(
                      title: S.current.Crear_actividad,
                      icon: const Icon(Icons.add),
                      buttonColor: $colorSuccess,
                      onClic: () => context.push('/newActivity'),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35),
                    ),
                    height: 40,
                    width: 190,
                    margin:
                        const EdgeInsets.only(bottom: 10, top: 10, right: 20),
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
          ],
        ),
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
  bool isColor = false;
  final listaDataRow = listaActividades.newActivities.map((item) {
    isColor = !isColor;
    return TableRow(
      decoration: BoxDecoration(color: isColor ? null : $colorRowTable),
      children: <Widget>[
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Container(
            margin: const EdgeInsets.only(left: 15),
            child: Text(item.fullName),
          ),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Container(
            alignment: Alignment.center,
            child: Text(item.fase),
          ),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Container(
            alignment: Alignment.center,
            child: Text(item.edad),
          ),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Container(
            margin: const EdgeInsets.only(right: 15),
            child: MenuItems(
              idChild: int.parse(item.id),
              menuItems: menuActivity,
            ),
          ),
        ),
      ],
    );
  });
  return listaDataRow;
}
