import 'package:flutter/material.dart';
import 'package:hope_app/presentation/utils/utils.dart';
import 'package:hope_app/presentation/widgets/widgets.dart';

class ListTileCustom extends StatelessWidget {
  final String title;
  final Widget? iconButton;
  final Color? colorItemSelect;
  final String? image;
  final bool? noImage;
  final String? subTitle;
  final FontWeight? styleSubTitle;
  final FontWeight? styleTitle;
  final bool? colorSubTitle;
  final bool? colorTitle;

  const ListTileCustom({
    super.key,
    required this.title,
    this.iconButton,
    this.colorItemSelect,
    this.image,
    this.noImage = false,
    this.subTitle,
    this.styleSubTitle,
    this.colorSubTitle,
    this.colorTitle,
    this.styleTitle,
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
            : Container(width: 3, color: $colorBlueGeneral),
        title: Text(title,
            maxLines: 2,
            style: TextStyle(
                fontWeight: styleTitle,
                color: colorTitle == true ? $colorBlueGeneral : null)),
        subtitle: subTitle != null
            ? Text(subTitle!,
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: styleSubTitle,
                    color: colorSubTitle == true ? $colorBlueGeneral : null))
            : null,
        trailing: iconButton,
        contentPadding: const EdgeInsets.only(right: 5, left: 15),
      ),
    );
  }
}
