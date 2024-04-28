import 'package:flutter/material.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/presentation/utils/utils.dart';
import 'package:hope_app/presentation/widgets/widgets.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  double width = 100;
  double heigth = 100;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //TODO: Crear variable de internacionalizacion,
        title: const Text('Crear actividad'),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              InputForm(
                value: '',
                enable: true,
                label: S.current.Nombre,
              ),
              const InputForm(
                value: '',
                enable: true,
                //TODO: Crear variable de internacionalizacion,
                label: 'Descripcion',
                maxLines: 5,
              ),
              const Row(
                children: [
                  Expanded(
                    child: SelectBox(
                      //TODO: Cambiar cuando este listo el endpoint
                      listItems: ['Fase 1', 'Fase 2', 'Fase 3', 'Fase 4'],
                      enable: true,
                      //TODO: Crear variable de internacionalizacion,
                      label: 'Fase del autismo',
                    ),
                  ),
                  Expanded(
                    child: InputForm(
                      value: '',
                      enable: true,
                      //TODO: Crear variable de internacionalizacion,
                      label: 'Puntaje',
                      isNumber: true,
                    ),
                  ),
                ],
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 15,
                ),
                child: const Text(
                  //TODO: Crear variable de internacionalizacion,
                  'Seleccione pictogramas de la solucion',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    //TODO: Cambiar cuando este listo el endpoint
                    child: SelectBox(
                      valueInitial: 'Casa',
                      label: S.current.Categoria_de_pictogramas,
                      enable: true,
                      onSelected: (value) {},
                      listItems: const ['Casa', 'Escuela'],
                    ),
                  ),
                  Expanded(
                    child: InputForm(
                      isSearch: true,
                      label: S.current.Busqueda_por_nombre,
                      value: '',
                      enable: true,
                      onChanged: (value) {},
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin:
                        const EdgeInsets.only(bottom: 15, left: 15, right: 10),
                    child: ButtonTextIcon(
                        buttonColor: $colorError,
                        title: S.current.Limpiar_filtros,
                        icon: const Icon(Icons.delete),
                        onClic: () {}),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                decoration: BoxDecoration(
                  //TODO: Cambiar a constante de diseño
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(width: 1),
                ),
                width: double.infinity,
                height: 150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              width: 100,
                              height: 100,
                              margin: const EdgeInsets.symmetric(
                                horizontal: 7,
                                vertical: 10,
                              ),
                              //TODO: Agregar url de logros de los niños cuando este listo el endpoint
                              child: const ImageLoad(urlImage: ''),
                            ),
                            IconButton(
                              style: const ButtonStyle(
                                //TODO: Cambiar a constante de diseño
                                backgroundColor:
                                    MaterialStatePropertyAll(Colors.blue),
                                iconColor:
                                    MaterialStatePropertyAll($colorTextWhite),
                              ),
                              onPressed: () {},
                              icon: const Icon(Icons.check),
                            )
                          ],
                        ),
                        //TODO: Cambiar cuando este listo el endpoint
                        const Text('Manzana')
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 15),
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 10,
                ),
                //TODO: Crear variable de internacionalizacion,
                child: const Text(
                  'Solucion',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                decoration: BoxDecoration(
                  //TODO: Cambiar a constante de diseño
                  color: Colors.green[100],
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(width: 1),
                ),
                width: double.infinity,
                height: 150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          alignment: Alignment.topRight,
                          children: [
                            GestureDetector(
                              onDoubleTap: () {
                                showDialog<void>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return const AlertDialog(
                                      contentPadding: EdgeInsets.zero,
                                      content: ImageLoad(
                                        urlImage: '',
                                        width: 300,
                                        height: 280,
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                width: width,
                                height: heigth,
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 7,
                                  vertical: 10,
                                ),
                                //TODO: Agregar url de logros de los niños cuando el endpoint este listo
                                child: const ImageLoad(urlImage: ''),
                              ),
                            ),
                            IconButton(
                              style: const ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll($colorError),
                                iconColor:
                                    MaterialStatePropertyAll($colorTextWhite),
                              ),
                              onPressed: () {},
                              icon: const Icon(Icons.delete),
                            )
                          ],
                        ),
                        //TODO: Cambiar cuando este listo el endpoint
                        const Text('Manzana')
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 15),
              const InputForm(
                //TODO: Cambiar cuando este listo el endpoint
                value: 'Yo quiero una manzana',
                enable: false,
                //TODO: Crear variable de internacionalizacion,
                label: 'Oracion',
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Visibility(
            visible: true,
            child: ButtonTextIcon(
              title: S.current.Guardar,
              icon: const Icon(Icons.save),
              buttonColor: $colorSuccess,
              onClic: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          const SizedBox(width: 10),
          Visibility(
            visible: true,
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
                    text: const TextSpan(
                      //TODO: Crear variable de internacionalizacion,
                      text:
                          'Esta seguro de salir de la creacion de la actividad',
                      style: TextStyle(fontSize: 16, color: $colorTextBlack),
                    ),
                  ),
                  buttonColorConfirm: $colorSuccess,
                  onClic: () {
                    Navigator.of(context).pop();
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
