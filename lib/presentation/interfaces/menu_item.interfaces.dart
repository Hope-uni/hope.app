import 'package:flutter/material.dart';

class MenuItem {
  final String title;
  final String subTitle;
  final String nameUrl;
  final IconData icon;
  final String? url;
  final bool? isEdit;
  final ModalMenuItem? modalMenu;

  const MenuItem({
    required this.title,
    required this.subTitle,
    required this.icon,
    required this.nameUrl,
    this.url,
    this.isEdit,
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
