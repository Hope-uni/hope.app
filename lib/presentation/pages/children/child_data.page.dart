import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
  final ScrollController _scrollController = ScrollController();
  final ScrollController _scrollControllerObservations = ScrollController();

  bool _showRightArrow = true;
  bool _showLeftArrow = false;

  @override
  void initState() {
    super.initState();
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
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
                              color: Colors.transparent,
                              child: const Icon(Icons.chevron_left,
                                  size: 35, color: Colors.white),
                            ),
                          ),
                        if (_showRightArrow)
                          Positioned(
                            right: 0,
                            top: 0,
                            bottom: 0,
                            child: Container(
                              width: 45,
                              color: Colors.transparent,
                              child: const Icon(Icons.chevron_right,
                                  size: 35, color: Colors.white),
                            ),
                          ),
                      ],
                    ))),
            body: TabBarView(
              children: <Widget>[
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
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
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ..._generalInformation(enableInput: enableInput)
                      ],
                    ),
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ..._childProgressData(enableInput: enableInput)
                      ],
                    ),
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ..._achievements(
                          scrollController: _scrollControllerObservations,
                          ref: ref)
                    ],
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ..._observationsChild(
                          scrollController: _scrollControllerObservations,
                          ref: ref)
                    ],
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
                            description:
                                S.current.Informacion_del_nino_actualizada,
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
      },
    );
  }
}

List<Widget> _childPersonalData({
  required bool enableInput,
  required BuildContext context,
}) {
  final CameraGalleryDataSourceImpl image = CameraGalleryDataSourceImpl();

  //TODO: Quitar comentario y reemplazar por el gestor de estado cuando se utilice el endpoint
  /*final TextEditingController controller = TextEditingController(
      text: profileState.profile!.birthday.split('-').reversed.join('-'));*/

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
//TODO: Quitar comentario y reemplazar por el gestor de estado cuando se utilice el endpoint
    /*if (pickedDate != null) {
      ref.read(profileProvider.notifier).updateBirthday(pickedDate);

      setState(() {
        controller.text =
            "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
      });
    }*/
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
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: const ImageLoad(
                urlImage: //TODO: Reemplazar por el gestor de estado cuando se utilice el endpoint
                    'https://e7.pngegg.com/pngimages/660/375/png-clipart-mario-mario.png'),
          )),
          Visibility(
            visible: enableInput,
            child: Positioned(
              bottom: 0,
              right: 0,
              child: IconButton.filled(
                  style: const ButtonStyle(
                      backgroundColor:
                          WidgetStatePropertyAll($colorBlueGeneral)),
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
        value: //TODO: Quitar comentario y reemplazar por el gestor de estado cuando se utilice el endpoint
            '12-05-2024', //profileState.profile!.birthday.split('-').reversed.join('-'),
        enable: enableInput,
        readOnly: true,
        // controllerExt: controller,
        onTap:
            () => //TODO: Quitar comentario y reemplazar por el gestor de estado cuando se utilice el endpoint
                selectDate(
                    context, '2023-05-01') //profileState.profile!.birthday),
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

List<Widget> _observationsChild(
    {required ScrollController scrollController, required WidgetRef ref}) {
  return [
    Container(
      alignment: Alignment.centerRight,
      child: ButtonTextIcon(
          title: S.current.Agregar_observacion,
          icon: const Icon(Icons.add),
          onClic: () {}),
    ),
    Expanded(
      child: ListView.builder(
        //TODO: Cambiar cuando este listo el endpoint
        itemCount: 8,
        itemBuilder: (context, index) {
          //TODO: Cambiar el 14 cuando este listo el endpoint
          if (index < 8) {
            return const ListTileCustom(
              //TODO: Cambiar cuando este listo el endpoint
              title:
                  'El niño tiene problemas con el alcohol lo que le genere una fuerte dependencia emocional a su difunto padre el cual murio a manos de gorillas en el norte de africa',
              //TODO: Cambiar cuando este listo el endpoint
              subTitle: '\n12-10-2024     @Mario Ramos',
              styleSubTitle: FontWeight.bold,
              colorSubTitle: true,
            );
          } else {
            return const SizedBox(height: 75);
          }
        },
      ),
    ),
  ];
}

List<Widget> _achievements(
    {required ScrollController scrollController, required WidgetRef ref}) {
  return [
    Container(
      margin: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
      alignment: Alignment.centerLeft,
      child: Text(
        S.current.Actividad_actual,
        style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
      ),
    ),
    ListView(
      shrinkWrap: true, // Asegura que solo ocupe el espacio necesario
      physics: const NeverScrollableScrollPhysics(),
      children: const [
        ListTileCustom(
          //TODO: Cambiar cuando este listo el endpoint
          title: 'Crear 5 oraciones usando objetos de la casa',
          colorTitle: true,
          styleTitle: FontWeight.bold,
          //TODO: Cambiar cuando este listo el endpoint
          subTitle:
              'El niño tiene problemas con el alcohol lo que le genere una fuerte dependencia emocional a su difunto padre el cual murio a manos de gorillas en el norte de africa',
        )
      ],
    ),
    Container(
      margin: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
      alignment: Alignment.centerLeft,
      child: Text(
        S.current.Actividades_terminadas,
        style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
      ),
    ),
    Expanded(
      child: ListView.builder(
        //TODO: Cambiar cuando este listo el endpoint
        itemCount: 8,
        itemBuilder: (context, index) {
          //TODO: Cambiar el 14 cuando este listo el endpoint
          if (index < 8) {
            return const ListTileCustom(
              //TODO: Cambiar cuando este listo el endpoint
              title: 'Crear 5 oraciones usando objetos de la casa',
              colorTitle: true,
              styleTitle: FontWeight.bold,
              //TODO: Cambiar cuando este listo el endpoint
              subTitle:
                  'El niño tiene problemas con el alcohol lo que le genere una fuerte dependencia emocional a su difunto padre el cual murio a manos de gorillas en el norte de africa\n\n15-08-2024   @Mario Ramos',
            );
          } else {
            return const SizedBox(height: 75);
          }
        },
      ),
    ),
  ];
}

List<Widget> _childProgressData({required bool enableInput}) {
  return [
    Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 13, vertical: 20),
          alignment: Alignment.centerLeft,
          child: Text(
            //TODO: Reemplazar por el gestor de estado cuando se utilice el endpoint
            '${S.current.Progreso_general} | 50%',
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
          ),
        ),
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
    const SizedBox(height: 40),
    Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 13, vertical: 20),
          alignment: Alignment.centerLeft,
          child: Text(
            //TODO: Reemplazar por el gestor de estado cuando se utilice el endpoint
            '${S.current.progreso_de_fase} 3 | 80%',
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
          ),
        ),
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
    const SizedBox(height: 40),
    const SizedBox(
      height: 20,
    ),
    Container(
      margin: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
      alignment: Alignment.centerLeft,
      child: Text(
        S.current.Logros,
        style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
      ),
    ),
    const ImageListVIew(
      isDecoration: false,
      isSelect: false,
    ),
    const SizedBox(height: 55),
  ];
}
