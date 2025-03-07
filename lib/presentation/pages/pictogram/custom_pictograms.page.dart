import 'package:flutter/material.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/presentation/widgets/widgets.dart';

class CustomPictogramasPage extends StatelessWidget {
  final int idChild;
  const CustomPictogramasPage({super.key, required this.idChild});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(S.current.Pictogramas_personalizados),
      ),
      body: const GridImages(isCustomized: true),
    );
  }
}
