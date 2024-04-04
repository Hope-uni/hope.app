import 'package:flutter/material.dart';

class ImageLoad extends StatelessWidget {
  final String urlImage;
  final double height;
  final double width;

  const ImageLoad(
      {super.key,
      required this.urlImage,
      required this.height,
      required this.width});

  @override
  Widget build(BuildContext context) {
    return FadeInImage(
        height: height,
        width: width,
        fit: BoxFit.cover,
        placeholderFit: BoxFit.cover,
        imageErrorBuilder: (context, error, stackTrace) {
          return Image.asset('assets/img/no-image.png');
        },
        placeholder: const AssetImage('assets/gif/jar-loading.gif'),
        //TODO : Reemplazar luego por networImage
        image: const AssetImage(
            'assets/img/no-image.png')); //NetworkImage(urlImage) ;
  }
}
