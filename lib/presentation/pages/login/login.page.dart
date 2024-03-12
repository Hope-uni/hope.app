import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/presentation/pages/pages.dart';
import 'package:hope_app/presentation/providers/providers.dart';
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
            child: Text(
              S.current.Iniciar_sesion,
            ),
          ),
          _InputUserName(),
          _InputPassword(),
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
              child: Text(S.current.Olvido_su_contrasena),
            ),
          ),
          _ButtonLogin()
        ],
      ),
    );
  }
}

Text _titleApp(double height) {
  return Text(
    S.current.Hope_App,
    style: const TextStyle(
        color: $colorBlueGeneral,
        fontSize: 50,
        fontWeight: FontWeight.bold,
        fontFamily: $fontFamilyAnton),
  );
}

class _InputUserName extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ignore: unused_local_variable
    final loginForm = ref.watch(loginFormProvider);
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
            inputFormatters: [
              FilteringTextInputFormatter.deny(
                  RegExp(r'\s')), // Denegar espacios
            ],
            onChanged: ref.read(loginFormProvider.notifier).onUserNameChange,
            decoration: InputDecoration(
              hintText: S.current.Usuario,
            ),
          ),
        ),
      ],
    );
  }
}

class _InputPassword extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ignore: unused_local_variable
    final loginForm = ref.watch(loginFormProvider);
    final isVisiblePassword = ref.watch(isVisiblePasswordProvider);

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
            inputFormatters: [
              FilteringTextInputFormatter.deny(
                  RegExp(r'\s')), // Denegar espacios
            ],
            obscureText: isVisiblePassword,
            onChanged: ref.read(loginFormProvider.notifier).onPasswordChange,
            decoration: InputDecoration(
                hintText: S.current.Contrasena,
                suffixIcon: IconButton(
                  icon: isVisiblePassword
                      ? const Icon(Icons.visibility_off)
                      : const Icon(Icons.visibility),
                  onPressed: () {
                    ref
                        .read(isVisiblePasswordProvider.notifier)
                        .update((state) => !state);
                  },
                )),
          ),
        ),
      ],
    );
  }
}

class _ButtonLogin extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isClick = ref.watch(isClicLoginProvider);
    return SizedBox(
      width: double.infinity,
      child: FilledButton(
        onPressed: isClick
            ? null
            : () {
                ref.read(isClicLoginProvider.notifier).state = true;
                if (ref.read(loginFormProvider.notifier).validateInputs()) {
                  final snackBar = SnackBar(
                    backgroundColor: $colorAlert,
                    content: Text(
                      S.current.Los_campos_no_pueden_estar_vacios,
                      style:
                          const TextStyle(color: $colorTextForlightBackgrounds),
                    ),
                    duration: const Duration(seconds: 2),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  ref.read(isClicLoginProvider.notifier).state = false;
                  return;
                }

                bool loginSuccessful = true;
                // ignore: dead_code
                if (loginSuccessful) {
                  context.replace('/children');
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
                }
              },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith(
              (states) => isClick ? $colorButtonDisable : $colorBlueGeneral),
        ),
        child: Text(S.current.Iniciar_sesion),
      ),
    );
  }
}
