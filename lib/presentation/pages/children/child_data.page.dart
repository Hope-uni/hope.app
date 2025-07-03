import 'dart:io';
import 'package:clearable_dropdown/clearable_dropdown.dart' as clearable;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hope_app/domain/domain.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/infrastructure/infrastructure.dart';
import 'package:hope_app/presentation/providers/providers.dart';
import 'package:hope_app/presentation/utils/utils.dart';
import 'package:hope_app/presentation/widgets/widgets.dart';
import 'package:intl/intl.dart';
import 'package:toastification/toastification.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class ChildDataPage extends ConsumerStatefulWidget {
  final int idChild;
  final Map<String, dynamic>? extra;

  const ChildDataPage({super.key, required this.idChild, required this.extra});

  @override
  ChildDataPageState createState() => ChildDataPageState();
}

class ChildDataPageState extends ConsumerState<ChildDataPage>
    with SingleTickerProviderStateMixin {
  bool enableInput = false;
  bool clickSave = false;
  bool _showRightArrow = true;
  bool _showLeftArrow = false;

  late TabController _tabController;
  final ScrollController _scrollController = ScrollController();
  final ScrollController _scrollControllerObservations = ScrollController();
  late final TextEditingController controllerDate = TextEditingController();

  final Map<String, FocusNode> focusNodes = {
    $userNameProfile: FocusNode(),
    $emailProfile: FocusNode(),
    $firstNameProfile: FocusNode(),
    $surnameProfile: FocusNode(),
    $addressProfile: FocusNode(),
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _scrollController.addListener(() {
      // Oculta la flecha si el scroll está al final
      if (_scrollController.offset >=
              _scrollController.position.maxScrollExtent &&
          !_scrollController.position.outOfRange) {
        setState(() {
          _showRightArrow = false;
          _showLeftArrow = true;
        });
      } else {
        setState(() {
          _showLeftArrow = false;
          _showRightArrow = true;
        });
      }
    });

    _tabController.addListener(
      () {
        // Evita scroll mientras aún se anima
        if (_tabController.indexIsChanging) return;
        // Esperar un frame para asegurar que el Tab esté renderizado
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _scrollToSelectedTab(_tabController.index);
        });
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _tabController.dispose();
    _scrollControllerObservations.dispose();
    controllerDate.dispose();
    super.dispose();
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();

    Future.microtask(() async {
      final notifierChild = ref.read(childProvider.notifier);
      await notifierChild.getChild(idChild: widget.idChild);
    });
  }

  void _scrollToSelectedTab(int tabIndex) {
    // Calcula la posición del tab que quieres mostrar
    // Puedes ajustar este valor si tus tabs son más grandes o más pequeños
    const double tabWidth = 150;
    final double offset = (tabIndex * tabWidth) -
        (MediaQuery.of(context).size.width / 2) +
        (tabWidth / 2);

    // Asegura que el scroll esté dentro de los límites
    final double scrollOffset = offset.clamp(
      _scrollController.position.minScrollExtent,
      _scrollController.position.maxScrollExtent,
    );

    _scrollController.animateTo(
      scrollOffset,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final stateProfile = ref.watch(profileProvider);
    final stateChild = ref.watch(childProvider);
    final statePhases = ref.watch(phasesProvider);
    final stateActivity = ref.watch(activityChildrenProvider);

    final notifierChild = ref.read(childProvider.notifier);
    final notifierPhases = ref.read(phasesProvider.notifier);
    final notifierActivityChildren =
        ref.read(activityChildrenProvider.notifier);

    ref.listen(childProvider, (previous, next) {
      if (next.validationErrors.isNotEmpty && clickSave) {
        String firstErrorKey = next.validationErrors.keys.first;
        focusNodes[firstErrorKey]?.requestFocus();

        Scrollable.ensureVisible(
          focusNodes[firstErrorKey]!.context!,
          duration: const Duration(milliseconds: 1000),
          curve: Curves.easeInOut,
          alignment: 0.5, // Opcional: Para centrar el widget en la pantalla
        );
      }

      if (next.isUpdateData == false && next.isComplete == true) {
        if (context.mounted) {
          toastAlert(
            iconAlert: const Icon(Icons.check),
            context: context,
            title: S.current.Actualizado_con_exito,
            description: S.current.Informacion_del_nino_actualizada,
            typeAlert: ToastificationType.info,
          );
          enableInput = false;
          notifierChild.updateResponse();
        }
      }

      if (next.isUpdateData == false && next.isUpdateMonochrome == true) {
        if (context.mounted) {
          toastAlert(
            iconAlert: const Icon(Icons.check),
            context: context,
            title: S.current.Actualizado_con_exito,
            description: S.current
                .Se_actualizo_el_filtro_blanco_y_negro_con_exito(
                    next.child!.isMonochrome == true
                        ? S.current.Activo
                        : S.current.Inactivo),
            typeAlert: ToastificationType.info,
          );
          notifierChild.updateResponse();
        }
      }

      if (next.isUnchanged == true) {
        toastAlert(
          context: context,
          title: S.current.Aviso,
          description: S.current.No_se_han_realizados_cambios_en_el_formulario,
          typeAlert: ToastificationType.info,
        );
        notifierChild.updateResponse();
      }

      if (next.errorMessageApi != null) {
        toastAlert(
          context: context,
          title: S.current.Error,
          description: next.errorMessageApi!,
          typeAlert: ToastificationType.error,
        );
        notifierChild.updateResponse();
      }
    });

    ref.listen(phasesProvider, (previous, next) {
      if (next.isLoading == false && next.isUpdate == true) {
        if (context.mounted) {
          toastAlert(
            context: context,
            title: S.current.Avance_de_fase_exitosa,
            description: S.current.Se_avanzo_a_la_fase(next.newPhase!),
            typeAlert: ToastificationType.success,
          );
          notifierPhases.updateResponse();
        }
      }

      if (next.errorMessageApi != null) {
        toastAlert(
          context: context,
          title: S.current.Error,
          description: next.errorMessageApi!,
          typeAlert: ToastificationType.error,
        );
        notifierPhases.updateResponse();
      }
    });

    ref.listen(activityChildrenProvider, (previous, next) {
      if (next.isLoading == false && next.isDelete == true) {
        if (context.mounted) {
          toastAlert(
            iconAlert: const Icon(Icons.delete),
            context: context,
            title: S.current.Actividad_desasignada_exitosamente,
            description: S.current.Se_removio_la_actividad_del_paciente,
            typeAlert: ToastificationType.success,
          );
          notifierActivityChildren.updateResponse();
        }
      }

      if (next.errorMessageApi != null) {
        toastAlert(
          context: context,
          title: S.current.Error,
          description: next.errorMessageApi!,
          typeAlert: ToastificationType.error,
        );
        notifierActivityChildren.updateResponse();
      }
    });

    if (stateChild.isError == false &&
        stateChild.isLoading == false &&
        context.mounted) {
      controllerDate.text =
          stateChild.child!.birthday.split('-').reversed.join('-');
    }

    Future<void> selectDate(BuildContext context, String dateValue) async {
      final DateTime now = DateTime.now();

      // Rango de fechas:
      // Máximo 100 años atrás
      final DateTime firstDate = DateTime(now.year - 100, now.month, now.day);
      // Mínimo 18 años de edad
      final DateTime lastDate = DateTime(now.year - 3, now.month, now.day);

      final day = int.parse(dateValue.split('-')[2]);
      final month = int.parse(dateValue.split('-')[1]);
      final year = int.parse(dateValue.split('-')[0]);

      DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime(year, month, day),
        firstDate: firstDate,
        lastDate: lastDate,
        // TODO: Modificar a una variable si se implementara el cambio de idioma
        locale: const Locale('es', 'ES'),
      );

      if (pickedDate != null) {
        ref.read(childProvider.notifier).updateBirthday(newDate: pickedDate);

        if (context.mounted) {
          controllerDate.text =
              "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
        }
      }
    }

    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        ref.read(childrenProvider.notifier).resetState();

        if (widget.extra![$isTutor] == true) {
          ref.read(childrenProvider.notifier).getChildrenTutor();
        } else {
          ref.read(childrenProvider.notifier).getChildrenTherapist();
        }
      },
      child: DefaultTabController(
        initialIndex: 0,
        length: 5,
        child: Scaffold(
          appBar: AppBar(
              title: Tooltip(
                message: S
                    .current.Informacion_del_nino, // Muestra el nombre completo
                waitDuration: const Duration(
                    milliseconds: 100), // Espera antes de mostrarse
                showDuration: const Duration(seconds: 2), // Tiempo visible
                child: Text(S.current.Informacion_del_nino),
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
                                          .Para_ver_la_foto_de_perfil_con_mas_detalle,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      S.current
                                          .Hacer_doble_clic_sobre_la_imagen,
                                    ),
                                    const SizedBox(height: 30),
                                    Text(
                                      S.current.Pestanas_de_informacion,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(S.current
                                        .Se_puede_desplazar_atraves_de_las_pestanas_desde_el_menu_superior_o_deslizando_horizontalmente_en_la_pantalla),
                                    const SizedBox(height: 30),
                                    Text(
                                      S.current
                                          .Para_ver_los_logros_con_mas_detalle,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      S.current
                                          .Hacer_doble_clic_sobre_la_imagen,
                                    ),
                                    const SizedBox(height: 30),
                                    Text(
                                      S.current.Menu_de_opciones,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      S.current
                                          .Para_saber_que_acciones_puede_realizar_en_el_registro_dar_clic_en_el_boton_inferior_a_la_derecha_de_la_pantalla,
                                    ),
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
              bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(60.0),
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        controller: _scrollController,
                        scrollDirection: Axis.horizontal,
                        child: TabBar(
                          controller: _tabController,
                          tabAlignment: TabAlignment.center,
                          isScrollable: true,
                          tabs: <Widget>[
                            Tab(
                              icon: const Icon(Icons.face_6),
                              child: Text(
                                S.current.Informacion_personal,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Tab(
                              icon: const Icon(Icons.description),
                              child: Text(
                                S.current.Informacion_general,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Tab(
                              icon: const Icon(Icons.pie_chart),
                              child: Text(
                                S.current.Informacion_del_progreso,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Tab(
                              icon: const Icon(Icons.analytics_outlined),
                              child: Text(
                                S.current.Actividades,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Tab(
                              icon: const Icon(Icons.remove_red_eye_sharp),
                              child: Text(
                                S.current.Observaciones,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Mostrar flechas si hay más contenido por ver
                      if (_showLeftArrow)
                        Positioned(
                          left: 0,
                          top: 0,
                          bottom: 0,
                          child: Container(
                            width: 45,
                            color: $colorTransparent,
                            child: const Icon(Icons.chevron_left,
                                size: 35, color: $colorTextWhite),
                          ),
                        ),
                      if (_showRightArrow)
                        Positioned(
                          right: 0,
                          top: 0,
                          bottom: 0,
                          child: Container(
                            width: 45,
                            color: $colorTransparent,
                            child: const Icon(Icons.chevron_right,
                                size: 35, color: $colorTextWhite),
                          ),
                        ),
                    ],
                  ))),
          body: Stack(
            children: [
              if (stateChild.isLoading == false && stateChild.isError == false)
                TabBarView(
                  controller: _tabController,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          FocusManager.instance.primaryFocus?.unfocus();
                        });
                      },
                      child: Container(
                        margin:
                            const EdgeInsets.only(left: 10, right: 10, top: 15),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              ..._childPersonalData(
                                enableInput: enableInput,
                                context: context,
                                ref: ref,
                                clickSave: clickSave,
                                focusNodes: focusNodes,
                                controllerDate: controllerDate,
                                selectDate: selectDate,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                        top: 15,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            ..._generalInformation(
                              enableInput: enableInput,
                              ref: ref,
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                        top: 15,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            ..._childProgressData(
                              enableInput: enableInput,
                              ref: ref,
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                        top: 15,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ..._activities(
                            scrollController: _scrollControllerObservations,
                            ref: ref,
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                        top: 15,
                      ),
                      child: _observationsChild(ref: ref),
                    ),
                  ],
                ),
              if (stateChild.isLoading == true)
                Stack(
                  children: [
                    const Opacity(
                      opacity: 0.5,
                      child: ModalBarrier(
                          dismissible: false, color: $colorTransparent),
                    ),
                    Center(
                      child: Column(
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
                ),
              if (stateChild.isUpdateData == true ||
                  statePhases.isLoading == true ||
                  stateActivity.isLoading == true)
                Stack(
                  children: [
                    const Opacity(
                      opacity: 0.5,
                      child: ModalBarrier(
                          dismissible: false, color: $colorTextBlack),
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
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
                ),
              if (stateChild.isError == true)
                SvgPicture.asset(fit: BoxFit.contain, $noData),
            ],
          ),
          floatingActionButton: stateChild.isLoading == true ||
                  stateChild.isUpdateData == true ||
                  stateChild.isError == true
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
                  children: [
                    SpeedDialChild(
                      visible: !enableInput && widget.extra![$isTutor] == true,
                      shape: const CircleBorder(),
                      child: const Icon(Icons.edit, color: $colorTextWhite),
                      backgroundColor: $colorBlueGeneral,
                      label: S.current.Editar,
                      onTap: () {
                        if (stateProfile.permmisions!
                            .contains($updatePatient)) {
                          setState(() {
                            _tabController.animateTo(
                              0,
                              duration: const Duration(milliseconds: 1500),
                              curve: Curves.bounceIn,
                            );
                            enableInput = true;
                          });
                          notifierChild.assingStateChild();
                        } else {
                          toastAlert(
                            iconAlert: const Icon(Icons.info),
                            context: context,
                            title: S.current.No_autorizado,
                            description:
                                S.current.No_cuenta_con_el_permiso_necesario,
                            typeAlert: ToastificationType.info,
                          );
                        }
                      },
                    ),
                    SpeedDialChild(
                      visible: enableInput,
                      shape: const CircleBorder(),
                      child: const Icon(Icons.close, color: $colorTextWhite),
                      backgroundColor: $colorError,
                      label: S.current.Cancelar,
                      onTap: () {
                        modalDialogConfirmation(
                          context: context,
                          titleButtonConfirm: S.current.Si_salir,
                          question: RichText(
                            text: TextSpan(
                              text:
                                  S.current.Esta_seguro_de_salir_de_la_edicion,
                              style: const TextStyle(
                                fontSize: 16,
                                color: $colorTextBlack,
                              ),
                            ),
                          ),
                          buttonColorConfirm: $colorSuccess,
                          onClic: () {
                            Navigator.of(context).pop();
                            setState(() {
                              enableInput = false;
                            });
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              // Aquí puedes actualizar el estado o realizar alguna acción
                              ref.read(childProvider.notifier).restoredState();
                            });
                          },
                        );
                      },
                    ),
                    SpeedDialChild(
                      shape: const CircleBorder(),
                      child: const Icon(Icons.update, color: $colorTextWhite),
                      backgroundColor: $colorBlueGeneral,
                      label: S.current.Actualizar,
                      visible: enableInput,
                      onTap: () {
                        clickSave = true;

                        if (notifierChild.checkFields()) {
                          modalDialogConfirmation(
                            context: context,
                            titleButtonConfirm: S.current.Si_actualizar,
                            question: RichText(
                              text: TextSpan(
                                text: S.current
                                    .Esta_Seguro_de_actualizar_los_datos,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: $colorTextBlack,
                                ),
                              ),
                            ),
                            buttonColorConfirm: $colorSuccess,
                            onClic: () async {
                              if (context.mounted) {
                                Navigator.of(context).pop();
                              }
                              await notifierChild.updateChild();
                            },
                          );
                        }
                        clickSave = false;
                      },
                    ),
                    SpeedDialChild(
                      shape: const CircleBorder(),
                      child: const Icon(
                        Icons.show_chart,
                        color: $colorTextWhite,
                      ),
                      backgroundColor: $colorSuccess,
                      label: S.current.Avanzar_de_fase,
                      visible: widget.extra![$isTutor] == false,
                      onTap: () {
                        if (stateProfile.permmisions!.contains($advancePhase)) {
                          setState(() {
                            _tabController.animateTo(
                              2,
                              duration: const Duration(milliseconds: 1500),
                              curve: Curves.bounceIn,
                            );
                          });
                          modalDialogConfirmation(
                            context: context,
                            titleButtonConfirm: S.current.Si_avanzar,
                            question: RichText(
                              text: TextSpan(
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: $colorTextBlack,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: S.current
                                        .Esta_seguro_de_avanzar_de_fase_a(
                                            stateChild.child!.fullName),
                                  ),
                                  TextSpan(
                                    text: '\n\n${S.current.Fase_actual}: ',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: stateChild.child!.currentPhase.name,
                                  ),
                                ],
                              ),
                            ),
                            buttonColorConfirm: $colorSuccess,
                            onClic: () async {
                              Navigator.of(context).pop();
                              final newPhase = await notifierPhases.changePhase(
                                  idChild: stateChild.child!.id);

                              if (newPhase != null) {
                                notifierChild.updateProgress(
                                  newPhase: newPhase,
                                );
                              }
                            },
                          );
                        } else {
                          toastAlert(
                            iconAlert: const Icon(Icons.info),
                            context: context,
                            title: S.current.No_autorizado,
                            description:
                                S.current.No_cuenta_con_el_permiso_necesario,
                            typeAlert: ToastificationType.info,
                          );
                        }
                      },
                    ),
                    SpeedDialChild(
                      shape: const CircleBorder(),
                      child: const Icon(Icons.add, color: $colorTextWhite),
                      backgroundColor: $colorSuccess,
                      label: S.current.Agregar_observacion,
                      visible: widget.extra![$isTutor] == false,
                      onTap: () {
                        if (stateProfile.permmisions!
                            .contains($addObservation)) {
                          setState(() {
                            _tabController.animateTo(
                              4,
                              duration: const Duration(milliseconds: 1500),
                              curve: Curves.bounceIn,
                            );
                          });
                          modalObservation(
                            context: context,
                            dataChild: CatalogObject(
                              id: stateChild.child!.id,
                              name: stateChild.child!.fullName,
                              description: '',
                            ),
                            isPageChild: true,
                          );
                        } else {
                          toastAlert(
                            iconAlert: const Icon(Icons.info),
                            context: context,
                            title: S.current.No_autorizado,
                            description:
                                S.current.No_cuenta_con_el_permiso_necesario,
                            typeAlert: ToastificationType.info,
                          );
                        }
                      },
                    ),
                    SpeedDialChild(
                      shape: const CircleBorder(),
                      child: const Icon(
                        Icons.color_lens,
                        color: $colorTextWhite,
                      ),
                      backgroundColor: $colorBlueGeneral,
                      label: S.current.Actualizar_filtro_blanco_negro,
                      visible: widget.extra![$isTutor] == true && !enableInput,
                      onTap: () {
                        if (stateProfile.permmisions!
                            .contains($changeMonochrome)) {
                          setState(() {
                            _tabController.animateTo(
                              1,
                              duration: const Duration(milliseconds: 1500),
                              curve: Curves.bounceIn,
                            );
                          });
                          modalDialogConfirmation(
                            context: context,
                            titleButtonConfirm: S.current.Si_cambiar,
                            question: RichText(
                              text: TextSpan(
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: $colorTextBlack,
                                  ),
                                  children: [
                                    TextSpan(
                                      text:
                                          '${S.current.Esta_seguro_de_cambiar_el_filtro_blanco_negro}\n\n',
                                    ),
                                    TextSpan(
                                      text: '${S.current.Nuevo_valor}: ',
                                    ),
                                    TextSpan(
                                      text:
                                          stateChild.child!.isMonochrome == true
                                              ? S.current.Inactivo
                                              : S.current.Activo,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ]),
                            ),
                            buttonColorConfirm: $colorSuccess,
                            onClic: () async {
                              if (context.mounted) {
                                Navigator.of(context).pop();
                              }
                              await notifierChild.updateMonochrome(
                                idChild: stateChild.child!.id,
                              );
                            },
                          );
                        } else {
                          toastAlert(
                            iconAlert: const Icon(Icons.info),
                            context: context,
                            title: S.current.No_autorizado,
                            description:
                                S.current.No_cuenta_con_el_permiso_necesario,
                            typeAlert: ToastificationType.info,
                          );
                        }
                      },
                    ),
                    SpeedDialChild(
                      shape: const CircleBorder(),
                      child: const Icon(Icons.delete, color: $colorTextWhite),
                      backgroundColor: $colorError,
                      label: S.current.Quitar_actividad,
                      visible: widget.extra![$isTutor] == false,
                      onTap: () {
                        if (stateProfile.permmisions!
                            .contains($unassignActivity)) {
                          if (stateChild.child!.currentActivity == null) {
                            toastAlert(
                              iconAlert: const Icon(Icons.info),
                              context: context,
                              title: S.current.Aviso,
                              description: S.current
                                  .El_paciente_no_tiene_actividad_asignada_actualmente,
                              typeAlert: ToastificationType.info,
                            );
                            return;
                          }
                          modalDialogConfirmation(
                            context: context,
                            titleButtonConfirm: S.current.Si_Quitar,
                            question: RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                  text:
                                      '${S.current.Esta_seguro_de_quitarle_la_actividad(stateChild.child!.currentActivity!.name)}\n\n',
                                  style: const TextStyle(
                                    color: $colorTextBlack,
                                  ),
                                ),
                                TextSpan(
                                  text: '${S.current.Al_paiente}: ',
                                  style: const TextStyle(
                                    color: $colorTextBlack,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: stateChild.child!.fullName,
                                  style: const TextStyle(
                                    color: $colorTextBlack,
                                  ),
                                ),
                              ]),
                            ),
                            buttonColorConfirm: $colorSuccess,
                            onClic: () async {
                              Navigator.of(context).pop();
                              if (await notifierActivityChildren
                                  .unassingActivity(
                                      idChild: stateChild.child!.id)) {
                                notifierChild.updateActivity();
                              }
                            },
                          );
                        } else {
                          toastAlert(
                            iconAlert: const Icon(Icons.info),
                            context: context,
                            title: S.current.No_autorizado,
                            description:
                                S.current.No_cuenta_con_el_permiso_necesario,
                            typeAlert: ToastificationType.info,
                          );
                        }
                      },
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

List<Widget> _childPersonalData({
  required bool enableInput,
  required BuildContext context,
  required WidgetRef ref,
  required bool clickSave,
  required Map<String, FocusNode> focusNodes,
  required TextEditingController controllerDate,
  required Function(BuildContext context, String dateValue) selectDate,
}) {
  final CameraGalleryDataSourceImpl image = CameraGalleryDataSourceImpl();

  final stateChild = ref.watch(childProvider);
  final notifierChild = ref.read(childProvider.notifier);

  Future<void> selectImage() async {
    final String? imagePath = await image.selectImage();
    if (imagePath != null) {
      final file = File(imagePath);

      notifierChild.updateImage(imageFile: file);
      notifierChild.updateimagePath(path: imagePath);
    }
  }

  Future<void> takePhoto() async {
    final String? imagePath = await image.takePhoto();
    if (imagePath != null) {
      final file = File(imagePath);

      notifierChild.updateImage(imageFile: file);
      notifierChild.updateimagePath(path: imagePath);
    }
  }

  return [
    Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      width: 150,
      child: Center(
        child: Stack(children: [
          ClipOval(
            child: Container(
              width: 145,
              height: 145,
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: ImageLoad(
                urlImage: stateChild.child!.imageUrl,
                imagePath: stateChild.imagePath,
              ),
            ),
          ),
          Visibility(
            visible: enableInput,
            child: Positioned(
              bottom: 0,
              right: 0,
              child: IconButton.filled(
                style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll($colorBlueGeneral),
                ),
                onPressed: () {
                  bottomSheetModal(
                    context: context,
                    arrayWidgets: [
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 15),
                        width: 40,
                        height: 7,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: $colorButtonDisable,
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(S.current.Seleccione_foto_de_perfil),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                IconButton(
                                    onPressed: () async {
                                      await selectImage();
                                      if (context.mounted) {
                                        Navigator.of(context).pop();
                                      }
                                    },
                                    icon: const Icon(Icons.photo)),
                                Text(S.current.Galeria),
                              ],
                            ),
                            Column(
                              children: [
                                IconButton(
                                    onPressed: () async {
                                      await takePhoto();
                                      if (context.mounted) {
                                        Navigator.of(context).pop();
                                      }
                                    },
                                    icon: const Icon(Icons.add_a_photo)),
                                Text(S.current.Camara),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  );
                },
                icon: const Icon(Icons.camera_alt),
                iconSize: 20,
              ),
            ),
          )
        ]),
      ),
    ),
    const SizedBox(height: 10),
    Focus(
      focusNode: focusNodes[$userNameProfile],
      child: InputForm(
        label: S.current.Nombre_de_usuario,
        maxLength: 15,
        value: stateChild.child!.username,
        enable: enableInput,
        isNumberLetter: true,
        onChanged: (value) {
          notifierChild.updateChildField(
            fieldName: $userNameProfile,
            newValue: value,
          );
        },
        errorText: stateChild.validationErrors[$userNameProfile],
      ),
    ),
    Focus(
      focusNode: focusNodes[$emailProfile],
      child: InputForm(
        label: S.current.Correo_electronico,
        maxLength: 50,
        value: stateChild.child!.email,
        enable: enableInput,
        onChanged: (value) {
          notifierChild.updateChildField(
            fieldName: $emailProfile,
            newValue: value,
          );
        },
        errorText: stateChild.validationErrors[$emailProfile],
      ),
    ),
    Focus(
      focusNode: focusNodes[$firstNameProfile],
      child: InputForm(
        label: S.current.Primer_nombre,
        maxLength: 15,
        value: stateChild.child!.firstName,
        enable: enableInput,
        allCharacters: false,
        onChanged: (value) {
          notifierChild.updateChildField(
            fieldName: $firstNameProfile,
            newValue: value,
          );
        },
        errorText: stateChild.validationErrors[$firstNameProfile],
      ),
    ),
    InputForm(
      label: S.current.Segundo_nombre,
      maxLength: 25,
      value: stateChild.child!.secondName ?? '',
      enable: enableInput,
      allCharacters: false,
      onChanged: (value) {
        notifierChild.updateChildField(
          fieldName: $secondNameProfile,
          newValue: value,
        );
      },
    ),
    Focus(
      focusNode: focusNodes[$surnameProfile],
      child: InputForm(
        label: S.current.Primer_apellido,
        maxLength: 15,
        value: stateChild.child!.surname,
        enable: enableInput,
        allCharacters: false,
        onChanged: (value) {
          notifierChild.updateChildField(
            fieldName: $surnameProfile,
            newValue: value,
          );
        },
        errorText: stateChild.validationErrors[$surnameProfile],
      ),
    ),
    InputForm(
      label: S.current.Segundo_apellido,
      maxLength: 15,
      value: stateChild.child!.secondSurname ?? '',
      enable: enableInput,
      allCharacters: false,
      onChanged: (value) {
        notifierChild.updateChildField(
          fieldName: $secondSurnameProfile,
          newValue: value,
        );
      },
    ),
    clearable.ClearableDropdown(
      focus: FocusNode(),
      helperText: ' ',
      listItems: [
        clearable.CatalogObject(id: 0, name: $masculino),
        clearable.CatalogObject(id: 1, name: $femenino)
      ],
      enable: enableInput,
      valueInitial: stateChild.child!.gender,
      label: S.current.Sexo,
      onSelected: (value) {
        notifierChild.updateChildField(
          fieldName: $genderProfile,
          newValue: value! == "0" ? $masculino : $femenino,
        );
      },
      errorText: stateChild.validationErrors[$genderProfile],
    ),
    InputForm(
      label: S.current.Fecha_de_nacimiento,
      controllerExt: controllerDate,
      value: stateChild.child!.birthday.split('-').reversed.join('-'),
      enable: enableInput,
      readOnly: true,
      onChanged: (value) {
        notifierChild.updateChildField(
          fieldName: $birthdayProfile,
          newValue: value,
        );
      },
      errorText: stateChild.validationErrors[$birthdayProfile],
      onTap: () => selectDate(context, stateChild.child!.birthday),
    ),
    Visibility(
      visible: !enableInput,
      child: InputForm(
        label: S.current.Edad,
        value: stateChild.child!.age.toString(),
        enable: false,
      ),
    ),
    Focus(
      focusNode: focusNodes[$addressProfile],
      child: InputForm(
        label: S.current.Direccion,
        maxLength: 255,
        linesDynamic: true,
        enable: enableInput,
        onChanged: (value) {
          notifierChild.updateChildField(
            fieldName: $addressProfile,
            newValue: value,
          );
        },
        errorText: stateChild.validationErrors[$addressProfile],
        value: stateChild.child!.address,
      ),
    ),
    const SizedBox(height: 55),
  ];
}

List<Widget> _generalInformation({
  required bool enableInput,
  required WidgetRef ref,
}) {
  final stateChild = ref.watch(childProvider);
  return [
    const SizedBox(height: 15),
    InputForm(
      label: S.current.Pictogramas_blanco_negro,
      value: stateChild.child!.isMonochrome == true
          ? S.current.Activo
          : S.current.Inactivo,
      enable: false,
    ),
    InputForm(
      label: S.current.Tutor,
      value: stateChild.child!.tutor.fullName,
      enable: false,
    ),
    InputForm(
      label: S.current.Contacto_tutor,
      value: stateChild.child!.tutor.telephone ?? '',
      enable: false,
    ),
    InputForm(
      label: S.current.Telefono_de_casa,
      value: stateChild.child!.tutor.phoneNumber,
      enable: false,
    ),
    InputForm(
      label: S.current.Terapeuta,
      value: stateChild.child!.therapist != null
          ? stateChild.child!.therapist!.fullName
          : S.current.Sin_terapeuta_asignado,
      enable: false,
    ),
    InputForm(
      label: S.current.Contacto_terapeuta,
      value: stateChild.child!.therapist != null
          ? stateChild.child!.therapist!.phoneNumber
          : '-',
      enable: false,
    ),
    const SizedBox(
      height: 55,
    ),
  ];
}

List<Widget> _childProgressData({
  required bool enableInput,
  required WidgetRef ref,
}) {
  final stateChild = ref.watch(childProvider);
  return [
    Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 13,
                      vertical: 20,
                    ),
                    alignment: Alignment.topCenter,
                    child: Text(
                      S.current.Progreso_general_de_las_fase,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: Stack(children: [
                      SizedBox(
                        height: 100,
                        width: 100,
                        child: CircularProgressIndicator(
                          value: double.parse(
                                  stateChild.child!.progress.generalProgress) /
                              100,
                          backgroundColor: $colorButtonDisable,
                          strokeWidth: 10,
                          color: $colorBlueGeneral,
                        ),
                      ),
                      Center(
                        child: Text(
                          '${stateChild.child!.progress.generalProgress} %',
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ]),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 13,
                      vertical: 20,
                    ),
                    alignment: Alignment.topCenter,
                    child: Text(
                      S.current.progreso_de_fase_Actual,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: Stack(children: [
                      SizedBox(
                        height: 100,
                        width: 100,
                        child: CircularProgressIndicator(
                          value: double.parse(
                                  stateChild.child!.progress.phaseProgress) /
                              100,
                          backgroundColor: $colorButtonDisable,
                          strokeWidth: 10,
                          color: $colorBlueGeneral,
                        ),
                      ),
                      Center(
                        child: Text(
                          '${stateChild.child!.progress.phaseProgress.toString()} %',
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
    const SizedBox(height: 15),
    ListView(
      shrinkWrap: true, // Asegura que solo ocupe el espacio necesario
      physics: const NeverScrollableScrollPhysics(),
      children: [
        ListTileCustom(
          title:
              '${S.current.Grado_de_autismo_actual}:  ${stateChild.child!.teaDegree.name}',
          colorTitle: true,
          styleTitle: FontWeight.bold,
          noImage: true,
          subTitle: RichText(
            text: TextSpan(
              text: stateChild.child!.teaDegree.description,
              style: const TextStyle(
                color: $colorTextBlack,
                fontSize: 13,
              ),
            ),
          ),
        )
      ],
    ),
    ListView(
      shrinkWrap: true, // Asegura que solo ocupe el espacio necesario
      physics: const NeverScrollableScrollPhysics(),
      children: [
        ListTileCustom(
          title:
              '${S.current.Fase_actual}:  ${stateChild.child!.currentPhase.name}',
          colorTitle: true,
          styleTitle: FontWeight.bold,
          noImage: true,
          subTitle: RichText(
            text: TextSpan(
              text: stateChild.child!.currentPhase.description,
              style: const TextStyle(
                color: $colorTextBlack,
                fontSize: 13,
              ),
            ),
          ),
        )
      ],
    ),
    const SizedBox(height: 10),
    Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      alignment: Alignment.centerLeft,
      child: Text(S.current.Logros),
    ),
    if (stateChild.child!.achievements != null)
      ImageListVIew(
        images: stateChild.child!.achievements != null
            ? stateChild.child!.achievements!.toList()
            : [],
        isDecoration: false,
        isSelect: false,
        isMarginLeft: false,
      ),
    if (stateChild.child!.achievements == null)
      SizedBox(
        height: 250,
        child: SvgPicture.asset(fit: BoxFit.contain, $noData),
      ),
    const SizedBox(height: 55),
  ];
}

List<Widget> _activities({
  required ScrollController scrollController,
  required WidgetRef ref,
}) {
  final stateChildActivities = ref.watch(childProvider).child!.activities;
  final stateChildCurrentActivity =
      ref.watch(childProvider).child!.currentActivity;
  return [
    Container(
      margin: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
      alignment: Alignment.centerLeft,
      child: Text(S.current.Actividad_actual),
    ),
    ListView(
      shrinkWrap: true, // Asegura que solo ocupe el espacio necesario
      physics: const NeverScrollableScrollPhysics(),
      children: [
        ListTileCustom(
          title: stateChildCurrentActivity != null
              ? stateChildCurrentActivity.name
              : S.current.Sin_actividad_activa_por_el_momento,
          colorTitle: true,
          styleTitle: FontWeight.bold,
          noImage: true,
          colorText: $colorTextWhite,
          colorItemSelect: $colorBlueGeneral,
          subTitle: stateChildCurrentActivity != null
              ? Column(
                  children: [
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          color: $colorTextBlack,
                          fontSize: 13,
                        ),
                        children: [
                          TextSpan(text: stateChildCurrentActivity.description),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12.5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${S.current.Progreso}: ${stateChildCurrentActivity.progress} %',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: $colorBlueGeneral,
                          ),
                        ),
                        Text(
                          '${stateChildCurrentActivity.satisfactoryAttempts}/${stateChildCurrentActivity.satisfactoryPoints}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: $colorBlueGeneral,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    LinearProgressIndicator(
                      value: double.parse(stateChildCurrentActivity.progress) /
                          100,
                      minHeight: 7,
                      color: $colorBlueGeneral,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    const SizedBox(height: 5),
                  ],
                )
              : null,
        )
      ],
    ),
    Container(
      margin: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
      alignment: Alignment.centerLeft,
      child: Text(S.current.Actividades_terminadas),
    ),
    Expanded(
      child: stateChildActivities != null
          ? ListView.builder(
              itemCount: stateChildActivities.length + 1,
              itemBuilder: (context, index) {
                if (index < stateChildActivities.length) {
                  return ListTileCustom(
                    title: stateChildActivities[index].name,
                    colorTitle: true,
                    styleTitle: FontWeight.bold,
                    noImage: true,
                    subTitle: RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          color: $colorTextBlack,
                          fontSize: 13,
                        ),
                        text: stateChildActivities[index].description,
                      ),
                    ),
                  );
                } else {
                  return const SizedBox(height: 75);
                }
              },
            )
          : SvgPicture.asset(fit: BoxFit.contain, $noData),
    ),
  ];
}

Widget _observationsChild({
  required WidgetRef ref,
}) {
  final stateChildObservations = ref.watch(childProvider).child!.observations;
  return stateChildObservations != null
      ? ListView.builder(
          itemCount: stateChildObservations.length + 1,
          itemBuilder: (context, index) {
            if (index < stateChildObservations.length) {
              DateTime date =
                  DateTime.parse(stateChildObservations[index].createdAt);
              final dateFormat = DateFormat("dd-MM-yyyy HH:mm").format(date);

              return ListTileCustom(
                title: stateChildObservations[index].description,
                noImage: true,
                subTitle: RichText(
                  text: TextSpan(
                    text:
                        '\n$dateFormat     @${stateChildObservations[index].username}',
                    style: const TextStyle(
                      color: $colorBlueGeneral,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            } else {
              return const SizedBox(height: 75);
            }
          },
        )
      : SvgPicture.asset(fit: BoxFit.contain, $noData);
}
