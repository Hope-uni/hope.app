import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/infrastructure/infrastructure.dart';
import 'package:hope_app/presentation/providers/providers.dart';
import 'package:hope_app/presentation/utils/utils.dart';
import 'package:hope_app/presentation/widgets/widgets.dart';

class DashboardPage extends ConsumerStatefulWidget {
  const DashboardPage({super.key});

  @override
  DashboardPageState createState() => DashboardPageState();
}

class DashboardPageState extends ConsumerState<DashboardPage> {
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
    ref.listen<ProfileState>(profileProvider, (previous, next) {
      if (next.userVerified == true && next.roles!.contains($paciente)) {
        context.pushReplacementNamed($board);
      }
    });

    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Tooltip(
          message: S.current
              .Bienvenido_pagina_de_inicio, // Muestra el nombre completo
          waitDuration:
              const Duration(milliseconds: 100), // Espera antes de mostrarse
          showDuration: const Duration(seconds: 2), // Tiempo visible
          child: Text(S.current.Bienvenido_pagina_de_inicio),
        ),
      ),
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
          ],
        ),
      ),
      drawer: const SideMenu(),
    );
  }
}
