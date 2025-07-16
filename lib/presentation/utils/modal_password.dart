import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hope_app/domain/domain.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/presentation/providers/providers.dart';
import 'package:hope_app/presentation/utils/utils.dart';
import 'package:hope_app/presentation/widgets/widgets.dart';
import 'package:toastification/toastification.dart';

modalPassword({
  required BuildContext context,
  required bool isVerifided,
  CatalogObject? patient,
}) {
  return showDialog<void>(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Consumer(
            builder: (context, ref, child) {
              final notifierChangePassword =
                  ref.read(changePasswordProvider.notifier);

              final stateChangePassword = ref.watch(changePasswordProvider);

              ref.listen(changePasswordProvider, (previous, next) async {
                if (next.messageSuccess != null &&
                    next.messageSuccess!.isNotEmpty) {
                  toastAlert(
                    iconAlert: const Icon(Icons.check),
                    context: context,
                    title: S.current.Actualizado_con_exito,
                    description: next.messageSuccess!,
                    typeAlert: ToastificationType.info,
                  );

                  notifierChangePassword.resetState();

                  if (isVerifided != true) {
                    await notifierChangePassword.updateMe();
                  }

                  if (context.mounted) Navigator.of(context).pop();
                }

                if (next.messageError != null &&
                    next.messageError!.isNotEmpty) {
                  if (context.mounted) {
                    toastAlert(
                      context: context,
                      title: S.current.Error,
                      description: next.messageError!,
                      typeAlert: ToastificationType.error,
                    );
                  }

                  notifierChangePassword.updateResponse();
                }
              });

              return PopScope(
                canPop: isVerifided,
                child: Stack(
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
                        padding: EdgeInsets.only(
                            left: 22,
                            top: 20,
                            right: 22,
                            bottom: patient != null ? 20 : 0),
                        alignment: Alignment.centerLeft,
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '${S.current.Cambiar_contrasena}\n',
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: $colorTextWhite,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              if (patient != null)
                                TextSpan(
                                  text: patient.name,
                                  style: const TextStyle(height: 2),
                                ),
                            ],
                          ),
                        ),
                      ),
                      titlePadding: EdgeInsets.zero,
                      insetPadding: EdgeInsets.zero,
                      contentPadding: const EdgeInsets.only(
                          bottom: 0, left: 10, right: 10, top: 15),
                      content: SingleChildScrollView(
                        child: SizedBox(
                          width: 300,
                          child: Column(
                            children: [
                              InputForm(
                                value: stateChangePassword.passwords!.password,
                                enable: true,
                                maxLength: 30,
                                obscureText: stateChangePassword
                                    .viewPasswords[$password]!,
                                label: S.current.Contrasena_actual,
                                suffixIcon: IconButton(
                                  icon: stateChangePassword
                                          .viewPasswords[$password]!
                                      ? const Icon(Icons.visibility_off)
                                      : const Icon(Icons.visibility),
                                  onPressed: () {
                                    notifierChangePassword.viewPassword(
                                      fieldName: $password,
                                      newValue: !stateChangePassword
                                          .viewPasswords[$password]!,
                                    );
                                  },
                                ),
                                onChanged: (value) {
                                  notifierChangePassword.updateErrorField(
                                    fieldName: $password,
                                    newValue: value,
                                  );
                                },
                                errorText: stateChangePassword
                                    .validationErrors[$password],
                              ),
                              InputForm(
                                value:
                                    stateChangePassword.passwords!.newPassword,
                                enable: true,
                                maxLength: 30,
                                obscureText: stateChangePassword
                                    .viewPasswords[$newPassword]!,
                                label: S.current.Nueva_contrasena,
                                suffixIcon: IconButton(
                                  icon: stateChangePassword
                                          .viewPasswords[$newPassword]!
                                      ? const Icon(Icons.visibility_off)
                                      : const Icon(Icons.visibility),
                                  onPressed: () {
                                    notifierChangePassword.viewPassword(
                                      fieldName: $newPassword,
                                      newValue: !stateChangePassword
                                          .viewPasswords[$newPassword]!,
                                    );
                                  },
                                ),
                                onChanged: (value) {
                                  notifierChangePassword.updateErrorField(
                                    fieldName: $newPassword,
                                    newValue: value,
                                  );
                                },
                                errorText: stateChangePassword
                                    .validationErrors[$newPassword],
                              ),
                              InputForm(
                                value: stateChangePassword
                                    .passwords!.confirmNewPassword,
                                enable: true,
                                maxLength: 30,
                                obscureText: stateChangePassword
                                    .viewPasswords[$confirmNewPassword]!,
                                label: S.current.Confirmar_nueva_contrasena,
                                suffixIcon: IconButton(
                                  icon: stateChangePassword
                                          .viewPasswords[$confirmNewPassword]!
                                      ? const Icon(Icons.visibility_off)
                                      : const Icon(Icons.visibility),
                                  onPressed: () {
                                    notifierChangePassword.viewPassword(
                                      fieldName: $confirmNewPassword,
                                      newValue: !stateChangePassword
                                          .viewPasswords[$confirmNewPassword]!,
                                    );
                                  },
                                ),
                                onChanged: (value) {
                                  notifierChangePassword.updateErrorField(
                                    fieldName: $confirmNewPassword,
                                    newValue: value,
                                  );
                                },
                                errorText: stateChangePassword
                                    .validationErrors[$confirmNewPassword],
                              )
                            ],
                          ),
                        ),
                      ),
                      actions: <Widget>[
                        Row(
                          children: [
                            Expanded(
                              child: ButtonTextIcon(
                                title: isVerifided
                                    ? S.current.Cancelar
                                    : S.current.Cerrar_sesion,
                                icon: const Icon(Icons.cancel),
                                buttonColor: $colorError,
                                onClic: () async {
                                  if (isVerifided != true) {
                                    await ref
                                        .read(authProvider.notifier)
                                        .logout();
                                  } else {
                                    Navigator.of(context).pop();
                                    notifierChangePassword.resetState();
                                  }
                                },
                              ),
                            ),
                            const SizedBox(width: 5),
                            Expanded(
                              child: ButtonTextIcon(
                                title: S.current.Actualizar,
                                icon: const Icon(Icons.update),
                                buttonColor: $colorBlueGeneral,
                                onClic: () async {
                                  if (notifierChangePassword.checkFields()) {
                                    setState(
                                      () {
                                        FocusManager.instance.primaryFocus
                                            ?.unfocus();
                                      },
                                    );
                                    if (patient != null) {
                                      await notifierChangePassword
                                          .changePasswordChild(
                                        idChild: patient.id,
                                      );
                                    } else {
                                      await notifierChangePassword
                                          .changePassword();
                                    }
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    if (stateChangePassword.isLoading == true)
                      const Opacity(
                        opacity: 0.5,
                        child: ModalBarrier(
                            dismissible: false, color: $colorTextBlack),
                      ),
                    if (stateChangePassword.isLoading == true)
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
                ),
              );
            },
          );
        },
      );
    },
  );
}
