import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/presentation/pages/pages.dart';
import 'presentation/utils/utils.dart';

Future<void> main() async {
  await Environment.initEnvitonment();
  await S.delegate.load(const Locale('es', 'NI'));
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Ocultar la barra de estado
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky,
        overlays: []);

    final appRouter = ref.watch(goRouterProvider);

    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      title: S.current.Hope,
      theme: ThemeData(
          colorSchemeSeed: $colorBlueGeneral,
          textTheme: const TextTheme(
            bodyLarge: $fontFamilyPoppins,
            bodyMedium: $fontFamilyPoppins,
            bodySmall: $fontFamilyPoppins,
            labelLarge: $fontFamilyPoppins,
            displayLarge: $fontFamilyPoppins,
            displayMedium: $fontFamilyPoppins,
            displaySmall: $fontFamilyPoppins,
            titleLarge: $fontFamilyPoppins,
            titleMedium: $fontFamilyPoppins,
            titleSmall: $fontFamilyPoppins,
            headlineLarge: $fontFamilyPoppins,
            headlineMedium: $fontFamilyPoppins,
            headlineSmall: $fontFamilyPoppins,
            labelSmall: $fontFamilyPoppins,
            labelMedium: $fontFamilyPoppins,
          ),
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
            backgroundColor: $colorBlueGeneral,
            iconTheme: IconThemeData(color: $colorTextWhite),
            titleTextStyle: TextStyle(color: $colorTextWhite, fontSize: 22),
          ),
          tabBarTheme: const TabBarTheme(
            indicatorColor: $colorIndicadorTabBar,
            labelColor: $colorTextWhite,
            unselectedLabelColor: $colorUnSelectTabBar,
          )),
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
