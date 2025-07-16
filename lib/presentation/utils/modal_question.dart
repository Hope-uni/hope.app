import 'package:flutter/material.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/presentation/utils/utils.dart';
import 'package:hope_app/presentation/widgets/widgets.dart';

Future<void> modalDialogConfirmation({
  required BuildContext context,
  required RichText question,
  required String titleButtonConfirm,
  required VoidCallback onClic,
  Icon? iconButtonConfirm,
  Color? buttonColorConfirm,
}) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            color: $colorBlueGeneral,
          ),
          padding: const EdgeInsets.only(left: 22, top: 20, bottom: 20),
          alignment: Alignment.centerLeft,
          child: Text(
            S.current.Aviso,
            style: const TextStyle(
              color: $colorTextWhite,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        titlePadding: EdgeInsets.zero,
        insetPadding: EdgeInsets.zero,
        content: SizedBox(width: 200, child: question),
        actions: <Widget>[
          Row(
            children: [
              Expanded(
                child: ButtonTextIcon(
                  title: S.current.Cancelar,
                  icon: const Icon(
                    Icons.cancel,
                  ),
                  buttonColor: $colorError,
                  onClic: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              const SizedBox(width: 5),
              Expanded(
                child: ButtonTextIcon(
                  title: titleButtonConfirm,
                  icon: iconButtonConfirm ?? const Icon(Icons.check),
                  buttonColor: buttonColorConfirm ?? $colorBlueGeneral,
                  onClic: onClic,
                ),
              )
            ],
          )
        ],
      );
    },
  );
}
