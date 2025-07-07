import 'dart:io' show File;
import 'package:clearable_dropdown/clearable_dropdown.dart' as clearable;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
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
  bool isClickPhoto = false;
  String? imagePathCel;

  final CameraGalleryDataSourceImpl image = CameraGalleryDataSourceImpl();
  final TextEditingController controller = TextEditingController();

  final Map<String, FocusNode> focusNodes = {
    $userNameProfile: FocusNode(),
    $emailProfile: FocusNode(),
    $firstNameProfile: FocusNode(),
    $surnameProfile: FocusNode(),
    $identificationNumbereProfile: FocusNode(),
    $phoneNumberProfile: FocusNode(),
    $telephoneProfile: FocusNode(),
    $addressProfile: FocusNode(),
  };

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (mounted) {
        ref.read(profileProvider.notifier).restoredState();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final profileState = ref.watch(profileProvider);
    final profileNotifier = ref.read(profileProvider.notifier);

    ref.listen(profileProvider, (previous, next) {
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

      if (next.isUpdateData == false && next.showtoastAlert == true) {
        if (context.mounted) {
          toastAlert(
            iconAlert: const Icon(Icons.check),
            context: context,
            title: S.current.Actualizado_con_exito,
            description: S.current.Informacion_personal_actualizada,
            typeAlert: ToastificationType.info,
          );
          setState(() {
            enableInput = false;
          });
          profileNotifier.updateResponse();
        }
      }

      if (next.isUnchanged == true) {
        toastAlert(
          context: context,
          title: S.current.Aviso,
          description: S.current.No_se_han_realizados_cambios_en_el_formulario,
          typeAlert: ToastificationType.info,
        );
        profileNotifier.updateResponse();
      }

      if (next.errorMessageApi != null) {
        toastAlert(
          context: context,
          title: S.current.Error,
          description: next.errorMessageApi!,
          typeAlert: ToastificationType.error,
        );
        profileNotifier.updateResponse();
      }
    });

    final Size size = MediaQuery.of(context).size;
    const double sizeInputs = 150;

    controller.text =
        profileState.profile!.birthday.split('-').reversed.join('-');

    Future<void> selectDate(BuildContext context, String dateValue) async {
      final DateTime now = DateTime.now();

      // Rango de fechas:
      // Máximo 100 años atrás
      final DateTime firstDate = DateTime(now.year - 100, now.month, now.day);
      // Mínimo 18 años de edad
      final DateTime lastDate = DateTime(now.year - 18, now.month, now.day);

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
        helpText: ' ',
      );

      if (pickedDate != null) {
        profileNotifier.updateBirthday(newDate: pickedDate);

        setState(() {
          controller.text =
              "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
        });
      }
    }

    Future<void> selectImage() async {
      setState(() {
        isClickPhoto = true;
      });
      final String? imagePath = await image.selectImage();
      if (imagePath != null) {
        final file = File(imagePath);
        profileNotifier.updateImage(file);
        setState(() => imagePathCel = imagePath);
      }
      setState(() {
        isClickPhoto = false;
      });
    }

    Future<void> takePhoto() async {
      setState(() {
        isClickPhoto = true;
      });
      final String? imagePath = await image.takePhoto();
      if (imagePath != null) {
        final file = File(imagePath);
        profileNotifier.updateImage(file);
        setState(() => imagePathCel = imagePath);
      }
      setState(() {
        isClickPhoto = false;
      });
    }

    return Stack(
      children: [
        DefaultTabController(
          initialIndex: 0,
          length: 1,
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
                                    S.current
                                        .Para_ver_la_foto_de_perfil_con_mas_detalle,
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
              title: Text(S.current.Perfil),
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
              GestureDetector(
                onTap: () {
                  setState(() {
                    FocusManager.instance.primaryFocus?.unfocus();
                  });
                },
                child: Container(
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
                                      urlImage: profileState.profile!.imageUrl,
                                      imagePath: imagePathCel,
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: enableInput,
                                  child: Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: IconButton.filled(
                                      iconSize: 20,
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
                                              margin:
                                                  const EdgeInsets.symmetric(
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
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20),
                                              width: size.width,
                                              child: Text(S.current
                                                  .Seleccione_foto_de_perfil),
                                            ),
                                            Container(
                                              width: size.width,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Column(
                                                    children: [
                                                      IconButton(
                                                        onPressed: () async {
                                                          await selectImage();
                                                          if (context.mounted) {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          }
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
                                                          await takePhoto();
                                                          if (context.mounted) {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          }
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
                        Focus(
                          focusNode: focusNodes[$userNameProfile],
                          child: InputForm(
                            label: S.current.Nombre_de_usuario,
                            maxLength: 15,
                            value: profileState.userName!,
                            enable: enableInput,
                            onChanged: (value) {
                              profileNotifier.updateUserName(value: value);
                            },
                            isNumberLetter: true,
                            errorText:
                                profileState.validationErrors[$userNameProfile],
                          ),
                        ),
                        Focus(
                          focusNode: focusNodes[$emailProfile],
                          child: InputForm(
                            label: S.current.Correo_electronico,
                            maxLength: 50,
                            value: profileState.email!,
                            enable: enableInput,
                            onChanged: (value) {
                              profileNotifier.updateEmail(value: value);
                            },
                            errorText:
                                profileState.validationErrors[$emailProfile],
                          ),
                        ),
                        Focus(
                          focusNode: focusNodes[$firstNameProfile],
                          child: InputForm(
                            label: S.current.Primer_nombre,
                            maxLength: 15,
                            value: profileState.profile!.firstName,
                            enable: enableInput,
                            onChanged: (value) {
                              profileNotifier.updateProfileField(
                                fieldName: $firstNameProfile,
                                newValue: value,
                              );
                            },
                            allCharacters: false,
                            errorText: profileState
                                .validationErrors[$firstNameProfile],
                          ),
                        ),
                        InputForm(
                          label: S.current.Segundo_nombre,
                          maxLength: 15,
                          value: profileState.profile!.secondName ?? '-',
                          enable: enableInput,
                          onChanged: (value) {
                            profileNotifier.updateProfileField(
                              fieldName: $secondNameProfile,
                              newValue: value,
                            );
                          },
                          allCharacters: false,
                        ),
                        Focus(
                          focusNode: focusNodes[$surnameProfile],
                          child: InputForm(
                            label: S.current.Primer_apellido,
                            maxLength: 15,
                            value: profileState.profile!.surname,
                            enable: enableInput,
                            onChanged: (value) {
                              profileNotifier.updateProfileField(
                                fieldName: $surnameProfile,
                                newValue: value,
                              );
                            },
                            allCharacters: false,
                            errorText:
                                profileState.validationErrors[$surnameProfile],
                          ),
                        ),
                        InputForm(
                          label: S.current.Segundo_apellido,
                          maxLength: 15,
                          value: profileState.profile!.secondSurname ?? '-',
                          enable: enableInput,
                          onChanged: (value) {
                            profileNotifier.updateProfileField(
                              fieldName: $secondSurnameProfile,
                              newValue: value,
                            );
                          },
                          allCharacters: false,
                        ),
                        clearable.ClearableDropdown(
                          helperText: ' ',
                          listItems: [
                            clearable.CatalogObject(id: 0, name: $masculino),
                            clearable.CatalogObject(id: 1, name: $femenino)
                          ],
                          enable: enableInput,
                          valueInitial: profileState.profile!.gender,
                          label: S.current.Sexo,
                          onSelected: (value) {
                            profileNotifier.updateProfileField(
                              fieldName: $genderProfile,
                              newValue: value! == "0" ? $masculino : $femenino,
                            );
                          },
                          errorText:
                              profileState.validationErrors[$genderProfile],
                        ),
                        Focus(
                          focusNode: focusNodes[$identificationNumbereProfile],
                          child: InputForm(
                            label: S.current.Cedula,
                            maxLength: 16,
                            value: profileState.profile!.identificationNumber!,
                            enable: enableInput,
                            onChanged: (value) {
                              profileNotifier.updateProfileField(
                                fieldName: $identificationNumbereProfile,
                                newValue: value,
                              );
                            },
                            errorText: profileState.validationErrors[
                                $identificationNumbereProfile],
                          ),
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
                          onTap: () => selectDate(
                              context, profileState.profile!.birthday),
                          onChanged: (value) {
                            profileNotifier.updateProfileField(
                              fieldName: $birthdayProfile,
                              newValue: value,
                            );
                          },
                          errorText:
                              profileState.validationErrors[$birthdayProfile],
                        ),
                        Visibility(
                          visible: !enableInput,
                          child: InputForm(
                            label: S.current.Edad,
                            value: profileState.profile!.age.toString(),
                            enable: false,
                          ),
                        ),
                        if (profileState.roles!.contains($tutor))
                          Focus(
                            focusNode: focusNodes[$telephoneProfile],
                            child: InputForm(
                                label: S.current.Telefono,
                                maxLength: 8,
                                isNumber: true,
                                value: profileState.profile!.telephone ?? '',
                                enable: enableInput,
                                onChanged: (value) {
                                  profileNotifier.updateProfileField(
                                    fieldName: $telephoneProfile,
                                    newValue: value,
                                  );
                                },
                                errorText: profileState
                                    .validationErrors[$telephoneProfile]),
                          ),
                        Focus(
                          focusNode: focusNodes[$phoneNumberProfile],
                          child: InputForm(
                            label: S.current.Celular,
                            maxLength: 8,
                            isNumber: true,
                            value: profileState.profile!.phoneNumber!,
                            enable: enableInput,
                            onChanged: (value) {
                              profileNotifier.updateProfileField(
                                fieldName: $phoneNumberProfile,
                                newValue: value,
                              );
                            },
                            errorText: profileState
                                .validationErrors[$phoneNumberProfile],
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
                              profileNotifier.updateProfileField(
                                fieldName: $addressProfile,
                                newValue: value,
                              );
                            },
                            errorText:
                                profileState.validationErrors[$addressProfile],
                            value: profileState.profile!.address,
                          ),
                        ),
                        const SizedBox(height: 50)
                      ],
                    ),
                  ),
                ),
              ),
            ]),
            drawer: const SideMenu(),
            floatingActionButton: profileState.isLoading == true ||
                    profileState.isUpdateData == true
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
                        visible: !enableInput,
                        shape: const CircleBorder(),
                        child: const Icon(Icons.change_circle,
                            color: $colorTextWhite),
                        backgroundColor: $colorSuccess,
                        label: S.current.Cambiar_contrasena,
                        onTap: () {
                          modalPassword(context: context, isVerifided: true);
                        },
                      ),
                      SpeedDialChild(
                        visible: !enableInput,
                        shape: const CircleBorder(),
                        child: const Icon(Icons.edit, color: $colorTextWhite),
                        backgroundColor: $colorBlueGeneral,
                        label: S.current.Editar,
                        onTap: () {
                          if (profileState.permmisions!
                              .contains($updateProfile)) {
                            setState(
                              () {
                                profileNotifier.assingState();
                                enableInput = true;
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
                        visible: enableInput,
                        shape: const CircleBorder(),
                        child: const Icon(Icons.update, color: $colorTextWhite),
                        backgroundColor: $colorSuccess,
                        label: S.current.Actualizar,
                        onTap: () {
                          clickSave = true;
                          if (profileNotifier.checkFields()) {
                            modalDialogConfirmation(
                              context: context,
                              titleButtonConfirm: S.current.Si_actualizar,
                              question: RichText(
                                text: TextSpan(
                                  text: S.current
                                      .Esta_Seguro_de_actualizar_los_datos,
                                  style: const TextStyle(
                                      fontSize: 14, color: $colorTextBlack),
                                ),
                              ),
                              buttonColorConfirm: $colorSuccess,
                              onClic: () async {
                                if (context.mounted) {
                                  Navigator.of(context).pop();
                                }
                                if (profileState.roles!.contains($tutor)) {
                                  await profileNotifier.updateTutor();
                                } else {
                                  await profileNotifier.updateTherapist();
                                }
                              },
                            );
                          }
                          clickSave = false;
                        },
                      ),
                      SpeedDialChild(
                        visible: enableInput,
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
                                text: S
                                    .current.Esta_seguro_de_salir_de_la_edicion,
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
                                imagePathCel = null;
                                ref
                                    .read(profileProvider.notifier)
                                    .restoredState();
                              });
                            },
                          );
                        },
                      ),
                    ],
                  ),
          ),
        ),
        if (profileState.isUpdateData == true || isClickPhoto == true)
          const Opacity(
            opacity: 0.5,
            child: ModalBarrier(dismissible: false, color: $colorTextBlack),
          ),
        if (profileState.isUpdateData == true || isClickPhoto == true)
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
