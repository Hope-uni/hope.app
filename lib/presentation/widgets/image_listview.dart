import 'package:color_filter_extension/color_filter_extension.dart';
import 'package:flutter/material.dart';
import 'package:hope_app/presentation/utils/utils.dart';
import 'package:hope_app/presentation/widgets/widgets.dart';

class ImageListVIew extends StatelessWidget {
  final bool isSelect;
  final Icon? iconSelect;
  final Color? backgroundColorIcon;
  final bool isDecoration;
  final Color? backgroundDecoration;
  final bool? backgroundLine;
  final bool? isFilterBW;
  final List<String> images;
  final List<String> nameImages;

  const ImageListVIew({
    super.key,
    required this.isSelect,
    required this.isDecoration,
    this.iconSelect,
    this.backgroundColorIcon,
    this.backgroundDecoration,
    this.backgroundLine,
    this.isFilterBW = false,
    required this.images,
    required this.nameImages,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 15, right: 15, bottom: 12.5),
      decoration: isDecoration
          ? BoxDecoration(
              color: backgroundDecoration ?? $colorSuccess100,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(width: 0.5),
            )
          : null,
      width: double.infinity,
      height: 150,
      child: Stack(alignment: Alignment.center, children: [
        backgroundLine == true
            ? Container(
                height: 25,
                color: const Color.fromARGB(255, 50, 50, 50),
              )
            : Container(),
        ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: images.length,
          itemBuilder: (context, index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 7, vertical: 10),
                      child: ColorFiltered(
                        colorFilter: ColorFilterExt.preset(isFilterBW == true
                            ? ColorFiltersPreset.inkwell()
                            : ColorFiltersPreset.none()),
                        child: SizedBox(
                            height: 100,
                            width: 100,
                            child: ImageLoad(urlImage: images[index])),
                      ),
                    ),
                    Visibility(
                      visible: isSelect,
                      child: IconButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                            backgroundColorIcon ?? $colorError,
                          ),
                          iconColor:
                              const WidgetStatePropertyAll($colorTextWhite),
                        ),
                        onPressed: () {},
                        icon: iconSelect ?? const Icon(Icons.check),
                      ),
                    ),
                  ],
                ),
                Text(nameImages[index])
              ],
            );
          },
        ),
      ]),
    );
  }
}
