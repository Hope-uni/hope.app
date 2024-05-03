import 'package:flutter/material.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/presentation/utils/utils.dart';
import 'package:hope_app/presentation/widgets/widgets.dart';
import 'package:toastification/toastification.dart';

class AddActivityPage extends StatefulWidget {
  const AddActivityPage({super.key});

  @override
  State<AddActivityPage> createState() => _AddActivityPageState();
}

class _AddActivityPageState extends State<AddActivityPage> {
  int currentStep = 1;
  double totalSteps = 2;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      //TODO: Agregar Intl para la configuracion de idiomas
      appBar: AppBar(title: const Text('Asignar actividad')),
      body: SizedBox(
        height: size.height,
        child: Column(
          children: [
            StepperCustom(
              //TODO: Agregar Intl para la configuracion de idiomas
              labelSteps: const [
                'Seleccion de niños para actividad',
                'Confirmacion',
              ],
              totalSteps: totalSteps,
              width: size.width,
              curStep: currentStep,
              stepCompleteColor: $colorPrimary,
              currentStepColor: $colorPrimary50,
              inactiveColor: $colorButtonDisable,
              lineWidth: 3.5,
            ),
            const SizedBox(height: 25),
            Visibility(
              visible: currentStep == 1 ? true : false,
              child: InputForm(
                value: '',
                enable: true,
                label: S.current.Busqueda_por_nombre,
                marginBottom: 0,
                isSearch: true,
                //TODO: Implementar condicional con provider cuando este listo el endpoint
                suffixIcon: true
                    ? const Icon(
                        Icons.search,
                      )
                    : IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.clear),
                      ),
              ),
            ),
            currentStep < totalSteps
                ? Expanded(
                    child: ListView.builder(
                      //TODO: Cambiar cuando este listo el endpoint
                      itemCount: 15,
                      itemBuilder: (context, index) {
                        //TODO: Cambiar el 14 cuando este listo el endpoint
                        if (index < 14) {
                          return ListTileCustom(
                            //TODO: Cambiar cuando este listo el endpoint
                            title: 'Maria Alejandra Ramos Tellez',
                            //TODO: Cambiar cuando este listo el endpoint
                            subTitle: 'Fase 4 | 5 años',
                            //TODO: Cambiar cuando este listo el endpoint
                            image: '',
                            colorItemSelect: [1, 12, 3].contains(
                                    index) //TODO: Cambiar cuando este listo el endpoint, con un provider guardar todos los registro de niños que tengan la actividad y luego ver si los contiene
                                ? $colorPrimary50
                                : null,
                            iconButton: CheckBoxCustom(
                              valueInitial: false,
                              onChange: (bool? value) {
                                //Implementar condicional si existe, quitarlo de la lista del provider donde salen los seleccionados
                                //Si no existe agregarlo dependiendo claro del valor del checkbox
                              },
                            ),
                          );
                        } else {
                          return const SizedBox(height: 75);
                        }
                      },
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                      //TODO: Cambiar  cuando este listo el endpoint
                      itemCount: 15,
                      itemBuilder: (context, index) {
                        //TODO: Cambiar el 14 cuando este listo el endpoint
                        if (index < 14) {
                          return ListTileCustom(
                            //TODO: Cambiar cuando este listo el endpoint
                            subTitle: 'Fase 4 | 7 años',
                            //TODO: Cambiar cuando este listo el endpoint
                            image: '',
                            //TODO: Cambiar cuando este listo el endpoint
                            title:
                                'Alexandra de concepcion gutierrez largaespada',
                            iconButton: IconButton(
                              //TODO: Cambiar cuando este listo el endpoint. implementar metodo
                              onPressed: () {},
                              icon: const Icon(
                                Icons.delete,
                                color: $colorError,
                              ),
                            ),
                          );
                        } else {
                          return const SizedBox(height: 75);
                        }
                      },
                    ),
                  ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Visibility(
            visible: currentStep > 1,
            child: TextButton(
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll($colorError),
              ),
              child: const Text(
                //TODO: Agregar Intl para la configuracion de idiomas
                'Atras',
                style: TextStyle(color: $colorTextWhite),
              ),
              onPressed: () {
                if (currentStep <= totalSteps && currentStep > 1) {
                  _goTo(currentStep - 1);
                }
              },
            ),
          ),
          const SizedBox(width: 10),
          Visibility(
            visible: currentStep != totalSteps,
            child: TextButton(
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll($colorBlueGeneral),
              ),
              child: const Text(
                //TODO: Agregar Intl para la configuracion de idiomas
                'Siguiente',
                style: TextStyle(color: $colorTextWhite),
              ),
              onPressed: () {
                if (currentStep < totalSteps) {
                  _goTo(currentStep + 1);
                }
              },
            ),
          ),
          Visibility(
            visible: currentStep == totalSteps,
            child: TextButton(
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll($colorSuccess),
              ),
              child: Text(
                S.current.Guardar,
                style: const TextStyle(color: $colorTextWhite),
              ),
              onPressed: () {
                toastAlert(
                  iconAlert: const Icon(Icons.update),
                  context: context,
                  //TODO: Agregar Intl para la configuracion de idiomas
                  title: 'Asignación exitosa',
                  description:
                      //TODO: Agregar Intl para la configuracion de idiomas
                      'Se asigno correctamente la actividad a los niños seleccionados',
                  typeAlert: ToastificationType.info,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _goTo(int step) {
    setState(() => currentStep = step);
  }
}
