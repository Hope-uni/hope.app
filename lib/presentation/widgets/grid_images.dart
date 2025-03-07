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

const List<String> _list = <String>['Casa', 'Escuela', 'Comida', 'Animales'];

class GridImages extends ConsumerStatefulWidget {
  final bool isCustomized;

  const GridImages({super.key, required this.isCustomized});

  @override
  GridImagesState createState() => GridImagesState();
}

class GridImagesState extends ConsumerState<GridImages> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (mounted) {
        ref.read(pictogramsProvider.notifier).resetIsErrorInitial();
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

      if (statePictograms.paginatePictograms[$indexPage]! == 1) {
        await notifierPictograms.getPictograms();
      }

      scrollController.addListener(() async {
        final statePictograms = ref.read(pictogramsProvider);

        if ((scrollController.position.pixels + 50) >=
                scrollController.position.maxScrollExtent &&
            statePictograms.isLoading == false) {
          if (statePictograms.paginatePictograms[$indexPage]! > 1 &&
              statePictograms.paginatePictograms[$indexPage]! <=
                  statePictograms.paginatePictograms[$pageCount]!) {
            await notifierPictograms.getPictograms();
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final typePicto = ref.watch(pictogramsProvider).typePicto;

    final statePictograms = ref.read(pictogramsProvider);
    final stateWacthPictograms = ref.watch(pictogramsProvider);

    ref.listen(pictogramsProvider, (previous, next) {
      if (next.errorMessageApi != null) {
        toastAlert(
          context: context,
          title: S.current.Error,
          description: next.errorMessageApi!,
          typeAlert: ToastificationType.error,
        );
        ref.read(pictogramsProvider.notifier).updateErrorMessage();
      }
    });

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          const SizedBox(height: 20),
          SelectBox(
            valueInitial: typePicto,
            hint: S.current.Categoria_de_pictogramas,
            enable: true,
            onSelected: (value) {
              ref.read(pictogramsProvider.notifier).onTypePictoChange(value!);
            },
            listItems: _list,
          ),
          InputForm(
            hint: S.current.Busqueda_por_nombre,
            value: '',
            enable: true,
            onChanged: (value) {
              ref.read(pictogramsProvider.notifier).onNamePictoChange(value);
            },
          ),
          Expanded(
            child: Stack(
              children: [
                if (stateWacthPictograms.paginatePictograms[$indexPage] != 1)
                  SizedBox.expand(
                    child: stateWacthPictograms.pictograms.isNotEmpty
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
                                pictogram: statePictograms.pictograms[index],
                                isCustomized: widget.isCustomized,
                              );
                            },
                          )
                        : SvgPicture.asset(
                            fit: BoxFit.contain,
                            'assets/svg/SinDatos.svg',
                          ),
                  ),
                if (stateWacthPictograms.isLoading == true &&
                    stateWacthPictograms.paginatePictograms[$indexPage]! != 1)
                  const Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: CircularProgressIndicator(),
                    ),
                  ),
                // 🔄 LOADING
                if (stateWacthPictograms.paginatePictograms[$indexPage]! ==
                    1) ...[
                  const Opacity(
                    opacity: 0.5,
                    child: ModalBarrier(
                        dismissible: false, color: $colorTransparent),
                  ),
                  Center(
                    child: stateWacthPictograms.isErrorInitial == true
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
    );
  }
}

class _ImageGrid extends StatelessWidget {
  final PictogramAchievements pictogram;
  final bool isCustomized;
  const _ImageGrid({required this.pictogram, required this.isCustomized});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 7),
      child: Column(children: [
        Container(
          width: 100,
          height: 100,
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
            IconButton(
              onPressed: () => {
                _dialogImage(context: context, pictogram: pictogram),
              },
              tooltip: S.current.Editar,
              icon: const Icon(
                Icons.edit,
                color: $colorBlueGeneral,
              ),
            ),
            Visibility(
              visible: isCustomized,
              child: IconButton(
                  tooltip: S.current.Eliminar,
                  onPressed: () => _dialogConfirmation(context),
                  icon: const Icon(Icons.delete, color: $colorError)),
            )
          ],
        )
      ]),
    );
  }
}

Future<void> _dialogImage(
    {required BuildContext context, required PictogramAchievements pictogram}) {
  final image = CameraGalleryDataSourceImpl();
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(S.current.Editar_pictograma),
        icon: const Icon(Icons.edit),
        content: SingleChildScrollView(
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
                        border: Border.all(color: $colorTextBlack, width: 0.5),
                        color: $colorTextWhite,
                      ),
                      child: ImageLoad(
                        urlImage: pictogram.imageUrl,
                        isDoubleTap: false,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                    height: 200,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                            onPressed: () async {
                              // ignore: unused_local_variable
                              final photo = await image.selectImage();
                            },
                            icon: const Icon(Icons.photo)),
                        Text(S.current.Galeria),
                        IconButton(
                            onPressed: () async {
                              // ignore: unused_local_variable
                              final imagen = await image.takePhoto();
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
                value: pictogram.name,
                enable: true,
                onChanged: (value) {},
              ),
            ],
          ),
        ),
        actions: <Widget>[
          ButtonTextIcon(
            title: S.current.Actualizar,
            icon: const Icon(
              Icons.update,
            ),
            buttonColor: $colorBlueGeneral,
            onClic: () {
              Navigator.of(context).pop();
              toastAlert(
                  iconAlert: const Icon(Icons.update),
                  context: context,
                  title: S.current.Actualizado_con_exito,
                  description: S.current
                      .Se_actualizo_correctamente_el_pictograma_personalizado(
                          'Manzana'), //TODO: Cambiar cuando este  listo el endpoint
                  typeAlert: ToastificationType.info);
            },
          ),
          ButtonTextIcon(
            title: S.current.Cancelar,
            icon: const Icon(
              Icons.cancel,
            ),
            buttonColor: $colorError,
            onClic: () {
              Navigator.of(context).pop();
            },
          )
        ],
      );
    },
  );
}

Future<void> _dialogConfirmation(BuildContext context) {
  return modalDialogConfirmation(
    context: context,
    buttonColorConfirm: $colorSuccess,
    iconButtonConfirm: const Icon(
      Icons.delete,
    ),
    question: RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        //TODO: Cambiar cuando este  listo el endpoint
        text: S.current.Esta_seguro_que_desea_eliminar_el_pictograma(
            'Manzana', 'Alejandra'),
        style: const TextStyle(fontSize: 16, color: $colorTextBlack),
      ),
    ),
    titleButtonConfirm: S.current.Si_Eliminar,
    onClic: () {
      toastAlert(
          iconAlert: const Icon(Icons.delete),
          context: context,
          title: S.current.Eliminacion_exitosa,
          description:
              //TODO: Cambiar cuando este  listo el endpoint
              '${S.current.Se_elimino_correctamente_el_pictograma_personalizado}: Manzana',
          typeAlert: ToastificationType.error);
      Navigator.of(context).pop();
    },
  );
}
