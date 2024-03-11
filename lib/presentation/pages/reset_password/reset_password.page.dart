import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/presentation/providers/providers.dart';
import 'package:hope_app/presentation/utils/utils.dart';
import 'package:hope_app/presentation/widgets/widgets.dart';

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

class ResetPasswordForm extends ConsumerWidget {
  const ResetPasswordForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ignore: unused_local_variable
    final inputEmailUser = ref.watch(inputEmailUserProvider);
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
                      ref.read(inputEmailUserProvider.notifier).state = '';
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
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.only(right: 15, top: 15),
          child: const Icon(
            Icons.alternate_email,
            color: $colorBlueGeneral,
          ),
        ),
        Expanded(
          child: TextFormField(
            inputFormatters: [
              FilteringTextInputFormatter.deny(
                  RegExp(r'\s')), // Denegar espacios
            ],
            onChanged: (String value) =>
                ref.read(inputEmailUserProvider.notifier).state = value.trim(),
            decoration: InputDecoration(
              hintText: S.current.Correo_o_nombre_de_usuario,
            ),
          ),
        ),
      ],
    );
  }
}

class _ButtonSendEmail extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isClic = ref.watch(isClicSendEmailResetProvider);
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      child: FilledButton(
        onPressed: isClic
            ? null
            : () {
                ref.read(isClicSendEmailResetProvider.notifier).state = true;
                if (ref.read(inputEmailUserProvider.notifier).state.isEmpty) {
                  final snackBar = SnackBar(
                    backgroundColor: $colorAlert,
                    content: Text(
                      S.current.Debe_ingresar_el_nombre_de_usuario_o_correo,
                      style:
                          const TextStyle(color: $colorTextForlightBackgrounds),
                    ),
                    duration: const Duration(seconds: 2),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  ref.read(isClicSendEmailResetProvider.notifier).state = false;
                  return;
                }
                // Simula un inicio de sesión exitoso
                // Puedes reemplazar esto con tu lógica de autenticación real
                bool loginSuccessful = false;

                // ignore: dead_code
                if (loginSuccessful) {
                  // ignore: avoid_print
                  print('Se envio correo');
                  // ignore: dead_code
                } else {
                  // Manejar caso de inicio de sesión fallido
                  // ignore: avoid_print
                  const snackBar = SnackBar(
                    backgroundColor: $colorError,
                    content: Text('El usuario no existe'),
                    duration: Duration(seconds: 4),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  // print('Inicio de sesión fallido');
                }
              },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith(
              (states) => isClic ? $colorButtonDisable : $colorBlueGeneral),
        ),
        child: Text(S.current.Enviar_correo),
      ),
    );
  }
}
