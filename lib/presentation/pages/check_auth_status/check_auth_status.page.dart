import 'package:flutter/material.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/presentation/utils/utils.dart';

class CheckAuthStatusPage extends StatelessWidget {
  const CheckAuthStatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Text(
        S.current.Hope,
        style: const TextStyle(
            color: $colorBlueGeneral,
            fontSize: 100,
            fontWeight: FontWeight.bold,
            fontFamily: $fontFamilyAnton),
      )),
    );
  }
}
