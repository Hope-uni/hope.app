import 'package:flutter/material.dart';
import 'package:hope_app/presentation/utils/utils.dart';
import 'package:hope_app/presentation/widgets/widgets.dart';

class ListTileCustom extends StatelessWidget {
  final String title;
  final Widget? iconButton;
  final Color? colorItemSelect;
  final Color? colorText;
  final String? image;
  final bool? noImage;
  final Widget? subTitle;
  final FontWeight? styleTitle;
  final bool? colorTitle;
  final void Function()? onTap;

  const ListTileCustom({
    super.key,
    required this.title,
    this.iconButton,
    this.colorItemSelect,
    this.colorText,
    this.image,
    this.noImage = false,
    this.subTitle,
    this.colorTitle,
    this.styleTitle,
    this.onTap,
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
        minLeadingWidth: 3,
        leading: noImage == false
            ? SizedBox(
                height: 55,
                width: 55,
                child: ClipOval(
                  child: ImageLoad(urlImage: image),
                ),
              )
            : Container(width: 3, color: colorText ?? $colorBlueGeneral),
        title: Container(
          padding: EdgeInsets.only(right: noImage == false ? 0 : 25),
          child: Text(
            title,
            maxLines: 2,
            style: TextStyle(
              fontWeight: styleTitle,
              color: colorTitle == true ? colorText ?? $colorBlueGeneral : null,
            ),
          ),
        ),
        subtitle: subTitle != null
            ? Container(
                padding: EdgeInsets.only(right: noImage == false ? 0 : 25),
                child: subTitle,
              )
            : null,
        onTap: onTap,
        trailing: iconButton,
        contentPadding: const EdgeInsets.only(right: 5, left: 15),
      ),
    );
  }
}
