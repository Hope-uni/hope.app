import 'package:color_filter_extension/color_filter_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hope_app/domain/domain.dart';
import 'package:hope_app/presentation/utils/utils.dart';
import 'package:hope_app/presentation/widgets/widgets.dart';

class ImageListVIew extends ConsumerStatefulWidget {
  final bool isSelect;
  final Icon? iconSelect;
  final Color? backgroundColorIcon;
  final bool isDecoration;
  final Color? backgroundDecoration;
  final bool? backgroundLine;
  final bool? isFilterBW;
  final bool? isReorder;
  final ScrollController? controller;
  final List<PictogramAchievements> images;
  final List<PictogramAchievements>? newImages;
  final void Function(PictogramAchievements)? onPressed;
  final void Function(PictogramAchievements)? newOnPressed;
  final void Function(int, int)? onReorder;

  const ImageListVIew({
    super.key,
    required this.isSelect,
    required this.isDecoration,
    this.iconSelect,
    this.controller,
    this.backgroundColorIcon,
    this.backgroundDecoration,
    this.backgroundLine,
    this.isFilterBW = false,
    this.isReorder = false,
    required this.images,
    this.newImages,
    this.onPressed,
    this.newOnPressed,
    this.onReorder,
  });

  @override
  ImageListVIewState createState() => ImageListVIewState();
}

class ImageListVIewState extends ConsumerState<ImageListVIew> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 15, right: 15, bottom: 12.5),
      //padding: const EdgeInsets.only(left: 10),
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
          ReorderableListView.builder(
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
                        ClipRRect(
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
                                      urlImage: widget.images[index].imageUrl)),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: widget.isSelect,
                          child: IconButton(
                            style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(
                                widget.newImages == null
                                    ? widget.backgroundColorIcon ?? $colorError
                                    : (widget.newImages!
                                            .map((item) => item.id)
                                            .contains(widget.images[index].id)
                                        ? $colorError
                                        : widget.backgroundColorIcon ??
                                            $colorError),
                              ),
                              iconColor:
                                  const WidgetStatePropertyAll($colorTextWhite),
                            ),
                            onPressed: () {
                              if (widget.onPressed != null) {
                                if (widget.newImages == null) {
                                  widget.onPressed!(widget.images[index]);
                                } else {
                                  if (widget.newImages!
                                      .map((item) => item.id)
                                      .contains(widget.images[index].id)) {
                                    widget.newOnPressed!(widget.images[index]);
                                  } else {
                                    widget.onPressed!(widget.images[index]);
                                  }
                                }
                              }
                            },
                            icon: widget.newImages == null
                                ? widget.iconSelect ?? const Icon(Icons.check)
                                : (widget.newImages!
                                        .map((item) => item.id)
                                        .contains(widget.images[index].id)
                                    ? const Icon(Icons.delete)
                                    : widget.iconSelect ??
                                        const Icon(Icons.check)),
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
