import 'package:flutter_riverpod/flutter_riverpod.dart';

final isClicSendEmailResetProvider = StateProvider<bool>((ref) => false);
final inputEmailUserProvider = StateProvider<String>((ref) => '');
