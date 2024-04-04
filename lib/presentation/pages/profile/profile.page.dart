import 'package:flutter/material.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/infrastructure/infrastructure.dart';
import 'package:hope_app/presentation/utils/utils.dart';
import 'package:hope_app/presentation/widgets/widgets.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    const double sizeInputs = 150;
    bool enableInput = true;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.current.Perfil,
        ),
      ),
      body: Container(
        height: size.height,
        width: size.width,
        margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: size.width,
                alignment: Alignment.centerLeft,
                height: 50,
                padding: const EdgeInsets.only(left: 20),
                decoration: const BoxDecoration(
                    color: $colorBlueGeneral,
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(20),
                        topLeft: Radius.circular(20))),
                child: Text(
                  S.current.Datos_del_usuario,
                  style: const TextStyle(fontSize: 20, color: $colorTextWhite),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              UserData(
                sizeInputs: sizeInputs,
                enableInput: enableInput,
                size: size,
              ),
              const SizedBox(
                height: 20,
              ),
              //const Divider(),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: size.width,
                alignment: Alignment.centerLeft,
                height: 50,
                padding: const EdgeInsets.only(left: 20),
                decoration: const BoxDecoration(
                    color: $colorBlueGeneral,
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(20),
                        topLeft: Radius.circular(20))),
                child: Text(
                  S.current.Datos_personales,
                  style: const TextStyle(fontSize: 20, color: $colorTextWhite),
                ),
              ),
              const SizedBox(
                height: 20,
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
      drawer: const SideMenu(),
      floatingActionButton:
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        Visibility(
            visible: !enableInput,
            child: ButtonTextIcon(
                title: S.current.Editar,
                icon: const Icon(Icons.edit),
                buttonColor: $colorBlueGeneral,
                onClic: () {})),
        Visibility(
            visible: enableInput,
            child: ButtonTextIcon(
                title: S.current.Guardar,
                icon: const Icon(Icons.save),
                buttonColor: $colorSuccess,
                onClic: () {})),
        const SizedBox(
          width: 10,
        ),
        Visibility(
            visible: enableInput,
            child: ButtonTextIcon(
                title: S.current.Cancelar,
                icon: const Icon(Icons.cancel),
                buttonColor: $colorError,
                onClic: () {})),
      ]),
    );
  }
}

class UserData extends StatelessWidget {
  const UserData({
    super.key,
    required this.sizeInputs,
    required this.enableInput,
    required this.size,
  });

  final double sizeInputs;
  final bool enableInput;
  final Size size;

  @override
  Widget build(BuildContext context) {
    final CameraGalleryDataSourceImpl image = CameraGalleryDataSourceImpl();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
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
                          backgroundColor:
                              MaterialStatePropertyAll($colorBlueGeneral)),
                      onPressed: () {
                        bottomSheetModal(
                            context: context,
                            width: size.width,
                            arrayWidgets: [
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 15),
                                width: 40,
                                height: 7,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: $colorButtonDisable,
                                ),
                              ),
                              Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  width: size.width,
                                  child: Text(
                                      S.current.Seleccione_foto_de_perfil)),
                              Container(
                                width: size.width,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 20),
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
                                                  await image.selectImage();
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
                                              final imagen =
                                                  await image.takePhoto();
                                            },
                                            icon:
                                                const Icon(Icons.add_a_photo)),
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
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  InputForm(
                    label: S.current.Nombre_de_usuario,
                    maxLength: 50,
                    value: 'LordMario',
                    enable: enableInput,
                    onChanged: (value) {},
                  ),
                  InputForm(
                    label: S.current.Contrasena,
                    maxLength: 50,
                    value: 'alejandra',
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
            ],
          ),
        ),
      ],
    );
  }
}
