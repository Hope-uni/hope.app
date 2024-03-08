import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hope_app/presentation/pages/pages.dart';
import 'package:hope_app/presentation/utils/utils.dart';
import 'package:hope_app/presentation/widgets/widgets.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: AuthBackground(
          isLogin: true,
          formChild: LoginForsm(),
        ),
      ),
    );
  }
}

class LoginForsm extends StatelessWidget {
  const LoginForsm({super.key});

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
              $titleLogin,
            ),
          ),
          _inputUserName(),
          _inputPassword(),
          //Forget Password
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () {
                Navigator.of(context)
                    .push(buildPageRoute(const ResetPasswordPage()));
              },
              style: const ButtonStyle(
                  alignment: Alignment.centerRight,
                  padding: MaterialStatePropertyAll(EdgeInsets.zero)),
              child: const Text($forgetPassword),
            ),
          ),
          _ButtonLogin()
        ],
      ),
    );
  }
}

Text _titleApp(double height) {
  return const Text(
    $titleNombreApp,
    style: TextStyle(
        color: $colorBlueGeneral,
        fontSize: 50,
        fontWeight: FontWeight.bold,
        fontFamily: $fontFamilyAnton),
  );
}

Row _inputUserName() {
  return Row(
    children: [
      Container(
        padding: const EdgeInsets.only(right: 15, top: 15),
        child: const Icon(
          Icons.person,
          color: $colorBlueGeneral,
        ),
      ),
      Expanded(
        child: TextFormField(
          decoration: const InputDecoration(
            hintText: $titlePlaceholderUser,
          ),
        ),
      ),
    ],
  );
}

Row _inputPassword() {
  return Row(
    children: [
      Container(
        padding: const EdgeInsets.only(right: 15, top: 15),
        child: const Icon(
          Icons.key,
          color: $colorBlueGeneral,
        ),
      ),
      Expanded(
        child: TextFormField(
          decoration: const InputDecoration(
            hintText: $titlePlaceholderPassword,
          ),
        ),
      ),
    ],
  );
}

class _ButtonLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton(
        onPressed: () {
          // Simula un inicio de sesión exitoso
          // Puedes reemplazar esto con tu lógica de autenticación real
          bool loginSuccessful = true;

          // ignore: dead_code
          if (loginSuccessful) {
            context.replace('/children');
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
        child: const Text($titleButtonLogin),
      ),
    );
  }
}
