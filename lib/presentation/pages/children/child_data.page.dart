import 'package:flutter/material.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/infrastructure/infrastructure.dart';
import 'package:hope_app/presentation/utils/utils.dart';
import 'package:hope_app/presentation/widgets/widgets.dart';
import 'package:toastification/toastification.dart';

class ChildDataPage extends StatefulWidget {
  final int idChild;
  const ChildDataPage({super.key, required this.idChild});

  @override
  State<ChildDataPage> createState() => _ChildDataPageState();
}

class _ChildDataPageState extends State<ChildDataPage> {
  bool enableInput = false;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(S.current.Informacion_del_nino),
          bottom: TabBar(
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
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ..._childPersonalData(
                      enableInput: enableInput,
                      context: context,
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: SingleChildScrollView(
                child: Column(
                  children: [..._generalInformation(enableInput: enableInput)],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: SingleChildScrollView(
                child: Column(
                  children: [..._childProgressData(enableInput: enableInput)],
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
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
                },
              ),
            ),
            const SizedBox(width: 10),
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
              ),
            ),
            Visibility(
              visible: enableInput,
              child: ButtonTextIcon(
                title: S.current.Actualizar,
                icon: const Icon(Icons.update),
                buttonColor: $colorBlueGeneral,
                onClic: () {
                  modalDialogConfirmation(
                    context: context,
                    titleButtonConfirm: S.current.Si_actualizar,
                    question: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: S.current.Esta_Seguro_de_actualizar_los_datos,
                        style: const TextStyle(
                          fontSize: 16,
                          color: $colorTextBlack,
                        ),
                      ),
                    ),
                    buttonColorConfirm: $colorSuccess,
                    onClic: () {
                      Navigator.of(context).pop();
                      toastAlert(
                        iconAlert: const Icon(Icons.update),
                        context: context,
                        title: S.current.Actualizado_con_exito,
                        description: S.current.Informacion_del_nino_actualizada,
                        typeAlert: ToastificationType.info,
                      );
                    },
                  );
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
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List<Widget> _childPersonalData({
  required bool enableInput,
  required BuildContext context,
}) {
  final CameraGalleryDataSourceImpl image = CameraGalleryDataSourceImpl();

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
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: const ImageLoad(urlImage: ''),
          )),
          Visibility(
            visible: enableInput,
            child: Positioned(
              bottom: 0,
              right: 0,
              child: IconButton.filled(
                  style: const ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll($colorBlueGeneral)),
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
                          margin: const EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          child: Text(
                            S.current.Seleccione_foto_de_perfil,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
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
                  icon: const Icon(Icons.camera_alt)),
            ),
          )
        ]),
      ),
    ),
    const SizedBox(height: 10),
    InputForm(
      label: S.current.Primer_nombre,
      maxLength: 50,
      value: 'Mario', //TODO: Cambiar cuando este listo el endpoint
      enable: enableInput,
      onChanged: (value) {},
    ),
    InputForm(
      label: S.current.Segundo_nombre,
      maxLength: 50,
      value: 'Jose', //TODO: Cambiar cuando este listo el endpoint
      enable: enableInput,
      onChanged: (value) {},
    ),
    InputForm(
      label: S.current.Primer_apellido,
      maxLength: 50,
      value: 'Ramos', //TODO: Cambiar cuando este listo el endpoint
      enable: enableInput,
      onChanged: (value) {},
    ),
    InputForm(
      label: S.current.Segundo_apellido,
      maxLength: 50,
      value: 'Mejia', //TODO: Cambiar cuando este listo el endpoint
      enable: enableInput,
      onChanged: (value) {},
    ),
    InputForm(
      label: S.current.Nombre_de_usuario,
      maxLength: 8,
      value: 'mramos', //TODO: Cambiar cuando este listo el endpoint
      enable: enableInput,
      onChanged: (value) {},
    ),
    //TODO: Cambiar cuando este listo el endpoint
    SelectBox(
      enable: enableInput,
      valueInitial: 'Masculino',
      label: S.current.Sexo,
      onSelected: (value) {},
      listItems: const ['Masculino', 'Femenino'],
    ),
    InputForm(
      label: S.current.Fecha_de_nacimiento,
      maxLength: 14,
      value: '22/10/1997', //TODO: Cambiar cuando este listo el endpoint
      enable: enableInput,
      onChanged: (value) {},
    ),
    InputForm(
      label: S.current.Edad,
      //TODO: Cambiar cuando este listo el endpoint
      value: '27 años, 10 meses y 15 dias',
      enable: false,
    ),
    InputForm(
      label: S.current.Direccion,
      maxLength: 100,
      maxLines: 5,
      enable: enableInput,
      onChanged: (value) {},
      //TODO: Cambiar cuando este listo el endpoint
      value:
          'Del pali de san judas 3 c al sur 1/2 c abajo , 5ta casa mano izquierda',
    ),
    const SizedBox(height: 55),
  ];
}

