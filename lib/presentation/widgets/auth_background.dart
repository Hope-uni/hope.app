import 'package:flutter/material.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/presentation/utils/utils.dart';
import 'package:hope_app/presentation/widgets/widgets.dart';

class AuthBackground extends StatelessWidget {
  final bool isLogin;
  final Widget formChild;

  const AuthBackground(
      {super.key, required this.formChild, required this.isLogin});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      children: _condicionalBackground(isLogin, size, formChild),
    );
  }
}

List<StatelessWidget> _condicionalBackground(bool islogin, size, formChild) {
  if (islogin) {
    return [
      _FormInitial(size: size, formChild: formChild),
      //Panel derecho Login
      _HeartBackground(size: size)
    ];
  } else {
    return [
      _HeartBackground(size: size),
      _FormInitial(size: size, formChild: formChild)
    ];
  }
}

class _HeartBackground extends StatelessWidget {
  const _HeartBackground({
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 0, color: Colors.transparent),
        color: $colorBlueGeneral,
      ),
      width: size.width * 0.5,
      height: size.height,
      child: const Stack(children: [
        HeartCircle(),
      ]),
    );
  }
}

class _FormInitial extends StatelessWidget {
  const _FormInitial({
    required this.size,
    required this.formChild,
  });

  final Size size;
  final Widget formChild;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: size.height * 0.1, left: 40, right: 40),
      width: size.width * 0.5,
      height: size.height,
      child: Column(
        children: [
          SingleChildScrollView(
            child: Container(alignment: Alignment.center, child: formChild),
          ),
          const Spacer(),
          Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: Text(S.current.Derechos_reservados))
        ],
      ),
    );
  }
}
