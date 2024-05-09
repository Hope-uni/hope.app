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
  final double? marginBottom;
  final bool? obscureText;
  final Widget? suffixIcon;
  final bool? isNumber;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String)? onChanged;
  final bool? isSearch;

  const InputForm({
    super.key,
    required this.value,
    required this.enable,
    this.label,
    this.maxLines,
    this.maxLength,
    this.onChanged,
    this.hint,
    this.inputFormatters,
    this.marginBottom,
    this.obscureText,
    this.suffixIcon,
    this.errorText,
    this.isNumber,
    this.isSearch,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController(text: value);
    final textLength = controller.value.text.length;
    controller.selection = TextSelection.collapsed(offset: textLength);
    return Container(
      margin: EdgeInsets.only(
        left: 15,
        right: 15,
        bottom: marginBottom == null ? 12.5 : marginBottom!,
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        enabled: enable,
        maxLines: maxLines ?? 1,
        obscureText: obscureText ?? false,
        maxLength: enable ? maxLength : null,
        style: const TextStyle(color: $colorTextBlack),
        textCapitalization: TextCapitalization.sentences,
        textInputAction:
            isSearch == true ? TextInputAction.search : TextInputAction.done,
        inputFormatters: isNumber == true
            ? [FilteringTextInputFormatter.digitsOnly]
            : inputFormatters,
        keyboardType: isNumber == true
            ? TextInputType.number
            : TextInputType.emailAddress,
        decoration: InputDecoration(
          labelText: label,
          suffixIcon: suffixIcon,
          errorText: errorText,
          errorMaxLines: 2,
          hintText: hint,
          labelStyle: const TextStyle(color: $colorTextBlack),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          counterText: maxLength != null && enable
              ? '$textLength/ $maxLength'
              : ' ', //Dejar el espacio en blanco para que no se descuadre el contenido cuando no tiene counterText
        ),
      ),
    );
  }
}
