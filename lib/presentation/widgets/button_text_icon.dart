import 'package:flutter/material.dart';
import 'package:hope_app/presentation/utils/utils.dart';

class ButtonTextIcon extends StatelessWidget {
  final String title;
  final Icon icon;
  final VoidCallback onClic;
  final Color? buttonColor;

  const ButtonTextIcon({
    super.key,
    required this.title,
    required this.icon,
    required this.onClic,
    this.buttonColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onClic,
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(buttonColor ?? $colorSuccess),
        iconColor: const WidgetStatePropertyAll($colorTextWhite),
      ),
      icon: icon,
      label: Text(
        title,
        style: const TextStyle(color: $colorTextWhite),
      ),
    );
  }
}
