import 'package:flutter/material.dart';

class MenuItem {
  final String title;
  final String subTitle;
  final IconData icon;
  final Function({required BuildContext context, int? idItem}) onClick;

  const MenuItem({
    required this.title,
    required this.subTitle,
    required this.icon,
    required this.onClick,
  });
}
