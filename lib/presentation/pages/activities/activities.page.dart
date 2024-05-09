import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/presentation/providers/providers.dart';
import 'package:hope_app/presentation/utils/utils.dart';
import 'package:hope_app/presentation/widgets/widgets.dart';

class ActivitiesPage extends ConsumerStatefulWidget {
  const ActivitiesPage({super.key});

  @override
  ActivitiesPageState createState() => ActivitiesPageState();
}

class ActivitiesPageState extends ConsumerState<ActivitiesPage> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    final listActivities = ref.read(activitiesProvider.notifier);
    scrollController.addListener(() {
      if ((scrollController.position.pixels + 150) >=
          scrollController.position.maxScrollExtent) {
        listActivities.getNextActivities();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchActivity = ref.watch(searchNameActivity);

    final listaActividades = ref.watch(activitiesProvider);
    final TextEditingController controller =
        TextEditingController(text: searchActivity);
    final textLength = controller.value.text.length;
    controller.selection = TextSelection.collapsed(offset: textLength);

    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.Actividades),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 7.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 20),
            InputForm(
              value: searchActivity,
              enable: true,
              label: S.current.Buscar_por_nombre_de_actividad,
              marginBottom: 0,
              onChanged: (value) =>
                  ref.read(searchNameActivity.notifier).state = value,
              isSearch: true,
              suffixIcon: searchActivity.isEmpty
                  ? const Icon(
                      Icons.search,
                    )
                  : IconButton(
                      onPressed: () {
                        ref.read(searchNameActivity.notifier).state = '';
                      },
                      icon: const Icon(Icons.clear),
                    ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 15, right: 15),
              alignment: Alignment.centerRight,
              child: ButtonTextIcon(
                title: S.current.Crear_actividad,
                icon: const Icon(Icons.add),
                buttonColor: $colorSuccess,
                onClic: () => context.push('/newActivity'),
              ),
            ),
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                //TODO: Cambiar cuando este listo el endpoint
                itemCount: listaActividades.totalActivities.length + 1,
                itemBuilder: (context, index) {
                  //TODO: Cambiar el 14 cuando este listo el endpoint
                  if (index < listaActividades.totalActivities.length) {
                    return ListTileCustom(
                      //TODO: Cambiar cuando este listo el endpoint
                      title: 'Seleccionar 5 pictogramas de animales',
                      //TODO: Cambiar cuando este listo el endpoint
                      subTitle: 'Fase 4 | 20 puntos',
                      //TODO: Cambiar cuando este listo el endpoint
                      iconButton: MenuItems(
                        idChild: int.parse(
                            listaActividades.totalActivities[index].id),
                        menuItems: menuActivity,
                      ),
                    );
                  } else {
                    return const SizedBox(height: 75);
                  }
                },
              ),
            )
          ],
        ),
      ),
      drawer: const SideMenu(),
    );
  }
}
