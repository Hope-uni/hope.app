import 'package:flutter/material.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/presentation/utils/utils.dart';
import 'package:hope_app/presentation/widgets/heart_circle_background.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  SplashScreenPageState createState() => SplashScreenPageState();
}

class SplashScreenPageState extends State<SplashScreenPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: $colorBlueGeneral,
      body: Container(
        height: size.height,
        width: size.width,
        alignment: Alignment.center,
        color: $colorBlueGeneral,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Text(
                S.current.Hope,
                style: const TextStyle(
                  color: $colorTextWhite,
                  fontSize: 70,
                  fontWeight: FontWeight.bold,
                  fontFamily: $fontFamilyAnton,
                ),
              ),
            ),
            const Flexible(child: HeartCircle()),
            Container(
              margin: const EdgeInsets.only(top: 60),
              alignment: Alignment.center,
              width: 100,
              child: const LinearProgressIndicator(),
            ),
          ],
        ),
      ),
    );
  }
}
