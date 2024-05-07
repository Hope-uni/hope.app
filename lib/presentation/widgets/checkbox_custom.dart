import 'package:flutter/material.dart';
import 'package:hope_app/presentation/utils/utils.dart';

class CheckBoxCustom extends StatefulWidget {
  final bool valueInitial;
  final Function(bool? value) onChange;
  const CheckBoxCustom(
      {super.key, required this.valueInitial, required this.onChange});

  @override
  State<CheckBoxCustom> createState() => _CheckBoxCustomState();
}

class _CheckBoxCustomState extends State<CheckBoxCustom> {
  late bool isSelect;
  @override
  void initState() {
    isSelect = widget.valueInitial;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: isSelect,
      checkColor: $colorTextWhite,
      onChanged: (bool? value) {
        setState(() {
          isSelect = !isSelect;
        });
        widget.onChange(value);
      },
    );
  }
}
