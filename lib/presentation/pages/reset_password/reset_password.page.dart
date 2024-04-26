import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/presentation/providers/password.provider.dart';
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
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
      child: Column(
        children: [
          _titleApp(size.height),
          //TitleLogin
          Container(
            margin: const EdgeInsets.only(top: 25, bottom: 25),
            child: Text(
              S.current.Restablecer_contrasena,
            ),
          ),
          _InputUserEmail(),
          //Forget Password
          SizedBox(
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
                        padding: MaterialStatePropertyAll(EdgeInsets.zero)),
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
          _ButtonSendEmail()
        ],
      ),
    );
  }
}

Container _titleApp(double height) {
  return Container(
    margin: EdgeInsets.only(top: height * 0.1),
    child: Text(
      S.current.Hope_App,
      style: const TextStyle(
          color: $colorBlueGeneral,
          fontSize: 50,
          fontWeight: FontWeight.bold,
          fontFamily: $fontFamilyAnton),
    ),
  );
}

class _InputUserEmail extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resetPasswordProvider = ref.watch(resetPasswordFormProvider);
    return Row(
      children: [
        const Icon(
          Icons.alternate_email,
          color: $colorBlueGeneral,
        ),
        InputForm(
          value: resetPasswordProvider.emailOrUser,
          enable: true,
          hint: S.current.Correo_o_nombre_de_usuario,
          inputFormatters: [
            FilteringTextInputFormatter.deny(RegExp(r'\s')), // Denegar espacios
          ],
          onChanged: ref.read(resetPasswordFormProvider.notifier).onEmailOrUser,
          errorText: resetPasswordProvider.errorEmailOrUser,
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
      if (next.message == null) return;
      //TODO: Agregar validaciones y textos cuando el endpoint este listo dependiendo del statusCode de la respuesta
      toastAlert(
        context: context,
        title: 'Correo enviado',
        description: next.message!,
        typeAlert: ToastificationType.success,
      );
    });

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
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
