import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hope_app/domain/domain.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/infrastructure/infrastructure.dart';
import 'package:hope_app/presentation/providers/providers.dart';
import 'package:hope_app/presentation/utils/utils.dart';
import 'package:hope_app/presentation/widgets/widgets.dart';
import 'package:toastification/toastification.dart';

class GridImages extends ConsumerStatefulWidget {
  final bool isCustomized;
  final int idChild;

  const GridImages(
      {super.key, required this.idChild, required this.isCustomized});

  @override
  GridImagesState createState() => GridImagesState();
}

class GridImagesState extends ConsumerState<GridImages> {
  final scrollController = ScrollController();
  String? namePicto;
  int? idCategory;
  bool showErrorPermission = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (mounted) {
        ref.read(customPictogramProvider.notifier).setIdChild(
              idChild: widget.idChild,
            );
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();

    Future.microtask(() async {
      final notifierPictograms = ref.read(pictogramsProvider.notifier);
      final statePictograms = ref.read(pictogramsProvider);

      if (widget.isCustomized) {
        if (statePictograms.paginatePictograms[$indexPage]! == 1) {
          await notifierPictograms.getCustomPictograms(idChild: widget.idChild);
        }
      } else {
        if (statePictograms.paginatePictograms[$indexPage]! == 1) {
          await notifierPictograms.getPictograms();
        }
      }

      scrollController.addListener(() async {
        final statePictograms = ref.read(pictogramsProvider);

        if ((scrollController.position.pixels + 50) >=
                scrollController.position.maxScrollExtent &&
            statePictograms.isLoading == false) {
          if (statePictograms.paginatePictograms[$indexPage]! > 1 &&
              statePictograms.paginatePictograms[$indexPage]! <=
                  statePictograms.paginatePictograms[$pageCount]!) {
            if (widget.isCustomized) {
              await notifierPictograms.getCustomPictograms(
                idChild: widget.idChild,
              );
            } else {
              await notifierPictograms.getPictograms();
            }
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final statePictograms = ref.watch(pictogramsProvider);
    final notifierPictograms = ref.read(pictogramsProvider.notifier);
    final stateWacthCustomPictograms = ref.watch(customPictogramProvider);
    final selectedDelete = ref.watch(selectDelete);
    final profileState = ref.watch(profileProvider);

    ref.listen(pictogramsProvider, (previous, next) {
      if (next.errorMessageApi != null) {
        toastAlert(
          context: context,
          title: S.current.Error,
          description: next.errorMessageApi!,
          typeAlert: ToastificationType.error,
        );
        notifierPictograms.updateResponse();
      }
    });

    ref.listen(customPictogramProvider, (previous, next) {
      if (next.isLoading == false && next.isCreate == true) {
        toastAlert(
            iconAlert: const Icon(Icons.check),
            context: context,
            title: S.current.Actualizado_con_exito,
            description: S.current
                .Se_creo_correctamente_el_pictograma_personalizado(
                    next.pictogram!.name),
            typeAlert: ToastificationType.info);
        ref.read(customPictogramProvider.notifier).updateRequest();
      }

      if (next.isLoading == false && next.isDelete == true) {
        toastAlert(
          iconAlert: const Icon(Icons.delete),
          context: context,
          title: S.current.Eliminacion_exitosa,
          description:
              '${S.current.Se_elimino_correctamente_el_pictograma_personalizado}: ${next.pictogram!.name}',
          typeAlert: ToastificationType.success,
        );
        ref.read(customPictogramProvider.notifier).updateRequest();
      }

      if (next.isLoading == false && next.isUpdate == true) {
        toastAlert(
          iconAlert: const Icon(Icons.check),
          context: context,
          title: S.current.Actualizado_con_exito,
          description: S.current
              .Se_actualizo_correctamente_el_pictograma_personalizado(
                  next.pictogram!.name),
          typeAlert: ToastificationType.info,
        );
        ref.read(customPictogramProvider.notifier).updateRequest();
      }

      if (next.errorMessageApi != null) {
        toastAlert(
          context: context,
          title: S.current.Error,
          description: next.errorMessageApi!,
          typeAlert: ToastificationType.error,
        );
        ref.read(customPictogramProvider.notifier).updateRequest();
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!profileState.permmisions!.contains($listCategory) &&
          showErrorPermission == false) {
        toastAlert(
          iconAlert: const Icon(Icons.error),
          context: context,
          title: S.current.Error,
          description:
              S.current.No_tiene_permiso_para_listar_categorias_de_pictogramas,
          typeAlert: ToastificationType.error,
        );
        showErrorPermission = true;
      }
    });

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                const SizedBox(height: 20),
                SelectBox(
                  hint: S.current.Categoria_de_pictogramas,
                  enable: true,
                  onSelected: (value) async {
                    if (widget.isCustomized) {
                      await notifierPictograms.getCustomPictograms(
                        idChild: widget.idChild,
                        idCategory: int.parse(value!),
                      );
                    } else {
                      await notifierPictograms.getPictograms(
                        idCategory: int.parse(value!),
                      );
                    }
                    idCategory = int.parse(value);
                  },
                  deleteSelection: true,
                  reset: () {
                    idCategory = null;
                    notifierPictograms.resetFilters(
                      namePictogram: namePicto,
                      isCustom: widget.isCustomized,
                      idChild: widget.idChild,
                    );
                  },
                  listItems: statePictograms.categoryPictograms
                      .map((item) => CatalogObject(
                            id: item.id,
                            name: item.name,
                            description: '',
                          ))
                      .toList(),
                ),
                InputForm(
                  hint: S.current.Busqueda_por_nombre,
                  value: '',
                  enable: true,
                  onSearch: () async {
                    if (widget.isCustomized) {
                      await notifierPictograms.getCustomPictograms(
                        idChild: widget.idChild,
                        namePictogram: namePicto,
                        idCategory: idCategory,
                      );
                    } else {
                      await notifierPictograms.getPictograms(
                        namePictogram: namePicto,
                        idCategory: idCategory,
                      );
                    }
                  },
                  onChanged: (String value) {
                    namePicto = value.isNotEmpty ? value : null;
                  },
                ),
                Expanded(
                  child: Stack(
                    children: [
                      if (statePictograms.paginatePictograms[$indexPage] != 1)
                        SizedBox.expand(
                          child: statePictograms.pictograms.isNotEmpty
                              ? GridView.builder(
                                  controller: scrollController,
                                  gridDelegate:
                                      const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 150,
                                    childAspectRatio: 0.6,
                                  ),
                                  itemCount: statePictograms.pictograms.length,
                                  itemBuilder: (context, index) {
                                    return _ImageGrid(
                                      pictogram:
                                          statePictograms.pictograms[index],
                                      isCustomized: widget.isCustomized,
                                      ref: ref,
                                    );
                                  },
                                )
                              : SvgPicture.asset(
                                  fit: BoxFit.contain,
                                  'assets/svg/SinDatos.svg',
                                ),
                        ),
                      if (statePictograms.isLoading == true &&
                          statePictograms.paginatePictograms[$indexPage]! != 1)
                        const Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      // 🔄 LOADING
                      if (statePictograms.paginatePictograms[$indexPage]! ==
                          1) ...[
                        const Opacity(
                          opacity: 0.5,
                          child: ModalBarrier(
                              dismissible: false, color: $colorTransparent),
                        ),
                        Center(
                          child: statePictograms.isErrorInitial == true
                              ? SvgPicture.asset(
                                  fit: BoxFit.contain,
                                  'assets/svg/SinDatos.svg',
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const CircularProgressIndicator(),
                                    const SizedBox(height: 25),
                                    Text(
                                      S.current.Cargando,
                                      style: const TextStyle(
                                        color: $colorButtonDisable,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (stateWacthCustomPictograms.isLoading == true &&
              selectedDelete == true)
            const Opacity(
              opacity: 0.5,
              child: ModalBarrier(dismissible: false, color: $colorTextBlack),
            ),
          if (stateWacthCustomPictograms.isLoading == true &&
              selectedDelete == true)
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 25),
                  Text(
                    S.current.Cargando,
                    style: const TextStyle(
                      color: $colorTextWhite,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _ImageGrid extends StatelessWidget {
  final PictogramAchievements pictogram;
  final bool isCustomized;
  final WidgetRef ref;

  const _ImageGrid({
    required this.pictogram,
    required this.isCustomized,
    required this.ref,
  });

  @override
  Widget build(BuildContext context) {
    final profileState = ref.read(profileProvider);

    return Container(
      padding: const EdgeInsets.only(top: 7),
      child: Column(children: [
        Container(
          width: 110,
          height: 110,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: $colorTextBlack, width: 0.5),
            color: $colorTextWhite,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: ImageLoad(urlImage: pictogram.imageUrl),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: Tooltip(
            message: pictogram.name, // Muestra el nombre completo
            waitDuration:
                const Duration(milliseconds: 100), // Espera antes de mostrarse
            showDuration: const Duration(seconds: 2), // Tiempo visible
            child: Text(
              pictogram.name,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: !isCustomized,
              child: IconButton(
                onPressed: () => {
                  if (profileState.permmisions!
                      .contains($createCustomPictogram))
                    {
                      _dialogImage(
                        context: context,
                        pictogram: pictogram,
                        isCreate: true,
                      ),
                    }
                  else
                    {
                      toastAlert(
                        iconAlert: const Icon(Icons.info),
                        context: context,
                        title: S.current.No_autorizado,
                        description:
                            S.current.No_cuenta_con_el_permiso_necesario,
                        typeAlert: ToastificationType.info,
                      )
                    }
                },
                tooltip: S.current.Crear,
                icon: const Icon(
                  Icons.create,
                  color: $colorBlueGeneral,
                ),
              ),
            ),
            Visibility(
              visible: isCustomized,
              child: IconButton(
                onPressed: () => {
                  if (profileState.permmisions!
                      .contains($updateCustomPictogram))
                    {
                      _dialogImage(
                        context: context,
                        pictogram: pictogram,
                        isCreate: false,
                      ),
                    }
                  else
                    {
                      toastAlert(
                        iconAlert: const Icon(Icons.info),
                        context: context,
                        title: S.current.No_autorizado,
                        description:
                            S.current.No_cuenta_con_el_permiso_necesario,
                        typeAlert: ToastificationType.info,
                      )
                    }
                },
                tooltip: S.current.Editar,
                icon: const Icon(
                  Icons.update,
                  color: $colorBlueGeneral,
                ),
              ),
            ),
            Visibility(
              visible: isCustomized,
              child: Consumer(
                builder: (context, ref, child) {
                  return IconButton(
                    tooltip: S.current.Eliminar,
                    onPressed: () {
                      if (profileState.permmisions!
                          .contains($deleteCustomPictogram)) {
                        _dialogConfirmation(
                          context: context,
                          pictogram: pictogram,
                          ref: ref,
                        );
                      } else {
                        toastAlert(
                          iconAlert: const Icon(Icons.info),
                          context: context,
                          title: S.current.No_autorizado,
                          description:
                              S.current.No_cuenta_con_el_permiso_necesario,
                          typeAlert: ToastificationType.info,
                        );
                      }
                    },
                    icon: const Icon(Icons.delete, color: $colorError),
                  );
                },
              ),
            )
          ],
        )
      ]),
    );
  }
}

Future<void> _dialogImage({
  required BuildContext context,
  required PictogramAchievements pictogram,
  required bool isCreate,
}) {
  final image = CameraGalleryDataSourceImpl();
  bool isdisable = false;
  String? imagePathCel;

  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      final notifierCustomPicto = ProviderScope.containerOf(context)
          .read(customPictogramProvider.notifier);

      Future.microtask(() {
        notifierCustomPicto.loadCustomPictogram(pictogram: pictogram);
      });

      return StatefulBuilder(
        builder: (context, setState) {
          return Consumer(
            builder: (context, ref, child) {
              final stateCustomPicto = ref.watch(customPictogramProvider);

              Future<void> selectImage() async {
                final String? imagePath = await image.selectImage();
                if (imagePath != null) {
                  final file = File(imagePath);
                  ref.read(customPictogramProvider.notifier).updateImage(file);
                  setState(() => imagePathCel = imagePath);
                }
              }

              Future<void> takePhoto() async {
                final String? imagePath = await image.takePhoto();
                if (imagePath != null) {
                  final file = File(imagePath);
                  ref.read(customPictogramProvider.notifier).updateImage(file);
                  setState(() => imagePathCel = imagePath);
                }
              }

              if (stateCustomPicto.pictogram == null) {
                return Stack(
                  children: [
                    const Opacity(
                      opacity: 0.5,
                      child: ModalBarrier(
                        dismissible: false,
                        color: $colorTextBlack,
                      ),
                    ),
                    Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const CircularProgressIndicator(),
                          const SizedBox(height: 25),
                          Text(
                            S.current.Cargando,
                            style: const TextStyle(
                              color: $colorTextWhite,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }

              return Stack(
                children: [
                  AlertDialog(
                    title: Container(
                      width: 275,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        color: $colorBlueGeneral,
                      ),
                      padding: const EdgeInsets.only(
                        left: 22,
                        top: 20,
                        bottom: 20,
                        right: 22,
                      ),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        isCreate
                            ? S.current.Personalizar_pictograma
                            : S.current.Actualizar_pictograma,
                        style: const TextStyle(
                          color: $colorTextWhite,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    titlePadding: EdgeInsets.zero,
                    insetPadding: EdgeInsets.zero,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 22,
                      vertical: 5,
                    ),
                    content: SizedBox(
                      width: 275,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Container(
                                    height: 180,
                                    width: 180,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                          color: $colorTextBlack, width: 0.5),
                                      color: $colorTextWhite,
                                    ),
                                    child: ImageLoad(
                                      urlImage:
                                          stateCustomPicto.pictogram!.imageUrl,
                                      isDoubleTap: false,
                                      imagePath: imagePathCel,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                SizedBox(
                                  height: 200,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      IconButton(
                                          onPressed: () async {
                                            await selectImage();
                                          },
                                          icon: const Icon(Icons.photo)),
                                      Text(S.current.Galeria),
                                      IconButton(
                                          onPressed: () async {
                                            await takePhoto();
                                          },
                                          icon: const Icon(Icons.add_a_photo)),
                                      Text(S.current.Camara),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 15),
                            InputForm(
                              label: S.current.Nombre,
                              colorFilled: $colorTextWhite,
                              isMargin: false,
                              maxLength: 60,
                              linesDynamic: true,
                              value: stateCustomPicto.pictogram!.name,
                              enable: isdisable == false ? true : false,
                              onChanged: (value) {
                                notifierCustomPicto.updateName(value);
                              },
                              errorText:
                                  stateCustomPicto.validationErrors[$name],
                            ),
                          ],
                        ),
                      ),
                    ),
                    actions: <Widget>[
                      Row(
                        children: [
                          Expanded(
                            child: ButtonTextIcon(
                              title: isdisable == false
                                  ? S.current.Cancelar
                                  : S.current.Salir,
                              icon: const Icon(Icons.cancel),
                              buttonColor: $colorError,
                              onClic: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                          if (isdisable == false && isCreate == true)
                            const SizedBox(width: 5),
                          if (isdisable == false && isCreate == true)
                            Expanded(
                              child: ButtonTextIcon(
                                title: S.current.Guardar,
                                icon: const Icon(Icons.save),
                                buttonColor: $colorSuccess,
                                onClic: () async {
                                  if (notifierCustomPicto.checkFields()) {
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();

                                    isdisable = await notifierCustomPicto
                                        .createCustomPictogram();

                                    setState(() {});
                                  }
                                },
                              ),
                            ),
                          if (!isCreate) const SizedBox(width: 5),
                          if (!isCreate)
                            Expanded(
                              child: ButtonTextIcon(
                                title: S.current.Actualizar,
                                icon: const Icon(Icons.update),
                                buttonColor: $colorBlueGeneral,
                                onClic: () async {
                                  if (notifierCustomPicto.checkFields()) {
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                    await notifierCustomPicto
                                        .updateCustomPictogram();
                                  }
                                },
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                  if (stateCustomPicto.isLoading == true)
                    const Opacity(
                      opacity: 0.5,
                      child: ModalBarrier(
                          dismissible: false, color: $colorTextBlack),
                    ),
                  if (stateCustomPicto.isLoading == true)
                    Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const CircularProgressIndicator(),
                          const SizedBox(height: 25),
                          Text(
                            S.current.Cargando,
                            style: const TextStyle(
                              color: $colorTextWhite,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              );
            },
          );
        },
      );
    },
  );
}

Future<void> _dialogConfirmation({
  required BuildContext context,
  required WidgetRef ref,
  required PictogramAchievements pictogram,
}) {
  ref
      .read(customPictogramProvider.notifier)
      .loadCustomPictogram(pictogram: pictogram);

  final selectedDelete = ref.read(selectDelete.notifier);
  return modalDialogConfirmation(
    context: context,
    buttonColorConfirm: $colorSuccess,
    iconButtonConfirm: const Icon(
      Icons.delete,
    ),
    question: RichText(
      textAlign: TextAlign.left,
      text: TextSpan(
        children: [
          TextSpan(
              text:
                  '${S.current.Esta_seguro_que_desea_eliminar_el_pictograma}\n\n'),
          TextSpan(
            text: pictogram.name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
        style: const TextStyle(fontSize: 16, color: $colorTextBlack),
      ),
    ),
    titleButtonConfirm: S.current.Si_Eliminar,
    onClic: () async {
      selectedDelete.state = true;
      await ref.read(customPictogramProvider.notifier).deleteCustomPictogram();
      if (context.mounted) {
        Navigator.of(context).pop();
      }
      selectedDelete.state = false;
    },
  );
}
