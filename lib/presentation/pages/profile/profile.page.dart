import 'package:flutter/material.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/infrastructure/infrastructure.dart';
import 'package:hope_app/presentation/utils/utils.dart';
import 'package:hope_app/presentation/widgets/widgets.dart';

bool isTablet(BuildContext context) {
  final size = MediaQuery.of(context).size;
  return size.width > 850;
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final CameraGalleryDataSourceImpl image = CameraGalleryDataSourceImpl();
    final double sizeInputs = isTablet(context) ? 250 : 150;
    bool enableInput = false;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Perfil',
        ),
      ),
      body: Container(
        height: size.height,
        width: size.width,
        margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: size.width,
                child: Text(
                  S.current.Datos_del_usuario,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              UserData(
                  sizeInputs: sizeInputs,
                  enableInput: enableInput,
                  size: size,
                  image: image),
              const SizedBox(
                height: 20,
              ),
              const Divider(),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: size.width,
                child: Text(
                  S.current.Datos_personales,
                  style: const TextStyle(fontSize: 20),
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
                height: 40,
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
    required this.image,
  });

  final double sizeInputs;
  final bool enableInput;
  final Size size;
  final CameraGalleryDataSourceImpl image;

  @override
  Widget build(BuildContext context) {
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
                  width: 250,
                  height: sizeInputs,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Image.network(
                    'https://static.wixstatic.com/media/4d02c4_8ea3fe5159c8431689f97f5cc973e34c~mv2.png/v1/fill/w_600,h_338,al_c,q_85,usm_0.66_1.00_0.01,enc_auto/4d02c4_8ea3fe5159c8431689f97f5cc973e34c~mv2.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Visibility(
                visible: enableInput,
                child: Positioned(
                  bottom: 0,
                  right: 0,
                  child: IconButton.filled(
                      iconSize: isTablet(context) ? 40 : 30,
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
