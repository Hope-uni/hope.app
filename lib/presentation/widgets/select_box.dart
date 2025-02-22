import 'package:flutter/material.dart';
import 'package:hope_app/presentation/utils/utils.dart';

class SelectBox extends StatefulWidget {
  final List<String> listItems;
  final bool enable;
  final String? label;
  final String? hint;
  final String? valueInitial;
  final void Function(String?)? onSelected;
  final double? marginHorizontal;
  final String? errorText;
  final bool? deleteSelection;

  const SelectBox({
    super.key,
    required this.listItems,
    required this.enable,
    this.onSelected,
    this.label,
    this.deleteSelection,
    this.hint,
    this.errorText,
    this.valueInitial,
    this.marginHorizontal,
  });

  @override
  State<SelectBox> createState() => _SelectBoxState();
}

class _SelectBoxState extends State<SelectBox> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.valueInitial);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 15, right: 15, bottom: 12.5),
      child: DropdownMenu<String>(
        initialSelection: controller.value.text,
        controller: controller,
        expandedInsets: const EdgeInsets.all(1),
        onSelected: widget.onSelected,
        trailingIcon: widget.deleteSelection != true
            ? null
            : controller.value.text.isNotEmpty
                ? GestureDetector(
                    onTap: () {
                      setState(() => controller.text = '');
                    },
                    child: const Icon(Icons.clear),
                  )
                : null,
        enableSearch: true,
        enabled: widget.enable,
        label: widget.label != null
            ? Text(
                widget.label!,
                style: const TextStyle(
                  color: $colorTextBlack,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            : null,
        hintText: widget.hint,
        errorText: widget.errorText,
        //Dejar el espacio en blanco para que no se descuadre el contenido cuando no tiene counterText,
        helperText: ' ',
        inputDecorationTheme: const InputDecorationTheme(
          errorMaxLines: 2,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
        ),
        dropdownMenuEntries:
            widget.listItems.map<DropdownMenuEntry<String>>((String value) {
          return DropdownMenuEntry<String>(value: value, label: value);
        }).toList(),
      ),
    );
  }
}
