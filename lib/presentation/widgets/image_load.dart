import 'package:flutter/material.dart';
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
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: $colorTextBlack, width: 0.5),
                        color: $colorTextWhite,
                      ),
                      child: ImageLoad(
                        urlImage: urlImage,
                        isDoubleTap: false,
                      ),
                    ),
                  );
                },
              );
            },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: FadeInImage(
          fit: isDoubleTap == false ? null : BoxFit.cover,
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
