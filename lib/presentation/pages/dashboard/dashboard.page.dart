import 'package:flutter/material.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/infrastructure/infrastructure.dart';
import 'package:hope_app/presentation/utils/utils.dart';
import 'package:hope_app/presentation/widgets/widgets.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();
    // Llama a la función para verificar la keyStorage al cargar la página
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final bool? verified = await KeyValueStorageRepositoryImpl()
          .getValueStorage<bool>($verified);

      if (verified != true) {
        if (mounted) {
          modalPassword(
            context: context,
            isVerifided: verified ?? false,
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text(S.current.Bienvenido_pagina_de_inicio)),
      body: Container(
        height: size.height,
        width: size.width,
        alignment: Alignment.center,
        color: $colorBlueGeneral,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
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
            const Expanded(child: HeartCircle()),
          ],
        ),
      ),
      drawer: const SideMenu(),
    );
  }
}