List<Widget> _generalInformation({required bool enableInput}) {
  return [
    const SizedBox(height: 15),
    //TODO: Cambiar cuando este listo el endpoint
    SelectBox(
      enable: enableInput,
      valueInitial: 'Activado',
      label: S.current.Pictogramas_blanco_negro,
      onSelected: (value) {},
      listItems: const ['Activado', 'Inactivado'],
    ),
    InputForm(
      label: S.current.Tutor,
      //TODO: Cambiar cuando este listo el endpoint
      value: 'Maria Alejandra Ramos Irigoyen',
      enable: false,
      onChanged: (value) {},
    ),
    InputForm(
      label: S.current.Contacto_tutor,
      value: '121422112', //TODO: Cambiar cuando este listo el endpoint
      enable: false,
      onChanged: (value) {},
    ),
    InputForm(
      label: S.current.Telefono_de_casa,
      value: '54645566', //TODO: Cambiar cuando este listo el endpoint
      enable: false,
      onChanged: (value) {},
    ),

    InputForm(
      label: S.current.Terapeuta,
      //TODO: Cambiar cuando este listo el endpoint
      value: 'Anthony Alexander Rayo Mejia',
      enable: false,
      onChanged: (value) {},
    ),
    InputForm(
      label: S.current.Contacto_terapeuta,
      value: '56564456', //TODO: Cambiar cuando este listo el endpoint
      enable: false,
      onChanged: (value) {},
    ),
    const SizedBox(
      height: 55,
    ),
  ];
}

List<Widget> _childProgressData({required bool enableInput}) {
  return [
    Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(S.current.Progresos),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      margin: const EdgeInsets.symmetric(vertical: 15),
                      //TODO: Cambiar cuando este listo el endpoint
                      child: Text('${S.current.Progreso_general} | 50%')),
                  const SizedBox(
                    width: 20,
                  ),
                  const SizedBox(
                    height: 100,
                    width: 100,
                    child: CircularProgressIndicator(
                      value: 0.5,
                      backgroundColor: Colors.grey,
                      strokeWidth: 10,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                      margin: const EdgeInsets.symmetric(vertical: 15),
                      //TODO: Cambiar cuando este listo el endpoint
                      child: Text('${S.current.progreso_de_fase} 3 | 80%')),
                  const SizedBox(
                    width: 20,
                  ),
                  const SizedBox(
                    height: 100,
                    width: 100,
                    child: CircularProgressIndicator(
                      value: 0.8,
                      backgroundColor: Colors.grey,
                      strokeWidth: 10,
                    ),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    ),
    const SizedBox(
      height: 20,
    ),
    InputForm(
      label: S.current.Observaciones,
      maxLength: 100,
      maxLines: 6,
      enable: enableInput,
      onChanged: (value) {},
      //TODO: Cambiar cuando este listo el endpoint
      value:
          'Al niño le gusta mucho la manzana, no le gusta que le toquen el cabello, se lleva muy bien con sus compañeros y odia los gatos,',
    ),
    InputForm(
      label: S.current.Actividad_Actual,
      //TODO: Cambiar cuando este listo el endpoint
      value: 'Selecciona 5 pictogramas de animales',
      enable: false,
      onChanged: (value) {},
    ),
    Text(
      S.current.Logros,
      style: const TextStyle(fontSize: 20),
    ),
    const ImageListVIew(
      isDecoration: false,
      isSelect: false,
    ),
    const SizedBox(height: 55),
  ];
}
