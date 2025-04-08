import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/presentation/pages/activities/form_activity.dart';
import 'package:hope_app/presentation/providers/providers.dart';
import 'package:hope_app/presentation/utils/utils.dart';
import 'package:hope_app/presentation/widgets/widgets.dart';
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
            : Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ButtonTextIcon(
                    title: S.current.Guardar,
                    icon: const Icon(Icons.save),
                    buttonColor: $colorSuccess,
                    onClic: () {
                      setState(() {
                        FocusManager.instance.primaryFocus?.unfocus();
                      });
                      Future.delayed(const Duration(milliseconds: 200), () {
                        //TODO: Actualizar permiso cuando esten listos en la api
                        if (profileState.permmisions!
                            .contains($updateProfile)) {
                          notifierActivity.updateIsSave(isSave: true);

                          if (notifierActivity.checkFields()) {
                            if (context.mounted) {
                              modalDialogConfirmation(
                                context: context,
                                titleButtonConfirm: S.current.Si_guardar,
                                question: RichText(
                                  textAlign: TextAlign.center,
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
                  const SizedBox(width: 10),
                  ButtonTextIcon(
                    title: S.current.Cancelar,
                    icon: const Icon(Icons.cancel),
                    buttonColor: $colorError,
                    onClic: () {
                      modalDialogConfirmation(
                        context: context,
                        titleButtonConfirm: S.current.Si_salir,
                        question: RichText(
                          textAlign: TextAlign.center,
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
