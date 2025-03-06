import 'package:flutter/material.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/presentation/widgets/widgets.dart';

class PictogramPage extends StatelessWidget {
  final int idChild;
  const PictogramPage({super.key, required this.idChild});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.Lista_de_pictogramas_generales),
      ),
      body: const GridImages(isCustomized: false),
    );
  }
}
