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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(S.current.Actividades),
            const SizedBox(
              width: 10,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(35),
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 5, left: 40, right: 40),
            alignment: Alignment.centerRight,
            child: ButtonTextIcon(
              title: S.current.Crear_actividad,
              icon: const Icon(Icons.add),
              buttonColor: $colorSuccess,
              onClic: () {},
            ),
          ),
          SizedBox(
            height: size.height * (isTablet(context) ? 0.75 : 0.65),
            child: DataTableDynamic(
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
          ),
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
