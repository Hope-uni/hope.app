import 'package:flutter/material.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/presentation/pages/activities/form_activity.dart';
import 'package:hope_app/presentation/utils/utils.dart';
import 'package:hope_app/presentation/widgets/widgets.dart';
import 'package:toastification/toastification.dart';

class ActivityPage extends StatefulWidget {
  final bool isGoEdit;
  final int idItem;
  const ActivityPage({super.key, required this.isGoEdit, required this.idItem});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  late bool isEdit;

  @override
  void initState() {
    super.initState();
    isEdit = widget.isGoEdit;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //TODO: Crear variable de internacionalizacion,
        title: const Text('Actividad'),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: FormActivity(
          isEdit: isEdit,
          isVisibleSeleccion: false,
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Visibility(
            visible: !isEdit,
            child: ButtonTextIcon(
              buttonColor: $colorBlueGeneral,
              title: S.current.Editar,
              icon: const Icon(Icons.edit),
              onClic: () {
                setState(() {
                  isEdit = !isEdit;
                });
              },
            ),
          ),
          Visibility(
            visible: isEdit,
            child: ButtonTextIcon(
              title: S.current.Actualizar,
              icon: const Icon(Icons.update),
              buttonColor: $colorBlueGeneral,
              onClic: () {
                toastAlert(
                  iconAlert: const Icon(Icons.update),
                  context: context,
                  title: S.current.Actualizado_con_exito,
                  //TODO: Crear variable de internacionalizacion
                  description:
                      'Se actualizo correctamente la informacion de la actividad',
                  typeAlert: ToastificationType.info,
                );
              },
            ),
          ),
          const SizedBox(width: 10),
          Visibility(
            visible: isEdit,
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
                          'Esta seguro de salir de la edicion de la actividad',
                      style: TextStyle(fontSize: 16, color: $colorTextBlack),
                    ),
                  ),
                  buttonColorConfirm: $colorSuccess,
                  onClic: () {
                    setState(() {
                      isEdit = !isEdit;
                    });
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
