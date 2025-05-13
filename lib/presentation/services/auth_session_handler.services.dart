import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hope_app/presentation/providers/providers.dart'
    show authProvider;

// Esta variable debe asignarse en tu main o al iniciar sesión
late WidgetRef globalRef;

void handleUnauthorized({required String errorMessage}) {
  globalRef.read(authProvider.notifier).logout(errorUser: errorMessage);
}
