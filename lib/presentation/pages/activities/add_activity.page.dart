import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/presentation/providers/providers.dart';
import 'package:hope_app/presentation/utils/utils.dart';
import 'package:hope_app/presentation/widgets/widgets.dart';
import 'package:toastification/toastification.dart';

class AddActivityPage extends ConsumerStatefulWidget {
  final int idActivity;
  const AddActivityPage({super.key, required this.idActivity});

  @override
  AddActivityPageState createState() => AddActivityPageState();
}

class AddActivityPageState extends ConsumerState<AddActivityPage> {
  int currentStep = 1;
  double totalSteps = 2;
  bool isCompleted = false;

  final scrollController = ScrollController();

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();

    Future.microtask(() async {
      final notifierChildren = ref.read(childrenProvider.notifier);
      final statechildren = ref.read(childrenProvider);

      if (statechildren.paginateChildren[$indexPage]! == 1) {
        await notifierChildren.getChildrenforActivity(
          idActivity: widget.idActivity,
        );
      }

      scrollController.addListener(() async {
        final stateChildren = ref.read(childrenProvider);
        if ((scrollController.position.pixels + 50) >=
                scrollController.position.maxScrollExtent &&
            stateChildren.isLoading == false) {
          if (stateChildren.paginateChildren[$indexPage]! > 1 &&
              stateChildren.paginateChildren[$indexPage]! <=
                  stateChildren.paginateChildren[$pageCount]!) {
            await notifierChildren.getChildrenforActivity(
              idActivity: widget.idActivity,
            );
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final notifierActiviyChildren = ref.read(activityChildrenProvider.notifier);
    final stateActiviyChildren = ref.watch(activityChildrenProvider);
    final stateWacthChildren = ref.watch(childrenProvider);
    final stateChildren = ref.watch(childrenProvider).children;

    ref.listen(activityChildrenProvider, (previous, next) {
      if (next.isLoading == false && next.isSave == true) {
        toastAlert(
          iconAlert: const Icon(Icons.save),
          context: context,
          title: S.current.Asignacion_exitosa,
          description: S.current
              .Se_asigno_correctamente_la_actividad_a_los_ninos_seleccionados,
          typeAlert: ToastificationType.success,
        );
        setState(() => isCompleted = true);
        notifierActiviyChildren.updateResponse();
      }

      if (next.errorMessageApi != null) {
        toastAlert(
          context: context,
          title: S.current.Error,
          description: next.errorMessageApi!,
          typeAlert: ToastificationType.error,
        );
        notifierActiviyChildren.updateResponse();
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Tooltip(
          message: S.current.Asignar_actividad, // Muestra el nombre completo
          waitDuration:
              const Duration(milliseconds: 100), // Espera antes de mostrarse
          showDuration: const Duration(seconds: 2), // Tiempo visible
          child: Text(S.current.Asignar_actividad),
        ),
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
                      content: SingleChildScrollView(
                        child: SizedBox(
                          width: 200,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                S.current
                                    .Para_ver_la_foto_de_perfil_de_los_pacientes_con_mas_detalle,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                S.current.Hacer_doble_clic_sobre_la_imagen,
                              ),
                              const SizedBox(height: 30),
                              Text(
                                S.current.Flujo_para_asignacion_de_actividad,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                S.current
                                    .Seleccione_los_pacientes_a_los_cuales_desea_agregar_la_actividad_dando_clic_en_el_cuadro_a_la_derecha_del_registro,
                              ),
                              const SizedBox(height: 10),
                              Text(S.current
                                  .Avanzar_al_siguiente_paso_dando_clic_en_el_boton_de_la_esquina_inferior_derecha),
                              const SizedBox(height: 10),
                              Text(S.current
                                  .Si_desea_eliminar_un_paciente_de_la_lista_de_asignacion_hacer_clic_sobre_el_icono_rojo_del_basurero),
                              const SizedBox(height: 10),
                              Text(S.current
                                  .Para_finalizar_asignacion_hacer_clic_sobre_el_boton_en_la_esquina_inferior_derecha_y_seleccionar_la_opcion_de_guardar),
                              const SizedBox(height: 30),
                              Text(
                                S.current
                                    .Para_listar_los_pacientes_disponibles_se_aplican_los_siguientes_filtros,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 10),
                              Text(S.current
                                  .El_paciente_pertenezca_a_la_misma_fase_de_la_actividad),
                              const SizedBox(height: 10),
                              Text(S.current
                                  .El_paciente_no_tenga_actividad_asignada),
                              const SizedBox(height: 10),
                              Text(S
                                  .current.El_paciente_se_encuentre_verificado),
                              const SizedBox(height: 10),
                              Text(S.current
                                  .El_paciente_tenga_terapeuta_asignado),
                              const SizedBox(height: 30),
                              Text(
                                S.current
                                    .Si_el_titulo_de_la_pantalla_no_se_muestra_completo_puede,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                S.current
                                    .Mantener_el_dedo_sobre_el_titulo_durante_1_segundo_para_verlo_completo,
                              ),
                            ],
                          ),
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
      body: SizedBox(
        height: size.height,
        child: stateWacthChildren.paginateChildren[$indexPage] != 1
            ? Stack(children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 7.5),
                  child: Column(
                    children: [
                      StepperCustom(
                        labelSteps: [
                          S.current.Seleccion_de_ninos,
                          S.current.Confirmacion
                        ],
                        totalSteps: totalSteps,
                        width: size.width,
                        curStep: currentStep,
                        isCompleted: isCompleted,
                        stepCompleteColor: $colorPrimary,
                        currentStepColor: $colorPrimary50,
                        inactiveColor: $colorButtonDisable,
                        lineWidth: 3.5,
                      ),
                      currentStep < totalSteps
                          ? Expanded(
                              child: stateChildren.isEmpty
                                  ? SvgPicture.asset(
                                      fit: BoxFit.contain,
                                      $noData,
                                    )
                                  : ListView.builder(
                                      controller: scrollController,
                                      itemCount: stateChildren.length + 1,
                                      itemBuilder: (context, index) {
                                        if (index < stateChildren.length) {
                                          return ListTileCustom(
                                            title:
                                                stateChildren[index].fullName,
                                            subTitle: RichText(
                                              text: TextSpan(
                                                  style: const TextStyle(
                                                    color: $colorTextBlack,
                                                    fontSize: 13,
                                                  ),
                                                  text:
                                                      '${stateChildren[index].age} ${S.current.Anos}\n${S.current.Fase}: ${stateChildren[index].currentPhase.name}'),
                                            ),
                                            image:
                                                stateChildren[index].imageUrl,
                                            colorItemSelect:
                                                stateActiviyChildren.children
                                                        .map((item) => item.id)
                                                        .contains(
                                                            stateChildren[index]
                                                                .id)
                                                    ? $colorPrimary50
                                                    : null,
                                            iconButton: CheckBoxCustom(
                                              valueInitial: stateActiviyChildren
                                                      .children
                                                      .map((item) => item.id)
                                                      .contains(
                                                          stateChildren[index]
                                                              .id)
                                                  ? true
                                                  : false,
                                              onChange: (bool? value) {
                                                if (value == true) {
                                                  notifierActiviyChildren
                                                      .addChild(
                                                    child: stateChildren[index],
                                                  );
                                                }
                                                if (value == false) {
                                                  notifierActiviyChildren
                                                      .removeChild(
                                                    child: stateChildren[index],
                                                  );
                                                }
                                              },
                                            ),
                                          );
                                        } else {
                                          return const SizedBox(height: 75);
                                        }
                                      },
                                    ),
                            )
                          : Expanded(
                              child: stateActiviyChildren.children.isEmpty
                                  ? SvgPicture.asset(
                                      fit: BoxFit.contain, $noData)
                                  : ListView.builder(
                                      itemCount:
                                          stateActiviyChildren.children.length +
                                              1,
                                      itemBuilder: (context, index) {
                                        if (index <
                                            stateActiviyChildren
                                                .children.length) {
                                          return ListTileCustom(
                                            subTitle: RichText(
                                              text: TextSpan(
                                                style: const TextStyle(
                                                  color: $colorTextBlack,
                                                  fontSize: 13,
                                                ),
                                                text:
                                                    '${stateActiviyChildren.children[index].age} ${S.current.Anos}\n${S.current.Fase}: ${stateActiviyChildren.children[index].currentPhase.name}',
                                              ),
                                            ),
                                            image: stateActiviyChildren
                                                .children[index].imageUrl,
                                            title: stateActiviyChildren
                                                .children[index].fullName,
                                            iconButton: stateActiviyChildren
                                                        .isComplete ==
                                                    true
                                                ? null
                                                : IconButton(
                                                    onPressed: () {
                                                      notifierActiviyChildren
                                                          .removeChild(
                                                        child:
                                                            stateActiviyChildren
                                                                    .children[
                                                                index],
                                                      );
                                                    },
                                                    icon: const Icon(
                                                      Icons.delete,
                                                      color: $colorError,
                                                    ),
                                                  ),
                                          );
                                        } else {
                                          return const SizedBox(height: 75);
                                        }
                                      },
                                    ),
                            ),
                    ],
                  ),
                ),
                if (stateWacthChildren.isLoading == true &&
                    stateWacthChildren.paginateChildren[$indexPage] != 1)
                  const Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: CircularProgressIndicator(),
                    ),
                  ),
                if (stateActiviyChildren.isLoading == true)
                  const Opacity(
                    opacity: 0.5,
                    child: ModalBarrier(
                        dismissible: false, color: $colorTextBlack),
                  ),
                if (stateActiviyChildren.isLoading == true)
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
              ])
            : Stack(
                children: [
                  const Opacity(
                    opacity: 0.5,
                    child: ModalBarrier(
                        dismissible: false, color: $colorTransparent),
                  ),
                  Center(
                    child: stateWacthChildren.isErrorInitial == true
                        ? SvgPicture.asset(fit: BoxFit.contain, $noData)
                        : Column(
                            mainAxisSize: MainAxisSize.min,
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
              ),
      ),
      floatingActionButton: SpeedDial(
        visible: stateActiviyChildren.isComplete == false &&
            stateActiviyChildren.isLoading == false &&
            stateWacthChildren.paginateChildren[$indexPage] != 1,
        icon: currentStep > 1 ? Icons.expand_less : Icons.keyboard_arrow_right,
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
        tooltip: currentStep != totalSteps ? S.current.Siguiente : null,
        onPress: currentStep != totalSteps
            ? () {
                if (stateActiviyChildren.children.isEmpty) {
                  toastAlert(
                    iconAlert: const Icon(Icons.info),
                    context: context,
                    title: S.current.Aviso,
                    description: S.current
                        .Seleccione_al_menos_a_un_paciente_para_la_actividad,
                    typeAlert: ToastificationType.info,
                  );
                  return;
                }

                if (currentStep < totalSteps) {
                  _goTo(currentStep + 1);
                }
              }
            : null,
        shape: const CircleBorder(),
        children: [
          SpeedDialChild(
            visible: currentStep > 1,
            shape: const CircleBorder(),
            child:
                const Icon(Icons.keyboard_arrow_left, color: $colorTextBlack),
            backgroundColor: $colorSelectMenu,
            label: S.current.Regresar,
            onTap: () {
              if (currentStep <= totalSteps && currentStep > 1) {
                _goTo(currentStep - 1);
              }
            },
          ),
          SpeedDialChild(
            visible: currentStep == totalSteps,
            shape: const CircleBorder(),
            child: const Icon(Icons.save, color: $colorTextWhite),
            backgroundColor: $colorSuccess,
            label: S.current.Guardar,
            onTap: () async {
              if (stateActiviyChildren.children.isEmpty) {
                toastAlert(
                  iconAlert: const Icon(Icons.info),
                  context: context,
                  title: S.current.Aviso,
                  description: S.current
                      .Seleccione_al_menos_a_un_paciente_para_la_actividad,
                  typeAlert: ToastificationType.info,
                );
              } else {
                await notifierActiviyChildren.assingActivity(
                  idActivity: widget.idActivity,
                );
              }
            },
          ),
        ],
      ),
    );
  }

  void _goTo(int step) {
    setState(() => currentStep = step);
  }
}
