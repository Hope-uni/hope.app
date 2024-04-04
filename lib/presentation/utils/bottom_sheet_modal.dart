import 'package:flutter/material.dart';

void bottomSheetModal(
    {required BuildContext context,
    required double width,
    required List<Widget> arrayWidgets}) {
  showModalBottomSheet<void>(
    constraints: BoxConstraints.loose(Size(width, 150)),
    context: context,
    builder: (BuildContext context) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: arrayWidgets,
      );
    },
  );
}
