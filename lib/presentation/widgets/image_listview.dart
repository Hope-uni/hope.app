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
  final bool? isMarginLeft;

  final Icon? iconSelect;

  final Color? backgroundColorIcon;
  final Color? backgroundDecoration;

  final ScrollController? controller;

  final List<PictogramAchievements> images;
  final List<PictogramAchievements>? newImages;

  final void Function(PictogramAchievements)? onTapAdd;
  final void Function(String)? onTapSound;
  final void Function(PictogramAchievements)? onPressed;
  final void Function(PictogramAchievements idPictogram)? onDragDeleted;
  final void Function(int, int)? onReorder;

  const ImageListVIew({
    super.key,
    this.iconSelect,
    this.controller,
    this.backgroundColorIcon,
    this.backgroundDecoration,
    this.backgroundLine,
    this.newImages,
    this.onTapAdd,
    this.onTapSound,
    this.onPressed,
    this.onDragDeleted,
    this.onReorder,
    this.isShowSvg = false,
    this.isMarginLeft = true,
    this.isFilterBW = false,
    this.isReorder = false,
    this.isSelect = false,
    required this.images,
    required this.isDecoration,
  });

  @override
  ImageListVIewState createState() => ImageListVIewState();
}

class ImageListVIewState extends ConsumerState<ImageListVIew> {
  OverlayEntry? _draggingOverlay;
  Offset _dragOffset = Offset.zero;
  PictogramAchievements? dragPictogram;
  bool isDelete = false;

  final GlobalKey _parentKey = GlobalKey();
  void _stopDragging() {
    _draggingOverlay?.remove();
    _draggingOverlay = null;
  }

  void _updateDragging(Offset position) {
    _dragOffset = position;
    // Esto forzará que el builder se ejecute otra vez
    _draggingOverlay?.markNeedsBuild();

    final parentBox =
        _parentKey.currentContext?.findRenderObject() as RenderBox?;
    if (parentBox != null) {
      final parentPosition = parentBox.localToGlobal(Offset.zero);
      final parentSize = parentBox.size;
      final parentRect = Rect.fromLTWH(
        parentPosition.dx,
        parentPosition.dy,
        parentSize.width,
        parentSize.height,
      );

      // Verificamos si la última posición conocida del drag está dentro del rectángulo padre
      if (!parentRect.contains(_dragOffset)) {
        isDelete = true;
      } else {
        isDelete = false;
      }
    }
  }

  void _startDragging(PictogramAchievements pictogram, Offset position) {
    _dragOffset = position;

    _draggingOverlay = OverlayEntry(
      builder: (context) => Positioned(
        left: _dragOffset.dx,
        top: _dragOffset.dy,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: $colorTextWhite,
                borderRadius: BorderRadius.circular(20),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: SizedBox(
                  height: 150,
                  width: 150,
                  child: ColorFiltered(
                    colorFilter: ColorFilterExt.preset(
                      widget.isFilterBW == true
                          ? ColorFiltersPreset.inkwell()
                          : ColorFiltersPreset.none(),
                    ),
                    child: ImageLoad(urlImage: pictogram.imageUrl),
                  ),
                ),
              ),
            ),
            if (isDelete)
              Container(
                decoration: BoxDecoration(
                  color: $colorDelete,
                  borderRadius: BorderRadius.circular(20),
                ),
                height: 150,
                width: 150,
                child: const Center(
                  child: Icon(Icons.delete, size: 30, color: $colorTextWhite),
                ),
              )
          ],
        ),
      ),
    );

    Overlay.of(context).insert(_draggingOverlay!);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _parentKey,
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
                      margin: EdgeInsets.only(
                        left: 10,
                        right: widget.backgroundLine == true &&
                                widget.images.length == index + 1
                            ? 200
                            : 0,
                      ),
                      key: ValueKey(widget.images[index].id),
                      width: 125,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            alignment: Alignment.topRight,
                            children: [
                              GestureDetector(
                                onTap: widget.onTapSound != null
                                    ? () => widget
                                        .onTapSound!(widget.images[index].name)
                                    : widget.onTapAdd != null
                                        ? () {
                                            if (!widget.newImages!
                                                .map((item) => item.id)
                                                .contains(
                                                    widget.images[index].id)) {
                                              widget.onTapAdd!(
                                                  widget.images[index]);
                                            }
                                          }
                                        : null,
                                onPanStart: (details) {
                                  setState(() {
                                    dragPictogram = widget.images[index];
                                  });
                                  _dragOffset = details.globalPosition;
                                  _startDragging(
                                      widget.images[index], _dragOffset);
                                },
                                onPanUpdate: (details) {
                                  _updateDragging(details.globalPosition);
                                },
                                onPanEnd: (details) {
                                  _stopDragging();

                                  final parentBox = _parentKey.currentContext
                                      ?.findRenderObject() as RenderBox?;
                                  if (parentBox != null) {
                                    final parentPosition =
                                        parentBox.localToGlobal(Offset.zero);
                                    final parentSize = parentBox.size;
                                    final parentRect = Rect.fromLTWH(
                                      parentPosition.dx,
                                      parentPosition.dy,
                                      parentSize.width,
                                      parentSize.height,
                                    );

                                    // Verificamos si la última posición conocida del drag está dentro del rectángulo padre
                                    if (!parentRect.contains(_dragOffset)) {
                                      widget.onDragDeleted!(dragPictogram!);
                                    }
                                    setState(() {
                                      dragPictogram = null;
                                    });
                                  }
                                },
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
                                    child: dragPictogram != null &&
                                            dragPictogram!.id ==
                                                widget.images[index].id
                                        ? Container(
                                            height: 100,
                                            width: 100,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: $colorButtonDisable
                                                  .withValues(alpha: 0.25),
                                            ),
                                          )
                                        : ColorFiltered(
                                            colorFilter: ColorFilterExt.preset(
                                                widget.isFilterBW == true
                                                    ? ColorFiltersPreset
                                                        .inkwell()
                                                    : ColorFiltersPreset
                                                        .none()),
                                            child: SizedBox(
                                                height: 100,
                                                width: 100,
                                                child: ImageLoad(
                                                    urlImage: widget
                                                        .images[index]
                                                        .imageUrl)),
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
                    color: $colorTransparent,
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
