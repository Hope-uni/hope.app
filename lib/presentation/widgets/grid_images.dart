import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/infrastructure/infrastructure.dart';
import 'package:hope_app/presentation/providers/providers.dart';
import 'package:hope_app/presentation/utils/utils.dart';
import 'package:hope_app/presentation/widgets/widgets.dart';
import 'package:toastification/toastification.dart';

const List<String> _list = <String>['Casa', 'Escuela', 'Comida', 'Animales'];

class GridImages extends ConsumerStatefulWidget {
  //TODO : Cambiar por una entidad de Pictogramas cuando este listo el endpoint
  final List<String> images;
  final bool isCustomized;
  final VoidCallback loadNextImages;

  const GridImages(
      {super.key,
      required this.images,
      required this.loadNextImages,
      required this.isCustomized});

  @override
  GridImagesState createState() => GridImagesState();
}

class GridImagesState extends ConsumerState<GridImages> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if ((scrollController.position.pixels + 500) >=
          scrollController.position.maxScrollExtent) {
        widget.loadNextImages();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final String? typePicto = ref.watch(pictogramsProvider).typePicto;
    final String namePicto = ref.watch(pictogramsProvider).namePicto;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      width: size.width,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: SelectBox(
                  valueInitial: typePicto,
                  marginHorizontal: 5,
                  hint: S.current.Categoria_de_pictogramas,
                  enable: true,
                  onSelected: (value) {
                    ref
                        .read(pictogramsProvider.notifier)
                        .onTypePictoChange(value!);
                  },
                  listItems: _list,
                ),
              ),
              Expanded(
                child: InputForm(
                  hint: S.current.Busqueda_por_nombre,
                  value: namePicto,
                  enable: true,
                  onChanged: (value) {
                    ref
                        .read(pictogramsProvider.notifier)
                        .onNamePictoChange(value);
                  },
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: ButtonTextIcon(
                    title: S.current.Buscar,
                    icon: const Icon(
                      Icons.search,
                    ),
                    buttonColor: $colorBlueGeneral,
                    onClic: () {}),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: ButtonTextIcon(
                    title: S.current.Limpiar_filtros,
                    icon: const Icon(
                      Icons.clear_all,
                    ),
                    buttonColor: $colorError,
                    onClic: () {
                      ref.read(pictogramsProvider.notifier).resetFilter();
                    }),
              )
            ],
          ),
          const SizedBox(height: 15),
          Expanded(
            child: GridView.builder(
              controller: scrollController,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 150,
                childAspectRatio: 0.6,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemCount: widget.images.length,
              itemBuilder: (context, index) {
                return _ImageGrid(
                  image: widget.images[index],
                  isCustomized: widget.isCustomized,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ImageGrid extends StatelessWidget {
  final String image;
  final bool isCustomized;
  const _ImageGrid({required this.image, required this.isCustomized});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 7),
      child: Column(children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: $colorShadow,
                spreadRadius: 3,
                blurRadius: 8,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          //TODO: Cambiar por url de los pictogramas
          child: const ImageLoad(urlImage: ''),
        ),
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: const Text('Manzana'),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () => {
                _dialogImage(context: context, urlImage: image),
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
    {required BuildContext context, required String urlImage}) {
  final image = CameraGalleryDataSourceImpl();
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          '${S.current.Editar_imagen} - Manzana',
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
        icon: const Icon(Icons.edit),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: ImageLoad(
                height: 180,
                width: 180,
                urlImage: urlImage,
                isDoubleTap: false,
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
          title: 'Eliminacion exitosa!',
          description:
              'Se elimino correctamente el pictograma personalizado: Manzana',
          typeAlert: ToastificationType.error);
      Navigator.of(context).pop();
    },
  );
}
