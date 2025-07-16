import 'package:flutter/material.dart';
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
    return SizedBox(
      height: size.height - 30, // fija la altura total de la pantalla
      child: SingleChildScrollView(
        child: Column(
          children: [
            _HeartBackground(size: size),
            _FormInitial(formChild: formChild, size: size),
          ],
        ),
      ),
    );
  }
}

class _HeartBackground extends StatelessWidget {
  const _HeartBackground({
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height * 0.4,
      width: size.width,
      child: CustomPaint(
        painter: _HeaderPaintWaves(),
        child: const HeartCircle(),
      ),
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
      padding: const EdgeInsets.only(left: 40, right: 40),
      width: size.width,
      child: formChild,
    );
  }
}

class _HeaderPaintWaves extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = $colorBlueGeneral
      ..style = PaintingStyle.fill
      ..strokeWidth = 10;

    final path = Path();
    path.lineTo(0, size.height * 0.80);
    path.quadraticBezierTo(
      size.width * 0.25,
      size.height,
      size.width * 0.5,
      size.height * 0.80,
    );
    path.quadraticBezierTo(
      size.width * 0.75,
      size.height * 0.62,
      size.width,
      size.height * 0.7,
    );
    path.lineTo(size.width, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
