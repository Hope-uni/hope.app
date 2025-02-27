import 'package:flutter/material.dart';

class ImageLoad extends StatelessWidget {
  final String? urlImage;
  final double? height;
  final double? width;
  final bool? isDoubleTap;

  const ImageLoad({
    super.key,
    this.urlImage,
    this.height,
    this.width,
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
                  return AlertDialog(
                    contentPadding: EdgeInsets.zero,
                    content: ImageLoad(
                      urlImage: urlImage,
                      width: 300,
                      height: 280,
                      isDoubleTap: false,
                    ),
                  );
                },
              );
            },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: FadeInImage(
          height: height ?? 100,
          width: width ?? 100,
          fit: BoxFit.cover,
          placeholderFit: BoxFit.cover,
          imageErrorBuilder: (context, error, stackTrace) {
            return Image.asset('assets/img/no-image.png', fit: BoxFit.cover);
          },
          placeholder: const AssetImage('assets/gif/jar-loading.gif'),
          image: urlImage != null && urlImage!.isNotEmpty
              ? NetworkImage(urlImage!) as ImageProvider
              : const AssetImage('assets/img/no-image.png'),
        ),
      ),
    );
  }
}
