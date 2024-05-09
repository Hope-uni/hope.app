import 'package:flutter/material.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/presentation/pages/activities/form_activity.dart';
import 'package:hope_app/presentation/utils/utils.dart';
import 'package:hope_app/presentation/widgets/widgets.dart';
import 'package:toastification/toastification.dart';

class NewActivityPage extends StatelessWidget {
  const NewActivityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.current.Crear_actividad)),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: const FormActivity(isEdit: true, isVisibleSeleccion: true),
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
                toastAlert(
                  context: context,
                  title: S.current.Guardado_con_exito,
                  description: S.current.La_actividad_se_guardo_correctamente,
                  typeAlert: ToastificationType.success,
                );
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
                    text: TextSpan(
                      text: S.current
                          .Esta_seguro_de_salir_de_la_creacion_de_la_actividad,
                      style:
                          const TextStyle(fontSize: 16, color: $colorTextBlack),
                    ),
                  ),
                  buttonColorConfirm: $colorSuccess,
                  onClic: () {
                    Navigator.of(context).pop();
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
