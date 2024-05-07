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
      appBar: AppBar(title: Text(S.current.Actividad)),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: FormActivity(isEdit: isEdit, isVisibleSeleccion: false),
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
                  description: S.current
                      .Se_actualizo_correctamente_la_informacion_de_la_actividad,
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
                    text: TextSpan(
                      text: S.current
                          .Esta_seguro_de_salir_de_la_edicion_de_la_actividad,
                      style:
                          const TextStyle(fontSize: 16, color: $colorTextBlack),
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
