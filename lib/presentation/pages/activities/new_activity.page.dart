import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:go_router/go_router.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/presentation/pages/activities/form_activity.dart';
import 'package:hope_app/presentation/providers/providers.dart';
import 'package:hope_app/presentation/utils/utils.dart';
import 'package:toastification/toastification.dart';

class NewActivityPage extends ConsumerStatefulWidget {
  const NewActivityPage({super.key});

  @override
  NewActivityState createState() => NewActivityState();
}

class NewActivityState extends ConsumerState<NewActivityPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (mounted) {
        ref.read(activityProvider.notifier).resetState();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final notifierActivity = ref.read(activityProvider.notifier);
    final profileState = ref.read(profileProvider);

    final statePictograms = ref.watch(pictogramsProvider);
    final statePhases = ref.watch(phasesProvider);

    ref.listen(activityProvider, (_, next) {
      if (next.showActivity != null) {
        context.pushReplacementNamed(
          $activity,
          pathParameters: {
            $idActivity: next.showActivity!.id.toString(),
          },
        );
      }
    });

    return GestureDetector(
      onTap: () {
        setState(() {
          FocusManager.instance.primaryFocus?.unfocus();
        });
      },
      child: Scaffold(
        appBar: AppBar(
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
                                S.current.Para_reordenar_la_solucion,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 10),
                              Text(S.current
                                  .Mantener_el_dedo_sobre_el_pictograma_de_la_solucion_para_poder_ordenarlo_a_su_voluntad),
                              const SizedBox(height: 30),
                              Text(
                                S.current.Para_ver_la_imagen_con_mas_detalle,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                S.current.Hacer_doble_clic_sobre_la_imagen,
                              ),
                              const SizedBox(height: 30),
                              Text(
                                S.current.Acciones_en_el_listado_de_pictogramas,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                S.current
                                    .Puede_desplazarse_de_manera_horizontal_en_los_pictogramas_para_poder_ver_mas_registros,
                              ),
                              const SizedBox(height: 10),
                              Text(S.current
                                  .Si_desea_agregar_un_pictograma_a_la_solucion_debe_dar_clic_en_el_boton_verde_con_el_icono_de_listo),
                              const SizedBox(height: 10),
                              Text(
                                S.current
                                    .Si_desea_eliminar_un_pictograma_a_la_solucion_debe_dar_clic_en_el_boton_rojo_con_el_icono_del_basurero,
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
          title: Text(S.current.Crear_actividad),
        ),
        body: const FormActivity(),
        floatingActionButton: statePictograms.paginatePictograms[$indexPage] ==
                    1 ||
                statePhases.isLoading == true
            ? null
            : SpeedDial(
                icon: Icons.expand_less,
                activeIcon: Icons.expand_more,
                animationDuration: const Duration(milliseconds: 300),
                spacing: 3,
                overlayColor: $colorShadow,
                overlayOpacity: 0.2,
                childPadding: const EdgeInsets.all(5),
                spaceBetweenChildren: 4,
                elevation: 8.0,
                animationCurve: Curves.easeInOut,
                isOpenOnStart: false,
                shape: const CircleBorder(),
                onOpen: () {
                  setState(() {
                    FocusManager.instance.primaryFocus?.unfocus();
                  });
                },
                children: [
                  SpeedDialChild(
                    shape: const CircleBorder(),
                    child: const Icon(Icons.save, color: $colorTextWhite),
                    backgroundColor: $colorSuccess,
                    label: S.current.Guardar,
                    onTap: () {
                      setState(() {
                        FocusManager.instance.primaryFocus?.unfocus();
                      });
                      Future.delayed(const Duration(milliseconds: 200), () {
                        if (profileState.permmisions!
                            .contains($createActivity)) {
                          notifierActivity.updateIsSave(isSave: true);

                          if (notifierActivity.checkFields()) {
                            if (context.mounted) {
                              modalDialogConfirmation(
                                context: context,
                                titleButtonConfirm: S.current.Si_guardar,
                                question: RichText(
                                  text: TextSpan(
                                    text: S.current
                                        .Esta_seguro_de_crear_la_actividad,
                                    style: const TextStyle(
                                        fontSize: 14, color: $colorTextBlack),
                                  ),
                                ),
                                buttonColorConfirm: $colorSuccess,
                                onClic: () async {
                                  if (context.mounted) {
                                    Navigator.of(context).pop();
                                    await notifierActivity.createActivity();
                                  }
                                },
                              );
                            }
                          }
                          notifierActivity.updateIsSave(isSave: false);
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
                      });
                    },
                  ),
                  SpeedDialChild(
                    shape: const CircleBorder(),
                    child: const Icon(Icons.cancel, color: $colorTextWhite),
                    backgroundColor: $colorError,
                    label: S.current.Cancelar,
                    onTap: () {
                      modalDialogConfirmation(
                        context: context,
                        titleButtonConfirm: S.current.Si_salir,
                        question: RichText(
                          text: TextSpan(
                            text: S.current
                                .Esta_seguro_de_salir_de_la_creacion_de_la_actividad,
                            style: const TextStyle(
                              fontSize: 16,
                              color: $colorTextBlack,
                            ),
                          ),
                        ),
                        buttonColorConfirm: $colorSuccess,
                        onClic: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        },
                      );
                    },
                  ),
                ],
              ),
      ),
    );
  }
}
