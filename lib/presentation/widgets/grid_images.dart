import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/presentation/utils/constants_desing.dart';

const List<String> list = <String>['Casa', 'Escuela', 'Comida', 'Animales'];

class GridImages extends StatelessWidget {
  final bool isCustomized;
  final List<String> images;

  final VoidCallback? loadNextImages;
  const GridImages(
      {super.key,
      required this.images,
      this.loadNextImages,
      required this.isCustomized});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      width: size.width,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 35),
            width: size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(right: 15),
                    child: DropdownButtonFormField(
                      items: list.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      hint: Text(S.current.Categoria_de_pictogramas),
                      onChanged: (value) {},
                    ),
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: S.current.Busqueda_por_nombre,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextButton.icon(
                      style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll($colorBlueGeneral)),
                      onPressed: () {},
                      icon: const Icon(
                        Icons.search,
                        color: $colorTextWhite,
                      ),
                      label: Text(
                        S.current.Buscar,
                        style: const TextStyle(color: $colorTextWhite),
                      )),
                ),
                TextButton.icon(
                    style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll($colorError)),
                    onPressed: () {},
                    icon: const Icon(
                      Icons.clear_all,
                      color: $colorTextWhite,
                    ),
                    label: Text(
                      S.current.Limpiar_filtros,
                      style: const TextStyle(color: $colorTextWhite),
                    ))
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                crossAxisSpacing: 8.0,
                mainAxisExtent: 250,
                mainAxisSpacing: 8.0,
              ),
              itemCount: images.length,
              itemBuilder: (context, index) {
                return _ImageGrid(
                  image: images[index],
                  isCustomized: isCustomized,
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
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  spreadRadius: 3,
                  blurRadius: 8,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                image,
                height: 140,
                width: 140,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) {
                    return const Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    );
                  }
                  return FadeIn(child: child);
                },
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: const Text('Manzana'),
          ),
          LayoutBuilder(
            builder: (context, constraints) {
              // Verificar si el botón se desborda horizontalmente
              bool isOverflowing = constraints.maxWidth > 154;
              return isOverflowing
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton.icon(
                          onPressed: () => _dialogImage(context),
                          icon: const Icon(
                            Icons.edit,
                            color: $colorBlueGeneral,
                          ),
                          label: Text(S.current.Editar),
                        ),
                        isCustomized
                            ? TextButton.icon(
                                onPressed: () => _dialogConfirmation(context),
                                label: Text(S.current.Eliminar),
                                icon: const Icon(
                                  Icons.delete,
                                  color: $colorError,
                                ))
                            : Container(),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () => {
                            _dialogImage(context),
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: $colorBlueGeneral,
                          ),
                        ),
                        isCustomized
                            ? IconButton(
                                onPressed: () => _dialogConfirmation(context),
                                icon: const Icon(Icons.delete,
                                    color: $colorError))
                            : Container(),
                      ],
                    );
            },
          ),
        ],
      ),
    );
  }
}

bool isTablet(BuildContext context) {
  final size = MediaQuery.of(context).size;
  return size.width > 850;
}

Future<void> _dialogImage(BuildContext context) {
  final size = MediaQuery.of(context).size;
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return Container(
        margin: EdgeInsets.symmetric(
            vertical: size.height > 420 ? size.height * 0.25 : 10),
        child: AlertDialog(
          title: Row(
            children: [
              const Icon(Icons.edit),
              const SizedBox(
                width: 10,
              ),
              Text('${S.current.Editar_imagen} - Manzana'),
            ],
          ),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  'https://media.dev.to/cdn-cgi/image/width=1280,height=720,fit=cover,gravity=auto,format=auto/https%3A%2F%2Fdev-to-uploads.s3.amazonaws.com%2Fuploads%2Farticles%2Fao2m2l1skh8xfic16o4a.jpg',
                  height: 180,
                  width: 180,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress != null) {
                      return const Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      );
                    }
                    return FadeIn(child: child);
                  },
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(onPressed: () {}, icon: const Icon(Icons.photo)),
                  IconButton(
                      onPressed: () {}, icon: const Icon(Icons.add_a_photo))
                ],
              )
            ],
          ),
          actions: <Widget>[
            TextButton.icon(
              style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll($colorBlueGeneral)),
              icon: const Icon(
                Icons.save,
                color: $colorTextWhite,
              ),
              label: Text(
                S.current.Actualizar,
                style: const TextStyle(color: $colorTextWhite),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton.icon(
              style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll($colorError)),
              icon: const Icon(
                Icons.cancel,
                color: $colorTextWhite,
              ),
              label: Text(
                S.current.Cancelar,
                style: const TextStyle(color: $colorTextWhite),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    },
  );
}

Future<void> _dialogConfirmation(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(S.current.Aviso),
        content: Text(S.current.Esta_seguro_que_desea_eliminar_el_pictograma(
            'Manzana', 'Alejandra')),
        actions: <Widget>[
          TextButton.icon(
            style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll($colorBlueGeneral)),
            icon: const Icon(
              Icons.delete,
              color: $colorTextWhite,
            ),
            label: Text(
              S.current.Si_Eliminar,
              style: const TextStyle(color: $colorTextWhite),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton.icon(
            style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll($colorError)),
            icon: const Icon(
              Icons.cancel,
              color: $colorTextWhite,
            ),
            label: Text(
              S.current.Cancelar,
              style: const TextStyle(color: $colorTextWhite),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}