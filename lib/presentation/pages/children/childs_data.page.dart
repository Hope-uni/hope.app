import 'package:flutter/material.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/infrastructure/infrastructure.dart';
import 'package:hope_app/presentation/utils/utils.dart';
import 'package:hope_app/presentation/widgets/widgets.dart';

class ChildsDataPage extends StatefulWidget {
  const ChildsDataPage({super.key});

  @override
  State<ChildsDataPage> createState() => _ChildsDataPageState();
}

class _ChildsDataPageState extends State<ChildsDataPage> {
  bool enableInput = false;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.Informacion_del_nino),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30),
        width: size.width,
        height: size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              _UserData(
                enableInput: enableInput,
                size: size,
                sizeInputs: 150,
              ),
              const SizedBox(
                height: 12,
              ),
              ..._childDataForm(enableInput: enableInput),
              Text(
                S.current.Logros,
                style: const TextStyle(fontSize: 20),
              ),
              SizedBox(
                width: size.width,
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                            width: 150,
                            height: 150,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: const ImageLoad(
                              height: 140,
                              width: 140,
                              urlImage:
                                  '', //TODO: Agregar url de logros de los niños
                            )),
                        const Text('Buen Comportamiento')
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 75,
              ),
            ],
          ),
        ),
      ),
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
        const SizedBox(
          width: 10,
        ),
        Visibility(
            visible: !enableInput,
            child: ButtonTextIcon(
                title: S.current.Avanzar_de_fase,
                icon: const Icon(Icons.show_chart),
                buttonColor: $colorSuccess,
                onClic: () {
                  modalDialogConfirmation(
                    context: context,
                    titleButtonConfirm: S.current.Si_avanzar,
                    question:
                        '${S.current.Esta_seguro_de_avanzar_de_fase_a('Mario Ramos')} \n\nFase 3  =>  Fase 4',
                    iconButtonConfirm: const Icon(Icons.check),
                    buttonColorConfirm: $colorSuccess,
                    onClic: () {
                      Navigator.of(context).pop();
                    },
                  );
                })),
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
                onClic: () {
                  setState(() {
                    enableInput = false;
                  });
                })),
      ]),
    );
  }
}

class _UserData extends StatelessWidget {
  const _UserData({
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
                    width: 250,
                    height: sizeInputs,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: FadeInImage(
                        height: 140,
                        width: 140,
                        fit: BoxFit.cover,
                        placeholderFit: BoxFit.cover,
                        imageErrorBuilder: (context, error, stackTrace) {
                          return Image.asset('assets/img/no-image.png');
                        },
                        placeholder:
                            const AssetImage('assets/gif/jar-loading.gif'),
                        image: const AssetImage(
                            //TODO : Cambiar por url de la imagen del niño
                            'assets/img/no-image.png')) /* const NetworkImage(
                          'https://static.wixstatic.com/media/4d02c4_8ea3fe5159c8431689f97f5cc973e34c~mv2.png/v1/fill/w_600,h_338,al_c,q_85,usm_0.66_1.00_0.01,enc_auto/4d02c4_8ea3fe5159c8431689f97f5cc973e34c~mv2.png')),*/
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  child: Text(S.current.Progreso)),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 50),
                child: const LinearProgressIndicator(
                  value: 0.5,
                ),
              ),
              Container(
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  child: Text('${S.current.Progreso} | 50%')),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 50),
                child: const LinearProgressIndicator(
                  value: 0.8,
                ),
              ),
              Container(
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  child: const Text('Fase 3 | 80%')),
            ],
          ),
        ),
      ],
    );
  }
}

List<Widget> _childDataForm({required bool enableInput}) {
  return [
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
          label: S.current.Nombre_de_usuario,
          maxLength: 8,
          value: 'mramos',
          enable: enableInput,
          onChanged: (value) {},
        ),
        InputForm(
          label: S.current.Fecha_de_nacimiento,
          maxLength: 14,
          value: '22/10/1997',
          enable: enableInput,
          onChanged: (value) {},
        ),
        InputForm(
          label: S.current.Edad,
          value: '27 años, 10 meses y 15 dias',
          enable: false,
        ),
        InputForm(
          label: S.current.Sexo,
          maxLength: 8,
          value: 'Masculino',
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
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InputForm(
          label: S.current.Telefono_de_casa,
          value: '54645566',
          enable: false,
          onChanged: (value) {},
        ),
        InputForm(
          label: S.current.Tutor,
          value: 'Maria Alejandra Ramos Irigoyen',
          enable: false,
          onChanged: (value) {},
        ),
        InputForm(
          label: S.current.Contacto_tutor,
          value: '121422112',
          enable: false,
          onChanged: (value) {},
        ),
      ],
    ),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InputForm(
          label: S.current.Terapeuta,
          value: 'Anthony Alexander Rayo Mejia',
          enable: false,
          onChanged: (value) {},
        ),
        InputForm(
          label: S.current.Contacto_terapeuta,
          value: '56564456',
          enable: false,
          onChanged: (value) {},
        ),
      ],
    ),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InputForm(
          label: S.current.Observaciones,
          maxLength: 100,
          maxLines: 15,
          enable: enableInput,
          onChanged: (value) {},
          value:
              'Al niño le gusta mucho la manzana, no le gusta que le toquen el cabello, se lleva muy bien con sus compañeros y odia los gatos,',
        ),
      ],
    ),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InputForm(
          label: S.current.Pictogramas_blanco_negro,
          maxLength: 50,
          value: 'Activado',
          enable: enableInput,
          onChanged: (value) {},
        ),
        InputForm(
          label: S.current.Actividad_Actual,
          value: 'Selecciona 5 pictogramas de animales',
          enable: false,
          onChanged: (value) {},
        ),
      ],
    ),
  ];
}
