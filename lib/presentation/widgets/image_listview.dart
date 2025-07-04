import 'package:color_filter_extension/color_filter_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hope_app/domain/domain.dart';
import 'package:hope_app/presentation/utils/utils.dart';
import 'package:hope_app/presentation/widgets/widgets.dart';

class ImageListVIew extends ConsumerStatefulWidget {
  final bool? isSelect;
  final bool isDecoration;
  final bool isShowSvg;
  final bool? backgroundLine;
  final bool? isFilterBW;
  final bool? isReorder;
  final bool? isTap;
  final bool? isMarginLeft;

  final Icon? iconSelect;

  final Color? backgroundColorIcon;
  final Color? backgroundDecoration;

  final ScrollController? controller;

  final List<PictogramAchievements> images;
  final List<PictogramAchievements>? newImages;

  final void Function(PictogramAchievements)? onTap;
  final void Function(PictogramAchievements)? onPressed;
  final void Function(int, int)? onReorder;

  const ImageListVIew({
    super.key,
    this.iconSelect,
    this.controller,
    this.backgroundColorIcon,
    this.backgroundDecoration,
    this.backgroundLine,
    this.newImages,
    this.onTap,
    this.onPressed,
    this.onReorder,
    this.isShowSvg = false,
    this.isMarginLeft = true,
    this.isFilterBW = false,
    this.isReorder = false,
    this.isTap = false,
    this.isSelect = false,
    required this.images,
    required this.isDecoration,
  });

  @override
  ImageListVIewState createState() => ImageListVIewState();
}

class ImageListVIewState extends ConsumerState<ImageListVIew> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: widget.isMarginLeft! == true ? 15 : 0,
        right: 15,
        bottom: 12.5,
      ),
      decoration: widget.isDecoration
          ? BoxDecoration(
              color: widget.backgroundDecoration ?? $colorSuccess100,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(width: 0.5),
            )
          : null,
      width: double.infinity,
      height: 150,
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          widget.backgroundLine == true
              ? Container(height: 25, color: $backgroundLine)
              : Container(),
          widget.images.isEmpty && widget.isShowSvg == true
              ? SizedBox(
                  height: 250,
                  child: SvgPicture.asset(fit: BoxFit.contain, $noData),
                )
              : ReorderableListView.builder(
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(left: 10),
                      key: ValueKey(widget.images[index].id),
                      width: 125,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            alignment: Alignment.topRight,
                            children: [
                              GestureDetector(
                                onTap: widget.isTap == true
                                    ? () {
                                        if (!widget.newImages!
                                            .map((item) => item.id)
                                            .contains(
                                                widget.images[index].id)) {
                                          widget.onTap!(widget.images[index]);
                                        }
                                      }
                                    : null,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                          color: $colorTextBlack, width: 0.5),
                                      color: $colorTextWhite,
                                    ),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 7, vertical: 10),
                                    child: ColorFiltered(
                                      colorFilter: ColorFilterExt.preset(
                                          widget.isFilterBW == true
                                              ? ColorFiltersPreset.inkwell()
                                              : ColorFiltersPreset.none()),
                                      child: SizedBox(
                                          height: 100,
                                          width: 100,
                                          child: ImageLoad(
                                              urlImage: widget
                                                  .images[index].imageUrl)),
                                    ),
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: widget.isSelect == true &&
                                    widget.newImages!
                                        .map((item) => item.id)
                                        .contains(widget.images[index].id),
                                child: IconButton(
                                  style: ButtonStyle(
                                    backgroundColor: WidgetStatePropertyAll(
                                      widget.backgroundColorIcon ?? $colorError,
                                    ),
                                    iconColor: const WidgetStatePropertyAll(
                                      $colorTextWhite,
                                    ),
                                  ),
                                  onPressed: () {
                                    widget.onPressed!(widget.images[index]);
                                  },
                                  icon: widget.iconSelect ??
                                      const Icon(Icons.delete),
                                ),
                              ),
                            ],
                          ),
                          Tooltip(
                            message: widget.images[index].name,
                            child: Text(
                              widget.images[index].name,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.images.length,
                  proxyDecorator: (child, index, animation) => Material(
                    color: Colors.transparent,
                    child: child,
                  ),
                  onReorder: widget.onReorder ?? (oldIndex, newIndex) {},
                  scrollController: widget.controller,
                  buildDefaultDragHandles: widget.isReorder!,
                ),
        ],
      ),
    );
  }
}
