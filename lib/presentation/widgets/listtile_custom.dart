import 'package:flutter/material.dart';
import 'package:hope_app/presentation/utils/utils.dart';
import 'package:hope_app/presentation/widgets/widgets.dart';

class ListTileCustom extends StatelessWidget {
  final String title;
  final Widget iconButton;
  final Color? colorItemSelect;
  final String? image;
  final String? subTitle;

  const ListTileCustom({
    super.key,
    required this.title,
    required this.iconButton,
    this.colorItemSelect,
    this.image,
    this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: colorItemSelect ?? $colorBackgroundPages,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            offset: const Offset(0, 5),
            color: $colorShadow,
          )
        ],
      ),
      margin: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 15,
      ),
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: ListTile(
        leading: image != null
            ? SizedBox(
                height: 55,
                width: 55,
                child: ClipOval(child: ImageLoad(urlImage: image!)),
              )
            : null,
        title: Text(title),
        subtitle: subTitle != null ? Text(subTitle!) : null,
        trailing: iconButton,
      ),
    );
  }
}
