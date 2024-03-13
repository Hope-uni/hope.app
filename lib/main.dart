import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/presentation/pages/routes.dart';

import 'presentation/utils/utils.dart';

Future<void> main() async {
  await Environment.initEnvitonment();
  await S.delegate.load(const Locale('es', 'NI'));
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Establecer la orientación por defecto como horizontal
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
    ]);
    // Ocultar la barra de estado
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky,
        overlays: []);

    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      title: S.current.Hope_App,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: $colorScheme),
        useMaterial3: true,
      ),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
    );
  }
}
