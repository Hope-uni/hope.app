import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hope_app/presentation/utils/utils.dart';

class HeartCircle extends StatelessWidget {
  const HeartCircle({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: FractionallySizedBox(
        widthFactor: 0.5, // Toma la mitad del ancho del padre
        heightFactor: 0.5,
        alignment: Alignment.topCenter,
        child: Container(
          width: size.width * 0.4,
          decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  $colorGradientPrimary,
                  $colorGradientSecundary,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: FractionallySizedBox(
              widthFactor: 0.6, // Toma la mitad del ancho del padre
              heightFactor: 0.6, // Toma la mitad del alto del padre
              child: SvgPicture.asset(
                'assets/svg/corazon_vectorizado.svg',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
