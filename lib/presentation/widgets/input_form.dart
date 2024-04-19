import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hope_app/presentation/utils/utils.dart';

class InputForm extends StatelessWidget {
  final String value;
  final bool enable;
  final String? label;
  final String? hint;
  final String? errorText;
  final int? maxLength;
  final int? maxLines;
  final double? marginVertical;
  final bool? obscureText;
  final Widget? suffixIcon;
  final List<TextInputFormatter>? inputFormatters;
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
      this.inputFormatters,
      this.marginVertical,
      this.obscureText,
      this.suffixIcon,
      this.errorText});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController(text: value);
    final textLength = controller.value.text.length;
    controller.selection = TextSelection.collapsed(offset: textLength);
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
        ),
        child: TextField(
          obscureText: obscureText ?? false,
          inputFormatters: inputFormatters,
          keyboardType: TextInputType.emailAddress,
          maxLines: maxLines ?? 1,
          maxLength: enable ? maxLength : null,
          controller: controller,
          decoration: InputDecoration(
            errorText: errorText,
            errorMaxLines: 2,
            hintText: hint,
            counterText: maxLength != null && enable
                ? '$textLength/ $maxLength'
                : ' ', //Dejar el espacio en blanco para que no se descuadre el contenido cuando no tiene counterText
            labelText: label,
            labelStyle: const TextStyle(color: $colorTextBlack),
            contentPadding: suffixIcon == null
                ? const EdgeInsets.symmetric(vertical: 0)
                : null,
            suffixIcon: suffixIcon,
          ),
          textCapitalization: TextCapitalization.sentences,
          style: const TextStyle(color: $colorTextBlack),
          enabled: enable,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
