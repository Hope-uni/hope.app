import 'package:flutter/material.dart';

import '../../utils/constants.dart';
import '../../widgets/auth_background.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: AuthBackground(
          formChild: LoginForm(),
        ),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 75),
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
          const SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: null,
              style: ButtonStyle(
                  alignment: Alignment.centerRight,
                  padding: MaterialStatePropertyAll(EdgeInsets.zero)),
              child: Text($forgetPassword),
            ),
          ),
          _buttonLogin()
        ],
      ),
    );
  }
}

_titleApp(double height) {
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

_inputUserName() {
  Row(
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

_inputPassword() {
  Row(
    children: [
      Container(
        padding: const EdgeInsets.only(right: 15, top: 15),
        child: const Icon(
          Icons.key,
          color: Color.fromARGB(255, 21, 83, 156),
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

_buttonLogin() {
  Container(
    width: double.infinity,
    margin: const EdgeInsets.only(bottom: 20),
    child: const FilledButton(
      onPressed: null,
      style: ButtonStyle(
          foregroundColor: MaterialStatePropertyAll(Colors.white),
          backgroundColor: MaterialStatePropertyAll($colorBlueGeneral)),
      child: Text($titleButtonLogin),
    ),
  );
}
