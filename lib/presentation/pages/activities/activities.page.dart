import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hope_app/domain/domain.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/presentation/providers/providers.dart';
import 'package:hope_app/presentation/utils/utils.dart';
import 'package:hope_app/presentation/widgets/widgets.dart';
import 'package:toastification/toastification.dart';

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
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (mounted) {
        ref.read(activitiesProvider.notifier).updateResponse();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();

    Future.microtask(() async {
      final notifierActivities = ref.read(activitiesProvider.notifier);
      final stateActivities = ref.read(activitiesProvider);

      if (stateActivities.paginateActivities[$indexPage]! == 1) {
        await notifierActivities.getActivities();
      }

      scrollController.addListener(() async {
        final stateActivities = ref.read(activitiesProvider);
        if ((scrollController.position.pixels + 50) >=
                scrollController.position.maxScrollExtent &&
            stateActivities.isLoading == false) {
          if (stateActivities.paginateActivities[$indexPage]! > 1 &&
              stateActivities.paginateActivities[$indexPage]! <=
                  stateActivities.paginateActivities[$pageCount]!) {
            await notifierActivities.getActivities();
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final searchActivity = ref.watch(searchNameActivity);

    final stateActivities = ref.read(activitiesProvider);
    final stateWacthActivities = ref.watch(activitiesProvider);
    final stateActivity = ref.watch(activityProvider);

    final TextEditingController controller =
        TextEditingController(text: searchActivity);

    final textLength = controller.value.text.length;
    controller.selection = TextSelection.collapsed(offset: textLength);

    ref.listen(activitiesProvider, (previous, next) {
      if (next.errorMessageApi != null) {
        toastAlert(
          context: context,
          title: S.current.Error,
          description: next.errorMessageApi!,
          typeAlert: ToastificationType.error,
        );
        ref.read(activitiesProvider.notifier).updateResponse();
      }
    });

    ref.listen(activityProvider, (previous, next) {
      if (next.isDelete == true) {
        toastAlert(
          iconAlert: const Icon(Icons.check),
          context: context,
          title: S.current.Eliminacion_exitosa,
          description:
              S.current.Se_elimino_correctamente_la_actividad_seleccionada,
          typeAlert: ToastificationType.success,
        );
        ref.read(activityProvider.notifier).updateIsDelete();
        ref.read(activitiesProvider.notifier).resetState();
        ref.read(activitiesProvider.notifier).getActivities();
      }

      if (next.errorMessageApi != null) {
        toastAlert(
          context: context,
          title: S.current.Error,
          description: next.errorMessageApi!,
          typeAlert: ToastificationType.error,
        );
        ref.read(activityProvider.notifier).updateResponse();
      }
    });

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: Text(S.current.Actividades),
            actions: [
              Container(
                margin: const EdgeInsets.only(right: 15),
                child: IconButton(
                  icon: const Icon(Icons.help),
                  onPressed: () {
                    showDialog<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20)),
                              color: $colorBlueGeneral,
                            ),
                            padding: const EdgeInsets.only(
                                left: 22, top: 20, bottom: 20),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              S.current.Ayuda,
                              style: const TextStyle(
                                color: $colorTextWhite,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          titlePadding: EdgeInsets.zero,
                          content: SizedBox(
                            width: 200,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  S.current.Para_ver_el_detalle_de_la_actividad,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  S.current
                                      .Hacer_clic_sobre_el_registro_deseado,
                                ),
                                const SizedBox(height: 30),
                                Text(
                                  S.current
                                      .Para_refrescar_el_listado_de_actividades,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  S.current
                                      .Deslizar_el_dedo_desde_arriba_hacia_abajo_en_la_parte_superior_de_la_pantalla,
                                ),
                                const SizedBox(height: 30),
                                Text(
                                  S.current.Para_crear_actividades,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  S.current
                                      .Hacer_clic_sobre_el_boton_verde_en_la_parte_inferior_derecha_de_la_pantalla,
                                ),
                              ],
                            ),
                          ),
                          insetPadding: EdgeInsets.zero,
                        );
                      },
                    );
                  },
                ),
              ),
            ],
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
                Expanded(
                  child: Stack(
                    children: [
                      if (stateWacthActivities.paginateActivities[$indexPage] !=
                          1)
                        SizedBox.expand(
                          child: stateWacthActivities.activities.isNotEmpty
                              ? ListView.builder(
                                  controller: scrollController,
                                  itemCount:
                                      stateActivities.activities.length + 1,
                                  itemBuilder: (context, index) {
                                    if (index <
                                        stateActivities.activities.length) {
                                      final item =
                                          stateActivities.activities[index];
                                      return ListTileCustom(
                                          title: item.name,
                                          colorTitle: true,
                                          styleTitle: FontWeight.bold,
                                          subTitle:
                                              '${S.current.Fase}: ${item.phase.name}\n${S.current.Puntos_requeridos}: ${item.satisfactoryPoints}\nPacientes asignados: ${item.assignments == null ? 0 : item.assignments!.length}',
                                          iconButton: MenuItems(
                                            itemObject: CatalogObject(
                                              id: stateActivities
                                                  .activities[index].id,
                                              name: stateActivities
                                                  .activities[index].name,
                                              description: '',
                                            ),
                                            menuItems: menuActivity,
                                          ),
                                          noImage: true,
                                          onTap: () {
                                            context.pushNamed(
                                              $activity,
                                              pathParameters: {
                                                $idActivity: item.id.toString()
                                              },
                                            );
                                          });
                                    } else {
                                      return const SizedBox(height: 75);
                                    }
                                  },
                                )
                              : SvgPicture.asset(
                                  fit: BoxFit.contain,
                                  'assets/svg/SinDatos.svg',
                                ),
                        ),

                      if (stateWacthActivities.isLoading == true &&
                          stateWacthActivities.paginateActivities[$indexPage] !=
                              1)
                        const Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      // 🔄 LOADING

                      if (stateWacthActivities.paginateActivities[$indexPage] ==
                          1) ...[
                        const Opacity(
                          opacity: 0.5,
                          child: ModalBarrier(
                              dismissible: false, color: $colorTransparent),
                        ),
                        Center(
                          child: stateWacthActivities.isErrorInitial == true
                              ? SvgPicture.asset(
                                  fit: BoxFit.contain,
                                  'assets/svg/SinDatos.svg',
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const CircularProgressIndicator(),
                                    const SizedBox(height: 25),
                                    Text(
                                      S.current.Cargando,
                                      style: const TextStyle(
                                        color: $colorButtonDisable,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ],
                    ],
                  ),
                )
              ],
            ),
          ),
          floatingActionButton:
              stateWacthActivities.paginateActivities[$indexPage] == 1
                  ? null
                  : SpeedDial(
                      icon: Icons.add,
                      backgroundColor: $colorSuccess,
                      foregroundColor: $colorTextWhite,
                      elevation: 8.0,
                      shape: const CircleBorder(),
                      onOpen: () => context.push('/newActivity'),
                    ),
          drawer: const SideMenu(),
        ),
        if (stateActivity.isLoading == true)
          const Opacity(
            opacity: 0.5,
            child: ModalBarrier(dismissible: false, color: $colorTextBlack),
          ),
        if (stateActivity.isLoading == true)
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(height: 25),
                Text(
                  S.current.Cargando,
                  style: const TextStyle(
                    color: $colorTextWhite,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
