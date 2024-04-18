import 'package:flutter/material.dart';
import 'package:hope_app/presentation/utils/utils.dart';

class InputForm extends StatelessWidget {
  final String value;
  final bool enable;
  final double? heigthInput;
  final String? label;
  final String? hint;
  final int? maxLength;
  final int? maxLines;
  final Function(String)? onChanged;

  const InputForm(
      {super.key,
      required this.value,
      required this.enable,
      this.label,
      this.maxLines,
      this.maxLength,
      this.onChanged,
      this.hint,
      this.heigthInput});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController(text: value);
    final textLength = controller.value.text.length;
    controller.selection = TextSelection.collapsed(offset: textLength);
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
        height: heigthInput ?? 66,
        child: TextField(
          keyboardType: TextInputType.text,
          maxLines: maxLines ?? 1,
          maxLength: enable ? maxLength : null,
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            counterText:
                maxLength != null && enable ? '$textLength/ $maxLength' : null,
            labelText: label,
            labelStyle: const TextStyle(color: $colorTextBlack),
            contentPadding: const EdgeInsets.symmetric(vertical: 0),
          ),
          textCapitalization: TextCapitalization.characters,
          style: const TextStyle(color: $colorTextBlack),
          enabled: enable,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
