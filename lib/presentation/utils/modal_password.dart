import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/presentation/providers/providers.dart';
import 'package:hope_app/presentation/utils/utils.dart';
import 'package:hope_app/presentation/widgets/widgets.dart';
import 'package:toastification/toastification.dart';

//TODO: Mejorar logica cuando se actualize la contraseña del paciente
modalPassword({
  required BuildContext context,
  required bool isVerifided,
  String? namePerson,
}) {
  return showDialog<void>(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return Consumer(
        builder: (context, ref, child) {
          final notifierChangePassword =
              ref.watch(changePasswordProvider.notifier);

          final stateChangePassword = ref.watch(changePasswordProvider);

          ref.listen(changePasswordProvider, (previous, next) {
            if (next.messageSuccess != null &&
                next.messageSuccess!.isNotEmpty) {
              if (context.mounted) {
                toastAlert(
                  iconAlert: const Icon(Icons.update),
                  context: context,
                  title: S.current.Actualizado_con_exito,
                  description: next.messageSuccess!,
                  typeAlert: ToastificationType.info,
                );
                notifierChangePassword.resetState();
                if (isVerifided != true) notifierChangePassword.updateMe();

                Navigator.of(context).pop();
              }
            }
            if (next.messageError != null && next.messageError!.isNotEmpty) {
              toastAlert(
                context: context,
                title: S.current.Error,
                description: next.messageError!,
                typeAlert: ToastificationType.error,
              );
              notifierChangePassword.updateErrorMessage();
            }
          });

          return Stack(
            children: [
              AlertDialog(
                title: Text(
                  namePerson == null
                      ? S.current.Cambiar_contrasena
                      : '${S.current.Cambio_de_contrasena_de}\n$namePerson',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
                icon: const Icon(Icons.edit),
                contentPadding: const EdgeInsets.only(
                    bottom: 0, left: 10, right: 10, top: 15),
                content: SingleChildScrollView(
                  child: Column(
                    children: [
                      InputForm(
                        value: stateChangePassword.password ?? '',
                        enable: true,
                        maxLength: 30,
                        obscureText:
                            stateChangePassword.viewPasswords[$password]!,
                        label: S.current.Contrasena_actual,
                        suffixIcon: IconButton(
                          icon: stateChangePassword.viewPasswords[$password]!
                              ? const Icon(Icons.visibility_off)
                              : const Icon(Icons.visibility),
                          onPressed: () {
                            notifierChangePassword.viewPassword($password,
                                !stateChangePassword.viewPasswords[$password]!);
                          },
                        ),
                        onChanged: (value) {
                          notifierChangePassword.updateErrorField(
                              $password, value);
                        },
                        errorText:
                            stateChangePassword.validationErrors[$password],
                      ),
                      InputForm(
                        value: stateChangePassword.newPassword ?? '',
                        enable: true,
                        maxLength: 30,
                        obscureText:
                            stateChangePassword.viewPasswords[$newPassword]!,
                        label: S.current.Nueva_contrasena,
                        suffixIcon: IconButton(
                          icon: stateChangePassword.viewPasswords[$newPassword]!
                              ? const Icon(Icons.visibility_off)
                              : const Icon(Icons.visibility),
                          onPressed: () {
                            notifierChangePassword.viewPassword(
                              $newPassword,
                              !stateChangePassword.viewPasswords[$newPassword]!,
                            );
                          },
                        ),
                        onChanged: (value) {
                          notifierChangePassword.updateErrorField(
                              $newPassword, value);
                        },
                        errorText:
                            stateChangePassword.validationErrors[$newPassword],
                      ),
                      InputForm(
                        value: stateChangePassword.confirmNewPassword ?? '',
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
                              $confirmNewPassword,
                              !stateChangePassword
                                  .viewPasswords[$confirmNewPassword]!,
                            );
                          },
                        ),
                        onChanged: (value) {
                          notifierChangePassword.updateErrorField(
                              $confirmNewPassword, value);
                        },
                        errorText: stateChangePassword
                            .validationErrors[$confirmNewPassword],
                      )
                    ],
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
                      if (notifierChangePassword.checkFields()) {
                        notifierChangePassword.changePassword();
                      }
                    },
                  ),
                  ButtonTextIcon(
                    title: isVerifided
                        ? S.current.Cancelar
                        : S.current.Cerrar_sesion,
                    icon: const Icon(
                      Icons.cancel,
                    ),
                    buttonColor: $colorError,
                    onClic: () {
                      if (isVerifided != true) {
                        ref.read(authProvider.notifier).logout();
                      } else {
                        Navigator.of(context).pop();
                      }
                    },
                  )
                ],
              ),
              if (stateChangePassword.isLoading == true)
                const Opacity(
                  opacity: 0.5,
                  child:
                      ModalBarrier(dismissible: false, color: $colorTextBlack),
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
          );
        },
      );
    },
  );
}
