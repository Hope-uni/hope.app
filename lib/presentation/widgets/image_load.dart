import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hope_app/presentation/utils/utils.dart';

class ImageLoad extends StatelessWidget {
  final String? urlImage;
  final bool? isDoubleTap;

  const ImageLoad({
    super.key,
    this.urlImage,
    this.isDoubleTap,
  });

  @override
  Widget build(BuildContext context) {
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
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: urlImage != null && urlImage!.isNotEmpty
                            ? Border.all(color: $colorTextBlack, width: 0.5)
                            : null,
                        color: urlImage != null && urlImage!.isNotEmpty
                            ? $colorTextWhite
                            : null,
                      ),
                      child: ImageLoad(urlImage: urlImage, isDoubleTap: false),
                    ),
                  );
                },
              );
            },
      child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: urlImage != null && urlImage!.isNotEmpty
              ? FadeInImage(
                  fit: isDoubleTap == false ? null : BoxFit.cover,
                  placeholderFit: BoxFit.cover,
                  imageErrorBuilder: (context, error, stackTrace) {
                    return SvgPicture.asset(fit: BoxFit.contain, noIMage);
                  },
                  placeholder: const AssetImage(loading),
                  image: NetworkImage(urlImage!) as ImageProvider,
                )
              : SvgPicture.asset(fit: BoxFit.contain, noIMage, height: 220)),
    );
  }
}
