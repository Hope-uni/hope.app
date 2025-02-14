import 'package:flutter/material.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/infrastructure/repositories/key_value_storage.repository.impl.dart';
import 'package:hope_app/presentation/utils/constants_desing.dart';
import 'package:hope_app/presentation/utils/modal_password.dart';
import 'package:hope_app/presentation/widgets/widgets.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
// Llama a la función para verificar la keyStorage al cargar la página
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final bool? verified = await KeyValueStorageRepositoryImpl()
          .getValueStorage<bool>(S.current.Verificado);

      if (verified != true) {
        if (context.mounted) {
          modalPassword(context: context, isVerifided: verified ?? false);
        }
      }
    });

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
