import 'package:flutter/material.dart';

void bottomSheetModal({
  required BuildContext context,
  required List<Widget> arrayWidgets,
}) {
  final Size size = MediaQuery.of(context).size;
  showModalBottomSheet<void>(
    constraints: BoxConstraints.loose(Size(size.width, 150)),
    context: context,
    builder: (BuildContext context) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: arrayWidgets,
      );
    },
  );
}
