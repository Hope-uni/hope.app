import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hope_app/presentation/utils/utils.dart';

class InputForm extends StatefulWidget {
  final int? maxLength;

  final double? marginBottom;

  final String value;
  final String? label;
  final String? hint;
  final String? errorText;

  final bool enable;
  final bool isMargin;
  final bool linesDynamic;
  final bool? obscureText;
  final bool? isNumber;
  final bool? allCharacters;
  final bool? isNumberLetter;
  final bool? readOnly;

  final Widget? suffixIcon;

  final FocusNode? focus;

  final List<TextInputFormatter>? inputFormatters;

  final Function(String)? onChanged;
  final Function()? onTap;
  final void Function()? onSearch;

  final TextEditingController? controllerExt;

  final Color? colorFilled;

  const InputForm({
    super.key,
    required this.value,
    required this.enable,
    this.linesDynamic = false,
    this.isMargin = true,
    this.label,
    this.readOnly,
    this.maxLength,
    this.onTap,
    this.onChanged,
    this.hint,
    this.focus,
    this.marginBottom,
    this.obscureText,
    this.suffixIcon,
    this.errorText,
    this.onSearch,
    this.colorFilled,
    this.controllerExt,
    this.isNumber,
    this.isNumberLetter,
    this.allCharacters = true,
    this.inputFormatters,
  });

  @override
  State<InputForm> createState() => _InputFormState();
}

class _InputFormState extends State<InputForm> {
  late TextEditingController _controller;
  Timer? _debounceTimer;
  bool _hasStartedTyping = false;
  List<TextInputFormatter>? inputFormatters;

  @override
  void initState() {
    super.initState();
    _controller =
        widget.controllerExt ?? TextEditingController(text: widget.value);
    if (widget.onSearch != null) _controller.addListener(_onSearchTextChanged);

    // Solo un tipo de inputFormatter será aplicado
    if (widget.isNumber == true) {
      inputFormatters = [FilteringTextInputFormatter.digitsOnly];
    } else if (widget.inputFormatters != null) {
      inputFormatters = widget.inputFormatters;
    } else if (widget.allCharacters == false) {
      inputFormatters = [FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]'))];
    } else if (widget.isNumberLetter == true) {
      inputFormatters = [
        FilteringTextInputFormatter.allow(
          RegExp(r'[a-zA-Z0-9]'),
        )
      ];
    } else {
      inputFormatters = null; // o una lista vacía si prefieres evitar nulls
    }
  }

  void _onSearchTextChanged() {
    // Evitamos ejecutar la lógica si es la primera vez que se hace focus o se inicializa
    if (!_hasStartedTyping) {
      _hasStartedTyping = true;
      return;
    }
    // Si ya existe un timer activo, lo cancelamos
    if (_debounceTimer?.isActive ?? false) _debounceTimer?.cancel();

    // Creamos un nuevo timer que espere 600ms después de que el usuario haya dejado de escribir
    _debounceTimer = Timer(const Duration(milliseconds: 600), () {
      if (widget.onSearch != null) widget.onSearch!.call();
    });
  }

  @override
  void didUpdateWidget(InputForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Verifica si el valor ha cambiado y conserva la posicion
    if (widget.value != oldWidget.value) {
      final previousPosition = _controller.selection.baseOffset;
      // Actualizar el texto
      _controller.text = widget.value;
      // Validar que la posición del cursor no sea mayor al nuevo texto
      final newOffset = previousPosition.clamp(0, _controller.text.length);
      // Asignar la nueva posición corregida
      _controller.selection = TextSelection.collapsed(offset: newOffset);
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (widget.onSearch != null) _controller.dispose();
    _debounceTimer?.cancel();
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
        inputFormatters: inputFormatters,
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
