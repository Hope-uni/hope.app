import 'package:flutter/material.dart';

class MenuItem {
  final String title;
  final String subTitle;
  final String? url;
  final IconData icon;
  final ModalMenuItem? modalMenu;

  const MenuItem({
    required this.title,
    required this.subTitle,
    required this.icon,
    this.url,
    this.modalMenu,
  });
}

class ModalMenuItem {
  final RichText textDescription;
  final String titleButtonModal;

  ModalMenuItem({
    required this.textDescription,
    required this.titleButtonModal,
  });
}
