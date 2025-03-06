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
  final bool linesDynamic;
  final double? marginBottom;
  final bool? obscureText;
  final Widget? suffixIcon;
  final bool? isNumber;
  final bool? allCharacters;
  final bool? readOnly;
  final FocusNode? focus;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String)? onChanged;
  final Function()? onTap;
  final bool? isSearch;
  final TextEditingController? controllerExt;
  final Color? colorFilled;
  final bool isMargin;

  const InputForm({
    super.key,
    required this.value,
    required this.enable,
    this.label,
    this.readOnly,
    this.linesDynamic = false,
    this.maxLength,
    this.onTap,
    this.onChanged,
    this.hint,
    this.focus,
    this.inputFormatters,
    this.marginBottom,
    this.obscureText,
    this.suffixIcon,
    this.errorText,
    this.isNumber,
    this.allCharacters,
    this.isSearch,
    this.controllerExt,
    this.colorFilled,
    this.isMargin = true,
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
  void didUpdateWidget(InputForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Verifica si el valor ha cambiado
    if (widget.value != oldWidget.value) _controller.text = widget.value;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textLength = _controller.value.text.length;
    return Container(
      margin: EdgeInsets.only(
        left: widget.isMargin == true ? 15 : 0,
        right: widget.isMargin == true ? 15 : 0,
        bottom: widget.marginBottom == null ? 12.5 : widget.marginBottom!,
      ),
      child: TextField(
        focusNode: widget.focus,
        controller: widget.controllerExt ?? _controller,
        onChanged: widget.onChanged,
        enabled: widget.enable,
        readOnly: widget.readOnly ?? false,
        maxLines: widget.linesDynamic == false ? 1 : null,
        obscureText: widget.obscureText ?? false,
        maxLength: widget.enable ? widget.maxLength : null,
        style: const TextStyle(color: $colorTextBlack),
        textCapitalization: TextCapitalization.sentences,
        textInputAction: widget.isSearch == true
            ? TextInputAction.search
            : TextInputAction.done,
        inputFormatters: widget.isNumber == true
            ? [FilteringTextInputFormatter.digitsOnly]
            : (widget.allCharacters != false
                ? widget.inputFormatters
                : [FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]'))]),
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
          filled: widget.colorFilled != null ? true : false,
          fillColor: widget.colorFilled,
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
