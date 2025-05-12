import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hope_app/presentation/providers/providers.dart';

final goRouterNotifierProvider = Provider((ref) {
  final authNotifier = ref.read(authProvider.notifier);
  return GoRouterNotifier(authNotifier);
});

class GoRouterNotifier extends ChangeNotifier {
  final AuthNotifier _authNotifier;
  AuthStatus _authStatus = AuthStatus.checking;

  late final VoidCallback _removeListener;

  GoRouterNotifier(this._authNotifier) {
    _removeListener = _authNotifier.addListener((state) {
      if (state.authStatus != _authStatus) {
        authStatus = state.authStatus;
      }
    });
  }

  AuthStatus get authStatus => _authStatus;

  set authStatus(AuthStatus value) {
    _authStatus = value;
    notifyListeners();
  }

  @override
  void dispose() {
    _removeListener();
    super.dispose();
  }
}
