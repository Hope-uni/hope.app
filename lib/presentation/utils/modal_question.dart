import 'package:flutter/material.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/presentation/utils/utils.dart';
import 'package:hope_app/presentation/widgets/widgets.dart';

Future<void> modalDialogConfirmation(
    {required BuildContext context,
    required String question,
    required String titleButtonConfirm,
    required Icon iconButtonConfirm,
    required VoidCallback onClic,
    Color? buttonColorConfirm}) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(S.current.Aviso),
        content: Text(question),
        actions: <Widget>[
          ButtonTextIcon(
            title: titleButtonConfirm,
            icon: iconButtonConfirm,
            buttonColor: buttonColorConfirm ?? $colorBlueGeneral,
            onClic: onClic,
          ),
          ButtonTextIcon(
            title: S.current.Cancelar,
            icon: const Icon(
              Icons.cancel,
            ),
            buttonColor: $colorError,
            onClic: () {
              Navigator.of(context).pop();
            },
          )
        ],
      );
    },
  );
}
