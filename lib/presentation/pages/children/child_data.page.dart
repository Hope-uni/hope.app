import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hope_app/domain/domain.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/infrastructure/infrastructure.dart';
import 'package:hope_app/presentation/providers/providers.dart';
import 'package:hope_app/presentation/utils/utils.dart';
import 'package:hope_app/presentation/widgets/widgets.dart';
import 'package:toastification/toastification.dart';

class ChildDataPage extends ConsumerStatefulWidget {
  final int idChild;
  const ChildDataPage({super.key, required this.idChild});

  @override
  ChildDataPageState createState() => ChildDataPageState();
}

class ChildDataPageState extends ConsumerState<ChildDataPage> {
  bool enableInput = false;
  bool clickSave = false;
  bool _showRightArrow = true;
  bool _showLeftArrow = false;

  final ScrollController _scrollController = ScrollController();
  final ScrollController _scrollControllerObservations = ScrollController();
  late final TextEditingController controllerDate = TextEditingController();

  final _key = GlobalKey<ExpandableFabState>();

  final Map<String, FocusNode> focusNodes = {
    $userNameProfile: FocusNode(),
    $emailProfile: FocusNode(),
    $firstNameProfile: FocusNode(),
    $surnameProfile: FocusNode(),
    $identificationNumbereProfile: FocusNode(),
    $phoneNumberProfile: FocusNode(),
    $telephoneProfile: FocusNode(),
  };

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (mounted) {
        ref.read(childProvider.notifier).resetChild();
      }
    });

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
  }

  @override
  void dispose() {
    _scrollController.dispose();
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

  @override
  Widget build(BuildContext context) {
    final stateChild = ref.watch(childProvider);
    final notifierChild = ref.read(childProvider.notifier);
    final profileState = ref.watch(profileProvider);

    ref.listen(childProvider, (previous, next) {
      if (next.validationErrors.isNotEmpty && clickSave) {
        String firstErrorKey = next.validationErrors.keys.first;
        focusNodes[firstErrorKey]?.requestFocus();
      }

      if (next.isUpdateData == false && next.showtoastAlert == true) {
        if (context.mounted) {
          toastAlert(
            iconAlert: const Icon(Icons.update),
            context: context,
            title: S.current.Actualizado_con_exito,
            description: S.current.Informacion_del_nino_actualizada,
            typeAlert: ToastificationType.info,
          );
          notifierChild.updateErrorMessage();
        }
      }

      if (next.errorMessageApi != null) {
        toastAlert(
          context: context,
          title: S.current.Error,
          description: next.errorMessageApi!,
          typeAlert: ToastificationType.error,
        );
        notifierChild.updateErrorMessage();
      }
    });

    if (stateChild.isError != true &&
        stateChild.isLoading == false &&
        context.mounted) {
      controllerDate.text =
          stateChild.child!.birthday.split('-').reversed.join('-');
    }

    Future<void> selectDate(BuildContext context, String dateValue) async {
      final DateTime now = DateTime.now();
      final DateTime firstDate = DateTime(1950, 1, 1);
      final DateTime lastDate = now;

      final day = int.parse(dateValue.split('-')[2]);
      final month = int.parse(dateValue.split('-')[1]);
      final year = int.parse(dateValue.split('-')[0]);

      DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime(year, month, day),
        firstDate: firstDate,
        lastDate: lastDate,
      );

      if (pickedDate != null) {
        ref.read(childProvider.notifier).updateBirthday(pickedDate);

        if (context.mounted) {
          controllerDate.text =
              "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
        }
      }
    }

    return DefaultTabController(
      initialIndex: 0,
      length: 5,
      child: Scaffold(
        appBar: AppBar(
            title: Text(S.current.Informacion_del_nino),
            bottom: PreferredSize(
                preferredSize: const Size.fromHeight(60.0),
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      controller: _scrollController,
                      scrollDirection: Axis.horizontal,
                      child: TabBar(
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
            if (stateChild.isLoading == false && stateChild.isError != true)
              TabBarView(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
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
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
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
                    margin: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
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
                    margin: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
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
                    margin: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ..._observationsChild(
                          scrollController: _scrollControllerObservations,
                          ref: ref,
                        )
                      ],
                    ),
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
            if (stateChild.isUpdateData == true)
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
            if (stateChild.isError == true)
              SvgPicture.asset(
                fit: BoxFit.contain,
                'assets/svg/SinDatos.svg',
              ),
          ],
        ),
        floatingActionButtonLocation: ExpandableFab.location,
        floatingActionButton: IgnorePointer(
          ignoring:
              stateChild.isLoading == true || stateChild.isUpdateData == true
                  ? true
                  : false,
          child: ExpandableFab(
            key: _key,
            pos: ExpandableFabPos.right,
            openButtonBuilder: RotateFloatingActionButtonBuilder(
              child: const Icon(Icons.add),
              fabSize: ExpandableFabSize.regular,
              foregroundColor: $colorTextWhite,
              backgroundColor: $colorSuccess,
              shape: const CircleBorder(),
            ),
            closeButtonBuilder: DefaultFloatingActionButtonBuilder(
              child: const Icon(Icons.expand_more),
              fabSize: ExpandableFabSize.small,
              foregroundColor: $colorTextWhite,
              backgroundColor: const Color.fromARGB(255, 120, 120, 120),
              shape: const CircleBorder(),
            ),
            type: ExpandableFabType.up,
            childrenAnimation: ExpandableFabAnimation.none,
            distance: 60,
            children: [
              if (!enableInput)
                Row(
                  children: [
                    Text(
                      S.current.Editar,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 20),
                    FloatingActionButton.small(
                      shape: const CircleBorder(),
                      backgroundColor: $colorBlueGeneral,
                      heroTag: null,
                      child: const Icon(Icons.edit, color: $colorTextWhite),
                      onPressed: () {
                        if (profileState.permmisions!
                            .contains($updatePatientTutor)) {
                          setState(() {
                            enableInput = true;
                          });
                          _key.currentState?.toggle();
                          notifierChild.assingState();
                        } else {
                          toastAlert(
                            iconAlert: const Icon(Icons.update),
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
              if (enableInput)
                Row(
                  children: [
                    Text(
                      S.current.Cancelar,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 20),
                    FloatingActionButton.small(
                      shape: const CircleBorder(),
                      backgroundColor: $colorError,
                      heroTag: null,
                      onPressed: () {
                        _key.currentState?.toggle();
                        modalDialogConfirmation(
                          context: context,
                          titleButtonConfirm: S.current.Si_salir,
                          question: RichText(
                            textAlign: TextAlign.center,
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
                      child: const Icon(
                        Icons.close,
                        color: $colorTextWhite,
                      ),
                    ),
                  ],
                ),
              if (enableInput)
                Row(
                  children: [
                    Text(
                      S.current.Actualizar,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 20),
                    FloatingActionButton.small(
                      shape: const CircleBorder(),
                      backgroundColor: $colorBlueGeneral,
                      heroTag: null,
                      onPressed: () {
                        _key.currentState?.toggle();
                        clickSave = true;

                        if (notifierChild.checkFields()) {
                          modalDialogConfirmation(
                            context: context,
                            titleButtonConfirm: S.current.Si_actualizar,
                            question: RichText(
                              textAlign: TextAlign.center,
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
                              enableInput = false;
                            },
                          );
                        }
                        clickSave = false;
                      },
                      child: const Icon(
                        Icons.update,
                        color: $colorTextWhite,
                      ),
                    ),
                  ],
                ),
              if (!enableInput)
                Row(
                  children: [
                    Text(
                      S.current.Avanzar_de_fase,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 20),
                    FloatingActionButton.small(
                      shape: const CircleBorder(),
                      backgroundColor: $colorSuccess,
                      heroTag: null,
                      onPressed: () {
                        _key.currentState?.toggle();
                        modalDialogConfirmation(
                          context: context,
                          titleButtonConfirm: S.current.Si_avanzar,
                          question: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: const TextStyle(
                                  fontSize: 16, color: $colorTextBlack),
                              children: <TextSpan>[
                                TextSpan(
                                  text: S.current.Esta_seguro_de_avanzar_de_fase_a(
                                      'Mario Jose Ramos Mejia'), //TODO: Cambiar cuando este listo el endpoint
                                ),
                                const TextSpan(
                                  //TODO: Cambiar cuando este listo el endpoint
                                  text: '\n\nFase 3 \u2192 Fase 4',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          buttonColorConfirm: $colorSuccess,
                          onClic: () {
                            Navigator.of(context).pop();
                            toastAlert(
                              context: context,
                              title: S.current.Avance_de_fase_exitosa,
                              description: S.current.Se_avanzo_a_la_fase(4,
                                  'Mario Jose Ramos Mejia'), //TODO: Cambiar cuando este listo el endpoint
                              typeAlert: ToastificationType.success,
                            );
                          },
                        );
                      },
                      child: const Icon(
                        Icons.show_chart,
                        color: $colorTextWhite,
                      ),
                    ),
                  ],
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
              child: ImageLoad(urlImage: stateChild.child!.image),
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
                                      // ignore: unused_local_variable
                                      final photo = await image.selectImage();
                                    },
                                    icon: const Icon(Icons.photo)),
                                Text(S.current.Galeria),
                              ],
                            ),
                            Column(
                              children: [
                                IconButton(
                                    onPressed: () async {
                                      // ignore: unused_local_variable
                                      final imagen = await image.takePhoto();
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
    InputForm(
      label: S.current.Nombre_de_usuario,
      maxLength: 25,
      value: stateChild.child!.username,
      enable: enableInput,
      onChanged: (value) {
        notifierChild.updateChildField($userNameProfile, value);
      },
      focus: focusNodes[$userNameProfile],
      errorText: stateChild.validationErrors[$userNameProfile],
    ),
    InputForm(
      label: S.current.Correo_electronico,
      maxLength: 50,
      value: stateChild.child!.email,
      enable: enableInput,
      onChanged: (value) {
        notifierChild.updateChildField($emailProfile, value);
      },
      focus: focusNodes[$emailProfile],
      errorText: stateChild.validationErrors[$emailProfile],
    ),
    InputForm(
      label: S.current.Primer_nombre,
      maxLength: 25,
      value: stateChild.child!.firstName,
      enable: enableInput,
      allCharacters: false,
      onChanged: (value) {
        notifierChild.updateChildField($firstNameProfile, value);
      },
      focus: focusNodes[$firstNameProfile],
      errorText: stateChild.validationErrors[$firstNameProfile],
    ),
    InputForm(
      label: S.current.Segundo_nombre,
      maxLength: 25,
      value: stateChild.child!.secondName ?? '',
      enable: enableInput,
      allCharacters: false,
      onChanged: (value) {
        notifierChild.updateChildField($secondNameProfile, value);
      },
    ),
    InputForm(
      label: S.current.Primer_apellido,
      maxLength: 25,
      value: stateChild.child!.surname,
      enable: enableInput,
      allCharacters: false,
      onChanged: (value) {
        notifierChild.updateChildField($surnameProfile, value);
      },
      focus: focusNodes[$surnameProfile],
      errorText: stateChild.validationErrors[$surnameProfile],
    ),
    InputForm(
      label: S.current.Segundo_apellido,
      maxLength: 25,
      value: stateChild.child!.secondSurname ?? '',
      enable: enableInput,
      allCharacters: false,
      onChanged: (value) {
        notifierChild.updateChildField($secondSurnameProfile, value);
      },
    ),
    SelectBox(
      enable: enableInput,
      valueInitial: stateChild.child!.gender,
      label: S.current.Sexo,
      onSelected: (value) {
        notifierChild.updateChildField(
            $genderProfile, value! == "0" ? $masculino : $femenino);
      },
      listItems: [
        CatalogObject(id: 0, name: $masculino, description: ''),
        CatalogObject(id: 1, name: $femenino, description: '')
      ],
      deleteSelection: false,
      errorText: stateChild.validationErrors[$genderProfile],
    ),
    InputForm(
      label: S.current.Fecha_de_nacimiento,
      controllerExt: controllerDate,
      value: stateChild.child!.birthday.split('-').reversed.join('-'),
      enable: enableInput,
      readOnly: true,
      onChanged: (value) {
        notifierChild.updateChildField($birthdayProfile, value);
      },
      errorText: stateChild.validationErrors[$birthdayProfile],
      onTap: () => selectDate(context, stateChild.child!.birthday),
    ),
    InputForm(
      label: S.current.Edad,
      value: stateChild.child!.age.toString(),
      enable: false,
    ),
    InputForm(
      label: S.current.Direccion,
      maxLength: 100,
      linesDynamic: true,
      enable: enableInput,
      onChanged: (value) {
        notifierChild.updateChildField($addressProfile, value);
      },
      errorText: stateChild.validationErrors[$addressProfile],
      value: stateChild.child!.address,
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
    //TODO: Cambiar cuando este listo el endpoint
    SelectBox(
      enable: enableInput,
      valueInitial: 'Activado',
      label: S.current.Pictogramas_blanco_negro,
      onSelected: (value) {},
      listItems: [
        CatalogObject(id: 0, name: 'Activado', description: ''),
        CatalogObject(id: 0, name: 'Desactivado', description: '')
      ],
    ),
    InputForm(
      label: S.current.Tutor,
      value: stateChild.child!.tutor.fullName,
      enable: false,
    ),
    InputForm(
      label: S.current.Contacto_tutor,
      value: stateChild.child!.tutor.telephone!,
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
                        horizontal: 13, vertical: 20),
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
                    child: Text(S.current.progreso_de_fase_Actual),
                  ),
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: Stack(children: [
                      SizedBox(
                        height: 100,
                        width: 100,
                        child: CircularProgressIndicator(
                          value: stateChild.child!.progress.phaseProgress / 100,
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
          subTitle: stateChild.child!.teaDegree.description,
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
          subTitle: stateChild.child!.currentPhase.description,
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
      ),
    if (stateChild.child!.achievements == null)
      SizedBox(
        height: 250,
        child: SvgPicture.asset(
          fit: BoxFit.contain,
          'assets/svg/SinDatos.svg',
        ),
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
          subTitle: stateChildCurrentActivity != null
              ? stateChildCurrentActivity.description
              : '-',
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
              itemCount: stateChildActivities.length,
              itemBuilder: (context, index) {
                if (index < stateChildActivities.length) {
                  return ListTileCustom(
                    title: stateChildActivities[index].name,
                    colorTitle: true,
                    styleTitle: FontWeight.bold,
                    noImage: true,
                    subTitle: stateChildActivities[index].description,
                  );
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
  ];
}

List<Widget> _observationsChild({
  required ScrollController scrollController,
  required WidgetRef ref,
}) {
  final stateChildObservations = ref.watch(childProvider).child!.observations;
  return [
    Container(
      alignment: Alignment.centerRight,
      child: ButtonTextIcon(
          title: S.current.Agregar_observacion,
          icon: const Icon(Icons.add),
          onClic: () {}),
    ),
    Expanded(
      child: stateChildObservations != null
          ? ListView.builder(
              itemCount: stateChildObservations.length,
              itemBuilder: (context, index) {
                if (index < stateChildObservations.length) {
                  return ListTileCustom(
                    title: stateChildObservations[index].description,
                    subTitle:
                        '\n${stateChildObservations[index].createdAt}     @${stateChildObservations[index].username}',
                    styleSubTitle: FontWeight.bold,
                    colorSubTitle: true,
                    noImage: true,
                  );
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
  ];
}
