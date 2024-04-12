import 'package:flutter/material.dart';
import 'package:hope_app/presentation/utils/utils.dart';

class SelectBox extends StatelessWidget {
  final List<String> listItems;
  final bool enable;
  final String? label;
  final String? hint;
  final String? valueInitial;
  final void Function(String?)? onSelected;
  final double? marginHorizontal;

  const SelectBox(
      {super.key,
      required this.listItems,
      required this.enable,
      this.onSelected,
      this.label,
      this.hint,
      this.valueInitial,
      this.marginHorizontal});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller =
        TextEditingController(text: valueInitial);
    return Expanded(
      child: Container(
          height: 66,
          margin: EdgeInsets.symmetric(
              horizontal: marginHorizontal ?? 15, vertical: 7),
          child: DropdownMenu<String>(
            initialSelection: valueInitial,
            controller: controller,
            expandedInsets: const EdgeInsets.all(1),
            onSelected: onSelected,
            enabled: enable,
            label: label != null
                ? Text(
                    label!,
                    style: const TextStyle(color: $colorTextBlack),
                  )
                : null,
            hintText: hint,
            inputDecorationTheme: const InputDecorationTheme(
                border: UnderlineInputBorder(),
                constraints: BoxConstraints.expand(height: 48.5),
                contentPadding: EdgeInsets.zero),
            dropdownMenuEntries:
                listItems.map<DropdownMenuEntry<String>>((String value) {
              return DropdownMenuEntry<String>(value: value, label: value);
            }).toList(),
          )),
    );
  }
}
