import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hope_app/domain/domain.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/infrastructure/infrastructure.dart';
import 'package:hope_app/presentation/pages/pages.dart';
import 'package:hope_app/presentation/services/services.dart';
import 'package:toastification/toastification.dart';
import 'presentation/providers/providers.dart';
import 'presentation/utils/utils.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Asegurar inicialización correcta
  await Environment.initEnvitonment();
  await S.delegate.load(const Locale('es', 'NI'));
  await DioService().configureBearer();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // Ejecutar código asíncrono después de que el widget haya sido renderizado por primera vez
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await DioService().configureBearer();
      // Verificar si el token está presente y realizar la llamada al endpoint "Me"
      final String? token =
          await KeyValueStorageRepositoryImpl().getValueStorage<String>($token);

      final bool? verified = await KeyValueStorageRepositoryImpl()
          .getValueStorage<bool>($verified);
      final refreshToken = await KeyValueStorageRepositoryImpl()
          .getValueStorage<String>($refreshToken);

      if (token != null && verified == true) {
        try {
          final Token tokenFinal =
              Token(accessToken: token, refreshToken: refreshToken!);
          // Aquí llamas a la API para obtener los datos del perfil del usuario
          final mePermisson = await AuthRepositoryImpl().mePermissions();
          final dataMe = mePermisson.data;
          if (dataMe != null) {
            // Guarda los datos del perfil en el almacenamiento local o en el estado global
            ref
                .read(authProvider.notifier)
                .settearDataMe(me: dataMe, token: tokenFinal);
          }
        } on CustomError catch (e) {
          if (e.errorCode == 403 && e.dataError != null) {
            final Token tokenFinal =
                Token(accessToken: token, refreshToken: refreshToken!);
            ref
                .read(profileProvider.notifier)
                .updateIsLoading(isLoading: false);
            ref
                .read(authProvider.notifier)
                .chagesStateAuthenticated(token: tokenFinal);

            return;
          }

          if (e.errorCode == 401) {
            if (mounted) {
              toastAlert(
                context: context,
                typeAlert: ToastificationType.error,
                title: S.current.Error,
                description: e.message,
              );
            }
            ref.read(authProvider.notifier).logout();
            return;
          }

          if (mounted) {
            toastAlert(
              context: context,
              typeAlert: ToastificationType.error,
              title: S.current.Error_al_actualizar_los_permisos,
              description: e.message,
            );
          }
          ref.read(authProvider.notifier).logout();
          return;
        } catch (error) {
          if (mounted) {
            toastAlert(
              context: context,
              typeAlert: ToastificationType.error,
              title: S.current.Error_al_actualizar_los_permisos,
              description: error.toString(),
            );
          }
          ref.read(authProvider.notifier).logout();
          return;
        }
      }
      if (token != null && verified != true) {
        final Token tokenFinal =
            Token(accessToken: token, refreshToken: refreshToken!);
        ref.read(profileProvider.notifier).updateIsLoading(isLoading: true);
        ref
            .read(authProvider.notifier)
            .chagesStateAuthenticated(token: tokenFinal);
      }
      if (token == null) {
        ref.read(authProvider.notifier).chagesStateNoAuthenticated();
      }
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Aquí guardamos el ref globalmente para el auth_Session_handler
    globalRef = ref;
    final appRouter = ref.watch(goRouterProvider);

    return ToastificationWrapper(
      child: MaterialApp.router(
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
      ),
    );
  }
}
