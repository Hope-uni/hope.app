import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/presentation/providers/providers.dart';
import 'package:hope_app/presentation/utils/utils.dart';
import 'package:hope_app/presentation/widgets/widgets.dart';
import 'package:toastification/toastification.dart';

class ResetPasswordPage extends ConsumerStatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  ResetPasswordPageState createState() => ResetPasswordPageState();
}

class ResetPasswordPageState extends ConsumerState<ResetPasswordPage> {
  @override
  Widget build(BuildContext context) {
    final isFormPosted = ref.watch(passwordProvider).isFormPosted;
    final DateTime dateNow = DateTime.now();
    return GestureDetector(
      onTap: () {
        setState(() {
          FocusManager.instance.primaryFocus?.unfocus();
        });
      },
      child: Scaffold(
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  const AuthBackground(
                    isLogin: false,
                    formChild: ResetPasswordForm(),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 30,
                    child: Text(
                      S.current.Derechos_reservados(dateNow.year),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            if (isFormPosted)
              const Opacity(
                opacity: 0.5,
                child: ModalBarrier(dismissible: false, color: $colorTextBlack),
              ),
            if (isFormPosted)
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                child: Container(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      Navigator.pop(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          S.current.Iniciar_sesion,
                          textAlign: TextAlign.end,
                          style: const TextStyle(color: $colorBlueGeneral),
                        ),
                        const Icon(
                          Icons.arrow_forward,
                          color: $colorBlueGeneral,
                        ),
                      ],
                    ),
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
    final resetPasswordProvider = ref.watch(passwordProvider);
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
            marginBottom: 0,
            value: resetPasswordProvider.emailOrUser,
            enable: true,
            hint: S.current.Correo_o_nombre_de_usuario,
            inputFormatters: [
              // Denegar espacios
              FilteringTextInputFormatter.deny(RegExp(r'\s')),
            ],
            onChanged: (value) {
              ref
                  .read(passwordProvider.notifier)
                  .onEmailOrUser(emailOrUser: value);
            },
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
    final isFormPosted = ref.watch(passwordProvider).isFormPosted;

    ref.listen(passwordProvider, (previous, next) {
      if (next.message.isNotEmpty) {
        toastAlert(
          context: context,
          title: next.typeMessage == ToastificationType.success
              ? S.current.Solicitud_enviada
              : S.current.Error,
          description: next.message,
          typeAlert: next.typeMessage,
        );

        ref.watch(passwordProvider.notifier).resetStateMessage();
      }
    });

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10, left: 10, right: 15),
      child: FilledButton(
        onPressed: isFormPosted
            ? null
            : () {
                FocusManager.instance.primaryFocus?.unfocus();
                if (!ref.read(passwordProvider.notifier).validInput()) return;
                ref.read(passwordProvider.notifier).sendResetPassword();
              },
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith((states) =>
              isFormPosted ? $colorButtonDisable : $colorBlueGeneral),
        ),
        child:
            Text(isFormPosted ? S.current.Cargando : S.current.Enviar_correo),
      ),
    );
  }
}
