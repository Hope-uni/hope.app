import 'package:flutter/material.dart';
import 'package:hope_app/domain/domain.dart';
import 'package:hope_app/presentation/utils/utils.dart';

class SelectBox extends StatefulWidget {
  final List<CatalogObject> listItems;

  final String? label;
  final String? hint;
  final String? valueInitial;
  final String? errorText;

  final double? marginHorizontal;

  final bool? deleteSelection;
  final bool enable;

  final FocusNode? focus;

  final void Function(String?)? onSelected;
  final void Function()? reset;

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
    this.focus,
    this.reset,
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
        controller: controller,
        requestFocusOnTap: false,
        initialSelection: controller.value.text,
        expandedInsets: const EdgeInsets.all(1),
        onSelected: (value) {
          final selected = widget.listItems.firstWhere(
            (item) => item.id.toString() == value,
          );
          controller.text = selected.name;
          widget.onSelected?.call(value);
          setState(() {});
        },
        trailingIcon: controller.value.text.isNotEmpty == true &&
                widget.deleteSelection == true
            ? GestureDetector(
                onTap: () {
                  controller.clear();
                  widget.reset!.call();
                  setState(() {});
                },
                child: const Icon(Icons.clear),
              )
            : null,
        enableSearch: false,
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
        enableFilter: false,
        focusNode: widget.focus,
        hintText: widget.hint,
        errorText: widget.errorText,
        menuHeight: 250,
        //Dejar el espacio en blanco para que no se descuadre el contenido cuando no tiene counterText,
        helperText: ' ',
        inputDecorationTheme: const InputDecorationTheme(
          errorMaxLines: 2,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
        ),
        dropdownMenuEntries: widget.listItems
            .map<DropdownMenuEntry<String>>((CatalogObject item) {
          return DropdownMenuEntry<String>(
            value: item.id.toString(),
            label: item.name,
          );
        }).toList(),
      ),
    );
  }
}
