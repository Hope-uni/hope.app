import 'package:flutter/material.dart';
import 'package:hope_app/presentation/utils/utils.dart';
import 'package:hope_app/presentation/widgets/widgets.dart';

class ImageListVIew extends StatelessWidget {
  final bool isSelect;
  final Icon? iconSelect;
  final Color? backgroundColorIcon;
  final bool isDecoration;

  const ImageListVIew({
    super.key,
    required this.isSelect,
    this.iconSelect,
    this.backgroundColorIcon,
    required this.isDecoration,
  });

//TODO: Cuando este listo el endpoint ajustar widget pare recibir data
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: isDecoration
          ? BoxDecoration(
              color: $colorBackgroundDrawer,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(width: 0.5),
            )
          : null,
      width: double.infinity,
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
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
                    margin:
                        const EdgeInsets.symmetric(horizontal: 7, vertical: 10),
                    //TODO: Agregar url de logros de los niños cuando el endpoint este listo
                    child: const ImageLoad(urlImage: ''),
                  ),
                  Visibility(
                    visible: isSelect,
                    child: IconButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                          backgroundColorIcon ?? $colorError,
                        ),
                        iconColor:
                            const MaterialStatePropertyAll($colorTextWhite),
                      ),
                      onPressed: () {},
                      icon: iconSelect ?? const Icon(Icons.check),
                    ),
                  )
                ],
              ),
              //TODO: Cambiar cuando este listo el endpoint
              const Text('Manzana')
            ],
          );
        },
      ),
    );
  }
}
