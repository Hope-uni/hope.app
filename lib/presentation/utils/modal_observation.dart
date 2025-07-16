import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hope_app/domain/domain.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/presentation/providers/providers.dart';
import 'package:hope_app/presentation/utils/utils.dart';
import 'package:hope_app/presentation/widgets/widgets.dart';
import 'package:toastification/toastification.dart';

modalObservation({
  required BuildContext context,
  required CatalogObject dataChild,
  required bool isPageChild,
}) {
  return showDialog<void>(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      Observation? newObservation;
      return Consumer(
        builder: (context, ref, child) {
          final notifierObservation = ref.read(observationProvider.notifier);
          final stateObservation = ref.watch(observationProvider);
          final notifierChild = ref.read(childProvider.notifier);

          ref.listen(observationProvider, (previous, next) {
            if (next.isLoading == false && next.isCreate == true) {
              toastAlert(
                context: context,
                title: S.current.Guardado_con_exito,
                description: S.current.Observacion_creada,
                typeAlert: ToastificationType.success,
              );
              ref.read(observationProvider.notifier).updateResponse();
            }

            if (next.errorMessageApi != null) {
              toastAlert(
                context: context,
                title: S.current.Error,
                description: next.errorMessageApi!,
                typeAlert: ToastificationType.error,
              );
              ref.read(observationProvider.notifier).updateResponse();
            }
          });

          return Stack(
            children: [
              AlertDialog(
                title: Container(
                  width: 300,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    color: $colorBlueGeneral,
                  ),
                  padding: const EdgeInsets.only(
                    left: 22,
                    top: 20,
                    right: 22,
                    bottom: 20,
                  ),
                  alignment: Alignment.centerLeft,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '${S.current.Agregar_observacion}\n',
                          style: const TextStyle(
                            fontSize: 20,
                            color: $colorTextWhite,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: dataChild.name,
                          style: const TextStyle(height: 2),
                        ),
                      ],
                    ),
                  ),
                ),
                titlePadding: EdgeInsets.zero,
                insetPadding: EdgeInsets.zero,
                contentPadding: const EdgeInsets.only(
                  bottom: 5,
                  left: 22,
                  right: 22,
                  top: 15,
                ),
                content: SingleChildScrollView(
                  child: Container(
                    width: 300,
                    margin: const EdgeInsets.only(top: 7, bottom: 4),
                    child: InputForm(
                      isMargin: false,
                      value: stateObservation.description ?? '',
                      enable: newObservation == null ? true : false,
                      maxLength: 255,
                      linesDynamic: true,
                      label: S.current.Observacion,
                      onChanged: (value) {
                        notifierObservation.updateDescription(value: value);
                      },
                      errorText: stateObservation.validationError,
                    ),
                  ),
                ),
                actions: <Widget>[
                  Row(
                    children: [
                      Expanded(
                        child: ButtonTextIcon(
                          title: newObservation == null
                              ? S.current.Cancelar
                              : S.current.Cerrar,
                          icon: const Icon(Icons.cancel),
                          buttonColor: $colorError,
                          onClic: () async {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                      if (newObservation == null) const SizedBox(width: 5),
                      if (newObservation == null)
                        Expanded(
                          child: ButtonTextIcon(
                            title: S.current.Guardar,
                            icon: const Icon(Icons.save),
                            buttonColor: $colorSuccess,
                            onClic: () async {
                              if (notifierObservation.checkDescription()) {
                                FocusManager.instance.primaryFocus?.unfocus();

                                newObservation =
                                    await notifierObservation.addObservation(
                                  idChild: dataChild.id,
                                );

                                if (newObservation != null && isPageChild) {
                                  notifierChild.updateObservations(
                                    newObservation: newObservation!,
                                  );
                                }
                              }
                            },
                          ),
                        ),
                    ],
                  ),
                ],
              ),
              if (stateObservation.isLoading == true)
                const Opacity(
                  opacity: 0.5,
                  child:
                      ModalBarrier(dismissible: false, color: $colorTextBlack),
                ),
              if (stateObservation.isLoading == true)
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CircularProgressIndicator(),
                      const SizedBox(height: 25),
                      Text(
                        S.current.Cargando,
                        style: const TextStyle(
                          color: $colorTextWhite,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          );
        },
      );
    },
  );
}
