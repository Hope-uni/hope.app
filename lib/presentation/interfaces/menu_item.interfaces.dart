import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hope_app/domain/domain.dart';

class MenuItem {
  final String title;
  final String subTitle;
  final IconData icon;
  final String permission;
  final List<String> roles;
  final void Function({
    required BuildContext context,
    required WidgetRef ref,
    CatalogObject? item,
  }) onClick;

  const MenuItem({
    required this.title,
    required this.subTitle,
    required this.icon,
    required this.permission,
    required this.roles,
    required this.onClick,
  });
}
