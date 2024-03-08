import 'package:flutter/material.dart';
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
            child: const Text(
              $titleResetPassword,
            ),
          ),
          _inputUserEmail(),
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
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text($titleEnterCredentials),
                        Icon(Icons.arrow_forward),
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
    child: const Text(
      $titleNombreApp,
      style: TextStyle(
          color: $colorBlueGeneral,
          fontSize: 50,
          fontWeight: FontWeight.bold,
          fontFamily: $fontFamilyAnton),
    ),
  );
}

Row _inputUserEmail() {
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
          decoration: const InputDecoration(
            hintText: $titleUserEmail,
          ),
        ),
      ),
    ],
  );
}

class _ButtonSendEmail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      child: FilledButton(
        onPressed: () {
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
              backgroundColor: $colorAlert,
              content: Text('El usuario no existe'),
              duration: Duration(seconds: 4),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            // print('Inicio de sesión fallido');
          }
        },
        style: const ButtonStyle(
            backgroundColor: MaterialStatePropertyAll($colorBlueGeneral)),
        child: const Text($titleSendEmail),
      ),
    );
  }
}
