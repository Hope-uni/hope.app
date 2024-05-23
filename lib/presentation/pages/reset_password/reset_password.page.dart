import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/presentation/providers/providers.dart';
import 'package:hope_app/presentation/utils/utils.dart';
import 'package:hope_app/presentation/widgets/widgets.dart';
import 'package:toastification/toastification.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: AuthBackground(
          isLogin: false,
          formChild: ResetPasswordForm(),
        ),
      ),
    );
  }
}

class ResetPasswordForm extends StatelessWidget {
  const ResetPasswordForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _titleApp(),
        //TitleLogin
        Container(
          margin: const EdgeInsets.only(top: 25, bottom: 25),
          child: Text(
            S.current.Restablecer_contrasena,
            style: const TextStyle(fontSize: 22),
          ),
        ),
        const SizedBox(height: 20),
        _InputUserEmail(),
        _ButtonSendEmail(),
        Container(
          margin: const EdgeInsets.only(bottom: 10, left: 10, right: 15),
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: const ButtonStyle(
                      padding:
                          MaterialStatePropertyAll(EdgeInsets.only(right: 5))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(S.current.Iniciar_sesion),
                      const Icon(Icons.arrow_forward),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Text _titleApp() {
  return Text(
    S.current.Hope,
    style: const TextStyle(
        color: $colorBlueGeneral,
        fontSize: 50,
        fontWeight: FontWeight.bold,
        fontFamily: $fontFamilyAnton),
  );
}

class _InputUserEmail extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resetPasswordProvider = ref.watch(resetPasswordFormProvider);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 20),
          child: const Icon(
            Icons.alternate_email,
            color: $colorBlueGeneral,
          ),
        ),
        Expanded(
          child: InputForm(
            value: resetPasswordProvider.emailOrUser,
            enable: true,
            hint: S.current.Correo_o_nombre_de_usuario,
            inputFormatters: [
              FilteringTextInputFormatter.deny(
                  RegExp(r'\s')), // Denegar espacios
            ],
            onChanged:
                ref.read(resetPasswordFormProvider.notifier).onEmailOrUser,
            errorText: resetPasswordProvider.errorEmailOrUser,
          ),
        ),
      ],
    );
  }
}

class _ButtonSendEmail extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFormPosted = ref.watch(resetPasswordFormProvider).isFormPosted;

    ref.listen(passwordProvider, (previous, next) {
      toastAlert(
        context: context,
        title: next.statusCode == 200
            ? S.current.Peticion_enviada
            : S.current.Error,
        description: next.message,
        typeAlert: next.statusCode == 200
            ? ToastificationType.success
            : ToastificationType.error,
      );
    });

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10, left: 10, right: 15),
      child: FilledButton(
        onPressed: isFormPosted
            ? null
            : () {
                if (!ref
                    .read(resetPasswordFormProvider.notifier)
                    .validInput()) {
                  return;
                }
                ref
                    .read(resetPasswordFormProvider.notifier)
                    .sendResetPassword();
              },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) =>
              isFormPosted ? $colorButtonDisable : $colorBlueGeneral),
        ),
        child: Text(S.current.Enviar_correo),
      ),
    );
  }
}
