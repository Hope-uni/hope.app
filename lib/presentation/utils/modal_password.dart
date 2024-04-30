import 'package:flutter/material.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/presentation/utils/utils.dart';
import 'package:hope_app/presentation/widgets/widgets.dart';

modalPassword({required BuildContext context}) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(
          'Cambio de contraseña de\nAlejandra Maria Ramos Tellez',
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          //TODO: Cambiar cuando este listo el endpoint
        ),
        icon: const Icon(Icons.edit),
        content: SingleChildScrollView(
          child: SizedBox(
            height: 250,
            child: Column(
              children: [
                const InputForm(
                  value: '',
                  enable: true,
                  label: 'Contraseña actual',
                ),
                InputForm(
                  value: '',
                  enable: true,
                  label: 'Nueva contraseña',
                  suffixIcon: IconButton(
                    icon: true
                        ? const Icon(Icons.visibility_off)
                        : const Icon(Icons.visibility),
                    onPressed: () {},
                  ),
                ),
                InputForm(
                  value: '',
                  enable: true,
                  label: 'Confirmar nueva contraseña',
                  suffixIcon: IconButton(
                    icon: false
                        ? const Icon(Icons.visibility_off)
                        : const Icon(Icons.visibility),
                    onPressed: () {},
                  ),
                )
              ],
            ),
          ),
        ),
        actions: <Widget>[
          ButtonTextIcon(
            title: S.current.Actualizar,
            icon: const Icon(
              Icons.update,
            ),
            buttonColor: $colorBlueGeneral,
            onClic: () {
              Navigator.of(context).pop();
            },
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
