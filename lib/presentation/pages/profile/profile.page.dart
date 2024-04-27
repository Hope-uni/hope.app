import 'package:flutter/material.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/infrastructure/infrastructure.dart';
import 'package:hope_app/presentation/utils/utils.dart';
import 'package:hope_app/presentation/widgets/widgets.dart';
import 'package:toastification/toastification.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool enableInput = false;
  final CameraGalleryDataSourceImpl image = CameraGalleryDataSourceImpl();
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    const double sizeInputs = 150;

    return DefaultTabController(
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
            height: size.height,
            width: size.width,
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
                    width: sizeInputs,
                    child: Center(
                      child: Stack(children: [
                        ClipOval(
                          child: Container(
                              width: 150,
                              height: sizeInputs,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: const ImageLoad(
                                height: 150,
                                width: 150,
                                urlImage: '',
                              )),
                        ),
                        Visibility(
                          visible: enableInput,
                          child: Positioned(
                            bottom: 0,
                            right: 0,
                            child: IconButton.filled(
                                iconSize: 30,
                                style: const ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                        $colorBlueGeneral)),
                                onPressed: () {
                                  bottomSheetModal(
                                      context: context,
                                      width: size.width,
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
                                                .Seleccione_foto_de_perfil)),
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
                                                  IconButton(
                                                      onPressed: () async {
                                                        // ignore: unused_local_variable
                                                        final photo =
                                                            await image
                                                                .selectImage();
                                                      },
                                                      icon: const Icon(
                                                          Icons.photo)),
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
                                                          Icons.add_a_photo)),
                                                  Text(S.current.Camara),
                                                ],
                                              )
                                            ],
                                          ),
                                        )
                                      ]);
                                },
                                icon: const Icon(Icons.camera_alt)),
                          ),
                        )
                      ]),
                    ),
                  ),
                  Row(
                    children: [
                      InputForm(
                        label: S.current.Nombre_de_usuario,
                        maxLength: 50,
                        value: 'LordMario',
                        enable: enableInput,
                        onChanged: (value) {},
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      InputForm(
                        label: S.current.Correo_electronico,
                        maxLength: 100,
                        value: 'marioramosmejia2243@gmail.com',
                        enable: enableInput,
                        onChanged: (value) {},
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InputForm(
                        label: S.current.Primer_nombre,
                        maxLength: 50,
                        value: 'Mario',
                        enable: enableInput,
                        onChanged: (value) {},
                      ),
                      InputForm(
                        label: S.current.Segundo_nombre,
                        maxLength: 50,
                        value: 'Jose',
                        enable: enableInput,
                        onChanged: (value) {},
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      InputForm(
                        label: S.current.Primer_apellido,
                        maxLength: 50,
                        value: 'Ramos',
                        enable: enableInput,
                        onChanged: (value) {},
                      ),
                      InputForm(
                        label: S.current.Segundo_apellido,
                        maxLength: 50,
                        value: 'Mejia',
                        enable: enableInput,
                        onChanged: (value) {},
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InputForm(
                        label: S.current.Cedula,
                        maxLength: 14,
                        value: '0012210970007L',
                        enable: enableInput,
                        onChanged: (value) {},
                      ),
                      InputForm(
                        label: S.current.Edad,
                        value: '27 años, 10 meses y 15 dias',
                        enable: false,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      InputForm(
                        label: S.current.Telefono,
                        maxLength: 8,
                        value: '57144515',
                        enable: enableInput,
                        onChanged: (value) {},
                      ),
                      InputForm(
                        label: S.current.Celular,
                        maxLength: 8,
                        value: '81524091',
                        enable: enableInput,
                        onChanged: (value) {},
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InputForm(
                        label: S.current.Direccion,
                        maxLength: 100,
                        maxLines: 5,
                        enable: enableInput,
                        onChanged: (value) {},
                        value:
                            'Del pali de san judas 3 c al sur 1/2 c abajo , 5ta casa mano izquierda',
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  )
                ],
              ),
            ),
          ),
        ]),
        drawer: const SideMenu(),
        floatingActionButton:
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          Visibility(
              visible: !enableInput,
              child: ButtonTextIcon(
                  title: S.current.Editar,
                  icon: const Icon(Icons.edit),
                  buttonColor: $colorBlueGeneral,
                  onClic: () {
                    setState(() {
                      enableInput = true;
                    });
                  })),
          Visibility(
              visible: enableInput,
              child: ButtonTextIcon(
                  title: S.current.Actualizar,
                  icon: const Icon(Icons.update),
                  buttonColor: $colorSuccess,
                  onClic: () {
                    modalDialogConfirmation(
                      context: context,
                      titleButtonConfirm: S.current.Si_actualizar,
                      question: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: S.current.Esta_Seguro_de_actualizar_los_datos,
                          style: const TextStyle(
                              fontSize: 14, color: $colorTextBlack),
                        ),
                      ),
                      buttonColorConfirm: $colorSuccess,
                      onClic: () {
                        Navigator.of(context).pop();
                        toastAlert(
                            iconAlert: const Icon(Icons.update),
                            context: context,
                            title: S.current.Actualizado_con_exito,
                            description:
                                S.current.Informacion_personal_actualizada,
                            typeAlert: ToastificationType.info);
                      },
                    );
                  })),
          const SizedBox(
            width: 10,
          ),
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
                      },
                    );
                  })),
        ]),
      ),
    );
  }
}
