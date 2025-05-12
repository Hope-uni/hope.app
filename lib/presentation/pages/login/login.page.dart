import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/presentation/pages/pages.dart';
import 'package:hope_app/presentation/providers/providers.dart';
import 'package:hope_app/presentation/utils/utils.dart';
import 'package:hope_app/presentation/widgets/widgets.dart';
import 'package:toastification/toastification.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends ConsumerState<LoginPage> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
  }

  @override
  Widget build(BuildContext context) {
    final stateAuth = ref.watch(authProvider);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final width = MediaQuery.of(context).size.width;
      ref
          .read(authProvider.notifier)
          .updateIsTablet(isTablet: width >= 600 ? true : false);
    });

    return GestureDetector(
      onTap: () {
        setState(() {
          FocusManager.instance.primaryFocus?.unfocus();
        });
      },
      child: Scaffold(
        body: Stack(
          children: [
            const SingleChildScrollView(
                child: AuthBackground(isLogin: true, formChild: LoginForsm())),
            if (stateAuth.isloading == true)
              const Opacity(
                opacity: 0.5,
                child: ModalBarrier(dismissible: false, color: $colorTextBlack),
              ),
            if (stateAuth.isloading == true)
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

class LoginForsm extends StatelessWidget {
  const LoginForsm({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        _titleApp(size.height),
        //TitleLogin
        Container(
          margin: const EdgeInsets.only(top: 15, bottom: 5),
          child: Text(
            S.current.Iniciar_sesion,
            style: const TextStyle(fontSize: 22),
          ),
        ),
        const SizedBox(height: 15),
        _InputUserName(),
        _InputPassword(),
        //Forget Password
        Container(
          alignment: Alignment.centerRight,
          margin: const EdgeInsets.only(right: 15, left: 10),
          child: GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
              Navigator.of(context)
                  .push(buildPageRoute(const ResetPasswordPage()));
            },
            child: Text(S.current.Olvido_su_contrasena,
                textAlign: TextAlign.end,
                style: const TextStyle(
                  color: $colorBlueGeneral,
                )),
          ),
        ),
        const SizedBox(height: 10),
        _ButtonLogin()
      ],
    );
  }
}

Text _titleApp(double height) {
  return Text(
    S.current.Hope,
    style: const TextStyle(
      color: $colorBlueGeneral,
      fontSize: 50,
      fontWeight: FontWeight.bold,
      fontFamily: $fontFamilyAnton,
    ),
  );
}

class _InputUserName extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginForm = ref.watch(loginFormProvider);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 20),
          child: const Icon(
            Icons.person,
            color: $colorBlueGeneral,
          ),
        ),
        Expanded(
          child: InputForm(
            errorText: loginForm.errorUserName,
            marginBottom: 0,
            enable: true,
            value: loginForm.userName,
            hint: S.current.Usuario,
            inputFormatters: [
              FilteringTextInputFormatter.deny(
                RegExp(r'\s'),
              ), // Denegar espacios
            ],
            onChanged: ref.read(loginFormProvider.notifier).onUserNameChange,
          ),
        ),
      ],
    );
  }
}

class _InputPassword extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginForm = ref.watch(loginFormProvider);
    final isVisiblePassword = ref.watch(isVisiblePasswordProvider);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 20),
          child: const Icon(
            Icons.key,
            color: $colorBlueGeneral,
          ),
        ),
        Expanded(
          child: InputForm(
            errorText: loginForm.errorPassword,
            marginBottom: 0,
            enable: true,
            value: loginForm.password,
            obscureText: isVisiblePassword,
            hint: S.current.Contrasena,
            inputFormatters: [
              FilteringTextInputFormatter.deny(
                  RegExp(r'\s')), // Denegar espacios
            ],
            onChanged: ref.read(loginFormProvider.notifier).onPasswordChange,
            suffixIcon: IconButton(
              icon: isVisiblePassword
                  ? const Icon(Icons.visibility_off)
                  : const Icon(Icons.visibility),
              onPressed: () {
                ref
                    .read(isVisiblePasswordProvider.notifier)
                    .update((state) => !state);
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _ButtonLogin extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginProvider = ref.watch(loginFormProvider);

    ref.listen(authProvider, (previous, next) {
      if (next.errorMessage != null) {
        toastAlert(
          context: context,
          title: S.current.Error,
          description: next.errorMessage!,
          typeAlert: ToastificationType.error,
        );
        ref.read(authProvider.notifier).updateResponse();
      }
    });

    return Container(
      margin: const EdgeInsets.only(right: 15, left: 10),
      width: double.infinity,
      child: FilledButton(
        onPressed: loginProvider.isFormPosted
            ? null
            : () {
                FocusManager.instance.primaryFocus?.unfocus();
                if (!ref.read(loginFormProvider.notifier).validInputs()) return;
                ref.read(loginFormProvider.notifier).onFormSubmit();
              },
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith(
            (states) => loginProvider.isFormPosted
                ? $colorButtonDisable
                : $colorBlueGeneral,
          ),
        ),
        child: Text(
          loginProvider.isFormPosted
              ? S.current.Cargando
              : S.current.Iniciar_sesion,
        ),
      ),
    );
  }
}
