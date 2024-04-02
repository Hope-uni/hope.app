import 'package:flutter/material.dart';
import 'package:hope_app/presentation/utils/utils.dart';

class InputForm extends StatelessWidget {
  final String label;
  final String value;
  final int? maxLength;
  final bool enable;
  final Function(String)? onChanged;

  const InputForm(
      {super.key,
      required this.label,
      required this.value,
      required this.enable,
      this.maxLength,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController(text: value);
    final textLength = controller.value.text.length;
    controller.selection = TextSelection.collapsed(offset: textLength);
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        height: 75,
        child: TextField(
          maxLength: maxLength,
          controller: controller,
          decoration: InputDecoration(
            counterText: maxLength != null ? '$textLength/ $maxLength' : null,
            labelText: label,
            labelStyle: const TextStyle(color: $colorTextForlightBackgrounds),
            contentPadding: const EdgeInsets.symmetric(vertical: 0),
          ),
          textCapitalization: TextCapitalization.characters,
          style: const TextStyle(color: $colorTextForlightBackgrounds),
          enabled: enable,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
