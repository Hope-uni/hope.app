import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hope_app/presentation/utils/utils.dart';

class InputForm extends StatefulWidget {
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
  final bool? readOnly;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String)? onChanged;
  final Function()? onTap;
  final bool? isSearch;
  final TextEditingController? controllerExt;

  const InputForm({
    super.key,
    required this.value,
    required this.enable,
    this.label,
    this.readOnly,
    this.maxLines,
    this.maxLength,
    this.onTap,
    this.onChanged,
    this.hint,
    this.inputFormatters,
    this.marginBottom,
    this.obscureText,
    this.suffixIcon,
    this.errorText,
    this.isNumber,
    this.isSearch,
    this.controllerExt,
  });

  @override
  State<InputForm> createState() => _InputFormState();
}

class _InputFormState extends State<InputForm> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        widget.controllerExt ?? TextEditingController(text: widget.value);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textLength = _controller.value.text.length;
    return Container(
      margin: EdgeInsets.only(
        left: 15,
        right: 15,
        bottom: widget.marginBottom == null ? 12.5 : widget.marginBottom!,
      ),
      child: TextField(
        controller: widget.controllerExt ?? _controller,
        onChanged: widget.onChanged,
        enabled: widget.enable,
        readOnly: widget.readOnly ?? false,
        maxLines: widget.maxLines ?? 1,
        obscureText: widget.obscureText ?? false,
        maxLength: widget.enable ? widget.maxLength : null,
        style: const TextStyle(color: $colorTextBlack),
        textCapitalization: TextCapitalization.sentences,
        textInputAction: widget.isSearch == true
            ? TextInputAction.search
            : TextInputAction.done,
        inputFormatters: widget.isNumber == true
            ? [FilteringTextInputFormatter.digitsOnly]
            : widget.inputFormatters,
        keyboardType: widget.isNumber == true
            ? TextInputType.number
            : TextInputType.emailAddress,
        onTap: widget.onTap,
        decoration: InputDecoration(
          labelText: widget.label,
          suffixIcon: widget.suffixIcon,
          errorText: widget.errorText,
          errorMaxLines: 2,
          hintText: widget.hint,
          labelStyle: const TextStyle(color: $colorTextBlack),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          counterText: widget.maxLength != null && widget.enable
              ? '$textLength/ ${widget.maxLength}'
              : ' ', //Dejar el espacio en blanco para que no se descuadre el contenido cuando no tiene counterText
        ),
      ),
    );
  }
}
