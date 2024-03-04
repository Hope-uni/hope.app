import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/constants.dart';

class AuthBackground extends StatelessWidget {
  final Widget formChild;

  const AuthBackground({super.key, required this.formChild});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      children: [
        //Formulario login
        Container(
          width: size.width * 0.5,
          height: size.height,
          color: $colorWhiteGeneral,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(children: [
                    Center(
                      child: formChild,
                    ),
                  ]),
                ),
              ),
              Container(
                  margin: const EdgeInsets.all(15),
                  child: const Text($titleRightsReserved))
            ],
          ),
        ),
        //Panel derecho Login
        Container(
          color: Colors.amber,
          width: size.width * 0.5,
          height: size.height,
          child: Stack(children: [
            Container(color: $colorBlueGeneral),
            _HeartCircle(),
          ]),
        ),
      ],
    );
  }
}

class _HeartCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Center(
      child: Container(
        width: size.width * 0.25,
        height: size.height * 0.5,
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
    );
  }
}
