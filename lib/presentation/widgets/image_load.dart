import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hope_app/presentation/utils/utils.dart';

class ImageLoad extends StatelessWidget {
  final String? urlImage;
  final bool? isDoubleTap;
  final String? imagePath;

  const ImageLoad({
    super.key,
    this.urlImage,
    this.isDoubleTap,
    this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    bool isError = false;
    return GestureDetector(
      onDoubleTap: isDoubleTap == false
          ? null
          : () {
              showDialog<void>(
                context: context,
                builder: (BuildContext context) {
                  return Dialog(
                    backgroundColor: Colors.transparent,
                    child: Container(
                      height: isError == true ? 200 : null,
                      width: isError == true ? 200 : null,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: urlImage != null && urlImage!.isNotEmpty
                            ? Border.all(
                                color: isError == true
                                    ? Colors.transparent
                                    : $colorTextBlack,
                                width: 0.5)
                            : null,
                        color: urlImage != null && urlImage!.isNotEmpty
                            ? (isError == true
                                ? Colors.transparent
                                : $colorTextWhite)
                            : null,
                      ),
                      child: ImageLoad(
                        urlImage: urlImage,
                        isDoubleTap: false,
                        imagePath: imagePath,
                      ),
                    ),
                  );
                },
              );
            },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: imagePath == null
            ? urlImage != null && urlImage!.isNotEmpty
                ? FadeInImage(
                    fit: isDoubleTap == false ? null : BoxFit.cover,
                    placeholderFit: BoxFit.cover,
                    imageErrorBuilder: (context, error, stackTrace) {
                      isError = true;
                      return Container(
                        padding: const EdgeInsets.all(7.5),
                        child: SvgPicture.asset(fit: BoxFit.contain, noIMage),
                      );
                    },
                    placeholder: const AssetImage(loading),
                    image: NetworkImage(urlImage!) as ImageProvider,
                  )
                : Container(
                    padding: const EdgeInsets.all(7.5),
                    child: SvgPicture.asset(
                      fit: BoxFit.contain,
                      noIMage,
                      height: 220,
                    ),
                  )
            : Image.file(File(imagePath!)),
      ),
    );
  }
}
