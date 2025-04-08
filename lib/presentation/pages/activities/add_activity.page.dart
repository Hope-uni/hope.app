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
      appBar: AppBar(title: Text(S.current.Asignar_actividad)),
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
                          S.current.Seleccion_de_ninos_para_actividad,
                          S.current.Confirmacion
                        ],
                        totalSteps: totalSteps,
                        width: size.width,
                        curStep: currentStep,
                        stepCompleteColor: $colorPrimary,
                        currentStepColor: $colorPrimary50,
                        inactiveColor: $colorButtonDisable,
                        lineWidth: 3.5,
                      ),
                      const SizedBox(height: 25),
                      Visibility(
                        visible: currentStep == 1 ? true : false,
                        child: InputForm(
                          value: '',
                          enable: true,
                          label: S.current.Busqueda_por_nombre,
                          marginBottom: 0,
                          isSearch: true,
                          //TODO: Implementar condicional con provider cuando este listo el endpoint
                          suffixIcon: true
                              ? const Icon(
                                  Icons.search,
                                )
                              : IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.clear),
                                ),
                        ),
                      ),
                      currentStep < totalSteps
                          ? Expanded(
                              child: ListView.builder(
                                controller: scrollController,
                                itemCount: stateChildren.length + 1,
                                itemBuilder: (context, index) {
                                  if (index < stateChildren.length) {
                                    return ListTileCustom(
                                      title: stateChildren[index].fullName,
                                      subTitle:
                                          '${stateChildren[index].age} ${S.current.Anos}\n${S.current.Fase}: ${stateChildren[index].currentPhase.name}',
                                      image: stateChildren[index].image,
                                      colorItemSelect: stateActiviyChildren
                                              .children
                                              .map((item) => item.id)
                                              .contains(stateChildren[index].id)
                                          ? $colorPrimary50
                                          : null,
                                      iconButton: CheckBoxCustom(
                                        valueInitial: stateActiviyChildren
                                                .children
                                                .map((item) => item.id)
                                                .contains(
                                                    stateChildren[index].id)
                                            ? true
                                            : false,
                                        onChange: (bool? value) {
                                          if (value == true) {
                                            notifierActiviyChildren.addChild(
                                              child: stateChildren[index],
                                            );
                                          }
                                          if (value == false) {
                                            notifierActiviyChildren.removeChild(
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
                                      fit: BoxFit.contain,
                                      'assets/svg/SinDatos.svg',
                                    )
                                  : ListView.builder(
                                      itemCount:
                                          stateActiviyChildren.children.length +
                                              1,
                                      itemBuilder: (context, index) {
                                        if (index <
                                            stateActiviyChildren
                                                .children.length) {
                                          return ListTileCustom(
                                            subTitle:
                                                '${stateActiviyChildren.children[index].age} ${S.current.Anos}\n${S.current.Fase}: ${stateActiviyChildren.children[index].currentPhase.name}',
                                            image: stateActiviyChildren
                                                .children[index].image,
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
                        ? SvgPicture.asset(
                            fit: BoxFit.contain,
                            'assets/svg/SinDatos.svg',
                          )
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
            onTap: () {
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
                notifierActiviyChildren.assingActivity(
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
