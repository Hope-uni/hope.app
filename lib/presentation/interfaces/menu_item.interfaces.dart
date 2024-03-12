import 'package:flutter/material.dart';

class MenuItem {
  final String title;
  final String subTitle;
  final String url;
  final IconData icon;

  const MenuItem(
      {required this.title,
      required this.subTitle,
      required this.url,
      required this.icon});
}
