import 'package:flutter/material.dart';
import 'package:hope_app/presentation/utils/utils.dart';

class ButtonTextIcon extends StatelessWidget {
  final String title;
  final Icon icon;
  final Color buttonColor;
  final VoidCallback onClic;

  const ButtonTextIcon(
      {super.key,
      required this.title,
      required this.icon,
      required this.buttonColor,
      required this.onClic});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onClic,
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(buttonColor),
        iconColor: const MaterialStatePropertyAll($colorTextWhite),
      ),
      icon: icon,
      label: Text(
        title,
        style: const TextStyle(color: $colorTextWhite),
      ),
    );
  }
}
