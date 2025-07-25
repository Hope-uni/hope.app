import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hope_app/domain/domain.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/infrastructure/repositories/key_value_storage.repository.impl.dart'
    show KeyValueStorageRepositoryImpl;
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
  final KeyValueStorageRepositoryImpl storageProfile =
      KeyValueStorageRepositoryImpl();
  int? idUser;
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (mounted) {
        ref.read(activitiesProvider.notifier).resetState();
        idUser = await storageProfile.getValueStorage<int>($idUser);
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
    final stateActivity = ref.watch(activityProvider);
    final stateActivities = ref.read(activitiesProvider);
    final stateWacthActivities = ref.watch(activitiesProvider);
    final profileState = ref.read(profileProvider);

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

      if (next.errorMessageApiDelete != null) {
        toastAlert(
          context: context,
          title: S.current.Error,
          description: next.errorMessageApiDelete!,
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
                                const SizedBox(height: 30),
                                Text(
                                  S.current
                                      .Para_verificar_la_actividad_asignada_a_un_paciente,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  S.current
                                      .Debe_presionar_el_boton_de_validar_la_actividad_durante_tres_segundos_desde_el_tablero_de_comunicacion,
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
                Expanded(
                  child: Stack(
                    children: [
                      if (stateWacthActivities.paginateActivities[$indexPage] !=
                          1)
                        SizedBox.expand(
                          child: stateWacthActivities.activities.isNotEmpty
                              ? ListView.builder(
                                  padding: const EdgeInsets.only(top: 10),
                                  controller: scrollController,
                                  itemCount:
                                      stateActivities.activities.length + 1,
                                  itemBuilder: (context, index) {
                                    if (index <
                                        stateActivities.activities.length) {
                                      final item =
                                          stateActivities.activities[index];

                                      if (index == 0) {
                                        return Column(
                                          children: [
                                            Container(
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                  vertical: 10,
                                                  horizontal: 15,
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    const Text(
                                                      'Actividades Propias',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 5),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        color: $colorPrimary50,
                                                        border: Border.all(
                                                          width: 0.5,
                                                        ),
                                                      ),
                                                      width: 20,
                                                      height: 20,
                                                    ),
                                                  ],
                                                )),
                                            ListTileCustom(
                                                colorItemSelect:
                                                    idUser == item.user.id
                                                        ? $colorPrimary50
                                                        : null,
                                                title: item.name,
                                                colorTitle: true,
                                                styleTitle: FontWeight.bold,
                                                subTitle: RichText(
                                                  text: TextSpan(
                                                      style: const TextStyle(
                                                        color: $colorTextBlack,
                                                        fontSize: 13,
                                                      ),
                                                      text:
                                                          '${S.current.Fase}: ${item.phase.name}\n${S.current.Puntos_requeridos}: ${item.satisfactoryPoints}\nPacientes asignados: ${item.assignments == null ? 0 : item.assignments!.length}'),
                                                ),
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
                                                      $idActivity:
                                                          item.id.toString()
                                                    },
                                                  );
                                                }),
                                          ],
                                        );
                                      }

                                      return ListTileCustom(
                                          colorItemSelect:
                                              idUser == item.user.id
                                                  ? $colorPrimary50
                                                  : null,
                                          title: item.name,
                                          colorTitle: true,
                                          styleTitle: FontWeight.bold,
                                          subTitle: RichText(
                                            text: TextSpan(
                                                style: const TextStyle(
                                                  color: $colorTextBlack,
                                                  fontSize: 13,
                                                ),
                                                text:
                                                    '${S.current.Fase}: ${item.phase.name}\n${S.current.Puntos_requeridos}: ${item.satisfactoryPoints}\nPacientes asignados: ${item.assignments == null ? 0 : item.assignments!.length}'),
                                          ),
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
                              : SvgPicture.asset(fit: BoxFit.contain, $noData),
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
                              ? SvgPicture.asset(fit: BoxFit.contain, $noData)
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
                      onOpen: () {
                        if (profileState.permmisions!
                            .contains($createActivity)) {
                          context.push('/newActivity');
                        } else {
                          if (context.mounted) {
                            toastAlert(
                              iconAlert: const Icon(Icons.info),
                              context: context,
                              title: S.current.No_autorizado,
                              description:
                                  S.current.No_cuenta_con_el_permiso_necesario,
                              typeAlert: ToastificationType.info,
                            );
                          }
                        }
                      }),
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
