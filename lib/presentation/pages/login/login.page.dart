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
  final FocusNode _passwordFocusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: $colorTransparent),
    );
    _passwordFocusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    if (_passwordFocusNode.hasFocus) {
      // Esperamos un frame para que el teclado se muestre antes de hacer scroll
      Future.delayed(const Duration(milliseconds: 500), () {
        _scrollController.animateTo(
          _scrollController.offset + 100,
          duration: const Duration(milliseconds: 100),
          curve: Curves.bounceIn,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final stateAuth = ref.watch(authProvider);
    final DateTime dateNow = DateTime.now();

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
            SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  AuthBackground(
                      isLogin: true,
                      formChild: LoginForsm(
                        passwordFocusNode: _passwordFocusNode,
                      )),
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
  final FocusNode passwordFocusNode;

  const LoginForsm({super.key, required this.passwordFocusNode});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _titleApp(),
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
        _InputPassword(focusNode: passwordFocusNode),
        //Forget Password
        Container(
          alignment: Alignment.centerRight,
          margin: const EdgeInsets.only(right: 15, left: 10, bottom: 7),
          child: GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
              Navigator.of(context).push(
                buildPageRoute(const ResetPasswordPage()),
              );
            },
            child: Text(
              S.current.Olvido_su_contrasena,
              textAlign: TextAlign.end,
              style: const TextStyle(color: $colorBlueGeneral),
            ),
          ),
        ),
        _ButtonLogin()
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
            hint: S.current.Correo_o_nombre_de_usuario,
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
  final FocusNode focusNode;

  const _InputPassword({required this.focusNode});

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
          child: Focus(
            focusNode: focusNode,
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
      margin: const EdgeInsets.only(right: 15, left: 10, bottom: 10),
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
          loginProvider.isFormPosted ? S.current.Cargando : S.current.Entrar,
        ),
      ),
    );
  }
}
