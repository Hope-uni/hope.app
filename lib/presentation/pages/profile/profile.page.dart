import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/infrastructure/infrastructure.dart';
import 'package:hope_app/presentation/providers/providers.dart';
import 'package:hope_app/presentation/utils/utils.dart';
import 'package:hope_app/presentation/widgets/widgets.dart';
import 'package:toastification/toastification.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  bool enableInput = false;
  bool clickSave = false;
  final CameraGalleryDataSourceImpl image = CameraGalleryDataSourceImpl();

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
  Widget build(BuildContext context) {
    final profileState = ref.watch(profileProvider);
    final profileNotifier = ref.watch(profileProvider.notifier);

    ref.listen(profileProvider, (previous, next) {
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
            description: S.current.Informacion_personal_actualizada,
            typeAlert: ToastificationType.info,
          );
          profileNotifier.updateErrorMessage();
        }
      }
      if (next.errorMessageApi != null) {
        toastAlert(
          context: context,
          title: S.current.Error,
          description: next.errorMessageApi!,
          typeAlert: ToastificationType.error,
        );
        profileNotifier.updateErrorMessage();
      }
    });

    final Size size = MediaQuery.of(context).size;
    const double sizeInputs = 150;

    if (profileState.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final TextEditingController controller = TextEditingController(
        text: profileState.profile!.birthday.split('-').reversed.join('-'));

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
        profileNotifier.updateBirthday(pickedDate);

        setState(() {
          controller.text =
              "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
        });
      }
    }

    return Stack(
      children: [
        DefaultTabController(
          initialIndex: 0,
          length: 1,
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                S.current.Perfil,
              ),
              bottom: TabBar(
                tabs: <Widget>[
                  Tab(
                    icon: const Icon(Icons.face_6),
                    child: Text(
                      S.current.Informacion_personal,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            body: TabBarView(children: [
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                          bottom: 30,
                          left: 10,
                          right: 10,
                          top: 15,
                        ),
                        width: sizeInputs,
                        child: Center(
                          child: Stack(
                            children: [
                              ClipOval(
                                child: Container(
                                  width: 150,
                                  height: sizeInputs,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: ImageLoad(
                                    height: 150,
                                    width: 150,
                                    urlImage: profileState.profile!.image ?? '',
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: enableInput,
                                child: Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: IconButton.filled(
                                    iconSize: 30,
                                    style: const ButtonStyle(
                                      backgroundColor: WidgetStatePropertyAll(
                                        $colorBlueGeneral,
                                      ),
                                    ),
                                    onPressed: () {
                                      bottomSheetModal(
                                        context: context,
                                        arrayWidgets: [
                                          Container(
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 15),
                                            width: 40,
                                            height: 7,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: $colorButtonDisable,
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 20),
                                            width: size.width,
                                            child: Text(S.current
                                                .Seleccione_foto_de_perfil),
                                          ),
                                          Container(
                                            width: size.width,
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 20),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Column(
                                                  children: [
                                                    //TODO: Falta hacer la logica de cambio de foto cuando se ocupe el repositorio de imagenes
                                                    IconButton(
                                                      onPressed: () async {
                                                        // ignore: unused_local_variable
                                                        final photo =
                                                            await image
                                                                .selectImage();
                                                      },
                                                      icon: const Icon(
                                                          Icons.photo),
                                                    ),
                                                    Text(S.current.Galeria),
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    IconButton(
                                                      onPressed: () async {
                                                        // ignore: unused_local_variable
                                                        final imagen =
                                                            await image
                                                                .takePhoto();
                                                      },
                                                      icon: const Icon(
                                                          Icons.add_a_photo),
                                                    ),
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
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      InputForm(
                        label: S.current.Nombre_de_usuario,
                        maxLength: 25,
                        value: profileState.userName!,
                        enable: enableInput,
                        onChanged: (value) {
                          profileNotifier.updateUserName(value);
                        },
                        focus: focusNodes[$userNameProfile],
                        errorText:
                            profileState.validationErrors[$userNameProfile],
                      ),
                      InputForm(
                        label: S.current.Correo_electronico,
                        maxLength: 50,
                        value: profileState.email!,
                        enable: enableInput,
                        focus: focusNodes[$emailProfile],
                        onChanged: (value) {
                          profileNotifier.updateEmail(value);
                        },
                        errorText: profileState.validationErrors[$emailProfile],
                      ),
                      InputForm(
                        label: S.current.Primer_nombre,
                        maxLength: 25,
                        value: profileState.profile!.firstName,
                        enable: enableInput,
                        focus: focusNodes[$firstNameProfile],
                        onChanged: (value) {
                          profileNotifier.updateProfileField(
                              $firstNameProfile, value);
                        },
                        allCharacters: false,
                        errorText:
                            profileState.validationErrors[$firstNameProfile],
                      ),
                      InputForm(
                        label: S.current.Segundo_nombre,
                        maxLength: 25,
                        value: profileState.profile!.secondName ?? '-',
                        enable: enableInput,
                        onChanged: (value) {
                          profileNotifier.updateProfileField(
                              $secondNameProfile, value);
                        },
                        allCharacters: false,
                      ),
                      InputForm(
                        label: S.current.Primer_apellido,
                        maxLength: 25,
                        value: profileState.profile!.surname,
                        enable: enableInput,
                        focus: focusNodes[$surnameProfile],
                        onChanged: (value) {
                          profileNotifier.updateProfileField(
                              $surnameProfile, value);
                        },
                        allCharacters: false,
                        errorText:
                            profileState.validationErrors[$surnameProfile],
                      ),
                      InputForm(
                        label: S.current.Segundo_apellido,
                        maxLength: 25,
                        value: profileState.profile!.secondSurname ?? '-',
                        enable: enableInput,
                        onChanged: (value) {
                          profileNotifier.updateProfileField(
                              $secondSurnameProfile, value);
                        },
                        allCharacters: false,
                      ),
                      SelectBox(
                        enable: enableInput,
                        valueInitial: profileState.profile!.gender,
                        label: S.current.Sexo,
                        onSelected: (value) {
                          profileNotifier.updateProfileField(
                              $genderProfile, value!);
                        },
                        deleteSelection: false,
                        listItems: const [$masculinoProfile, $femeninoProfile],
                        errorText:
                            profileState.validationErrors[$genderProfile],
                      ),
                      InputForm(
                        label: S.current.Cedula,
                        maxLength: 16,
                        value: profileState.profile!.identificationNumber,
                        enable: enableInput,
                        focus: focusNodes[$identificationNumbereProfile],
                        onChanged: (value) {
                          profileNotifier.updateProfileField(
                              $identificationNumbereProfile, value);
                        },
                        errorText: profileState
                            .validationErrors[$identificationNumbereProfile],
                      ),
                      InputForm(
                        label: S.current.Fecha_de_nacimiento,
                        value: profileState.profile!.birthday
                            .split('-')
                            .reversed
                            .join('-'),
                        enable: enableInput,
                        readOnly: true,
                        controllerExt: controller,
                        onTap: () =>
                            selectDate(context, profileState.profile!.birthday),
                        onChanged: (value) {
                          profileNotifier.updateProfileField(
                              $birthdayProfile, value);
                        },
                        errorText:
                            profileState.validationErrors[$birthdayProfile],
                      ),
                      if (profileState.roles!.contains($tutor))
                        InputForm(
                            label: S.current.Telefono,
                            maxLength: 8,
                            isNumber: true,
                            value: profileState.profile!.telephone ?? '',
                            enable: enableInput,
                            focus: focusNodes[$telephoneProfile],
                            onChanged: (value) {
                              profileNotifier.updateProfileField(
                                  $telephoneProfile, value);
                            },
                            errorText: profileState
                                .validationErrors[$telephoneProfile]),
                      InputForm(
                        label: S.current.Celular,
                        maxLength: 8,
                        isNumber: true,
                        value: profileState.profile!.phoneNumber,
                        enable: enableInput,
                        focus: focusNodes[$phoneNumberProfile],
                        onChanged: (value) {
                          profileNotifier.updateProfileField(
                              $phoneNumberProfile, value);
                        },
                        errorText:
                            profileState.validationErrors[$phoneNumberProfile],
                      ),
                      InputForm(
                        label: S.current.Direccion,
                        maxLength: 100,
                        maxLines: 5,
                        enable: enableInput,
                        onChanged: (value) {
                          profileNotifier.updateProfileField(
                              $addressProfile, value);
                        },
                        errorText:
                            profileState.validationErrors[$addressProfile],
                        value: profileState.profile!.address,
                      ),
                      const SizedBox(height: 50)
                    ],
                  ),
                ),
              ),
            ]),
            drawer: const SideMenu(),
            floatingActionButton: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Visibility(
                  visible: !enableInput,
                  child: ButtonTextIcon(
                    title: S.current.Cambiar_contrasena,
                    icon: const Icon(Icons.edit),
                    buttonColor: $colorSuccess,
                    onClic: () {
                      modalPassword(context: context, isVerifided: true);
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Visibility(
                  visible: !enableInput,
                  child: ButtonTextIcon(
                    title: S.current.Editar,
                    icon: const Icon(Icons.edit),
                    buttonColor: $colorBlueGeneral,
                    onClic: () {
                      if (profileState.permmisions!.contains($updateProfile)) {
                        setState(
                          () {
                            profileNotifier.assingState();
                            enableInput = true;
                          },
                        );
                      } else {
                        toastAlert(
                            iconAlert: const Icon(Icons.update),
                            context: context,
                            title: S.current.No_autorizado,
                            description:
                                S.current.No_cuenta_con_el_permiso_necesario,
                            typeAlert: ToastificationType.info);
                      }
                    },
                  ),
                ),
                Visibility(
                  visible: enableInput,
                  child: ButtonTextIcon(
                    title: S.current.Actualizar,
                    icon: const Icon(Icons.update),
                    buttonColor: $colorSuccess,
                    onClic: () {
                      clickSave = true;
                      if (profileNotifier.checkFields()) {
                        modalDialogConfirmation(
                          context: context,
                          titleButtonConfirm: S.current.Si_actualizar,
                          question: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text:
                                  S.current.Esta_Seguro_de_actualizar_los_datos,
                              style: const TextStyle(
                                  fontSize: 14, color: $colorTextBlack),
                            ),
                          ),
                          buttonColorConfirm: $colorSuccess,
                          onClic: () async {
                            if (context.mounted) Navigator.of(context).pop();
                            if (profileState.roles!.contains($tutor)) {
                              await profileNotifier.updateTutor();
                            } else {
                              await profileNotifier.updateTherapist();
                            }
                            setState(() {
                              enableInput = false;
                            });
                          },
                        );
                      }
                      clickSave = false;
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Visibility(
                  visible: enableInput,
                  child: ButtonTextIcon(
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
                            text: S.current.Esta_seguro_de_salir_de_la_edicion,
                            style: const TextStyle(
                                fontSize: 14, color: $colorTextBlack),
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
                            ref.read(profileProvider.notifier).restoredState();
                          });
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        if (profileState.isUpdateData == true)
          const Opacity(
            opacity: 0.5,
            child: ModalBarrier(dismissible: false, color: $colorTextBlack),
          ),
        if (profileState.isUpdateData == true)
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(height: 25),
                Text(
                  S.current.Cargando,
                  style: const TextStyle(
                    color: Colors.white,
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
