import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/presentation/utils/utils.dart';
import 'package:hope_app/presentation/widgets/widgets.dart';
import 'package:color_filter_extension/color_filter_extension.dart';

class BoardPage extends StatefulWidget {
  const BoardPage({super.key});

  @override
  State<BoardPage> createState() => _BoardPageState();
}

class _BoardPageState extends State<BoardPage> {
  int acceptedData = 0;
  int indexSeleccionado = 0;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    // Establecer la orientación por defecto como horizontal para el tablero de comunicacion
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
    return Scaffold(
      appBar: false
          ? null
          : AppBar(
              title: Text(
                //TODO: Cambiar cuando este liso el endpoint
                '${S.current.Actividad_pendiente}: Formar 5 oraciones con animales',
                maxLines: 2,
              ),
            ),
      body: Container(
        height: size.height,
        margin: const EdgeInsets.symmetric(horizontal: 7.5, vertical: 10),
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: GridView.builder(
                      itemCount: 30,
                      scrollDirection: Axis.vertical,
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 175,
                        crossAxisSpacing: 20.0,
                        mainAxisSpacing: 10.0,
                      ),
                      itemBuilder: (context, index) {
                        return const DraggableExample();
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 15),
                    width: 180,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 10,
                          ),
                          child: PressLoadButton(
                            resetAfterFinish: true,
                            buttonColor: $colorError,
                            loadingColor: $colorBlueGeneral,
                            duration: 2500,
                            radius: 20,
                            onConfirm: () {},
                            strokeWidth: 10,
                            width: 170,
                            height: 43,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.logout,
                                  color: $colorTextWhite,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  S.current.Cerrar_sesion,
                                  style: const TextStyle(
                                    color: $colorTextWhite,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              decoration: BoxDecoration(
                                color: $colorBackgroundDrawer,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: ListView.builder(
                                itemCount: 15,
                                itemBuilder: (context, index) {
                                  return Container(
                                    width: 170,
                                    color: indexSeleccionado == index
                                        ? $colorSelectMenu
                                        : null,
                                    child: ListTile(
                                      //TODO: Cambiar cuando este listo el endpoint
                                      leading: const Icon(Icons.pets),
                                      style: ListTileStyle.drawer,
                                      //TODO: Cambiar cuando este listo el endpoint
                                      title: Text('Animales $index'),
                                      onTap: () {
                                        setState(
                                            () => indexSeleccionado = index);
                                      },
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 50,
              alignment: Alignment.center,
              child: const Text(
                //TODO: Cambiar cuando el enpoint este listo
                'Yo quiero comer galleta',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
            ),
            DragTarget<int>(
              builder: (
                BuildContext context,
                List<dynamic> accepted,
                List<dynamic> rejected,
              ) {
                return Container(
                  decoration: BoxDecoration(
                      color: $colorBackgroundDrawer,
                      borderRadius: BorderRadius.circular(20)),
                  margin:
                      const EdgeInsets.only(bottom: 10, left: 12.5, right: 12),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  height: 155.0,
                  width: size.width,
                  child: Row(
                    children: [
                      ButtonTextIcon(
                        title: S.current.Limpiar,
                        buttonColor: $colorError,
                        icon: const Icon(Icons.delete),
                        onClic: () {},
                      ),
                      //TODO: Cambiar cuando este listo el endpoint
                      const Expanded(
                        child: ImageListVIew(
                          images: [],
                          isFilterBW: true,
                          backgroundLine: true,
                          isDecoration: false,
                          isSelect: false,
                        ),
                      ),
                      Visibility(
                        visible: true,
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 10,
                          ),
                          child: PressLoadButton(
                            resetAfterFinish: true,
                            buttonColor: $colorSuccess,
                            loadingColor: $colorBlueGeneral,
                            duration: 2500,
                            radius: 20,
                            onConfirm: () {},
                            strokeWidth: 10,
                            width: 200,
                            height: 43,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.check, color: $colorTextWhite),
                                const SizedBox(width: 10),
                                Text(
                                  S.current.Verificar_actividad,
                                  style: const TextStyle(
                                    color: $colorTextWhite,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              onAcceptWithDetails: (DragTargetDetails<int> details) {
                setState(() => acceptedData += details.data);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DraggableExample extends StatefulWidget {
  const DraggableExample({super.key});

  @override
  State<DraggableExample> createState() => _DraggableExampleState();
}

class _DraggableExampleState extends State<DraggableExample> {
  bool isFilterBW = true;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Draggable<int>(
          data: 10,
          feedback: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: SizedBox(
              height: 200.0,
              width: 200.0,
              child: ColorFiltered(
                colorFilter: ColorFilterExt.preset(isFilterBW
                    ? ColorFiltersPreset.inkwell()
                    : ColorFiltersPreset.none()),
                child: const ImageLoad(urlImage: ''),
              ),
            ),
          ),
          childWhenDragging: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              height: 140.0,
              width: 140.0,
              color: $colorButtonDisable.withValues(alpha: 0.25),
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: SizedBox(
              height: 140.0,
              width: 140.0,
              child: ColorFiltered(
                colorFilter: ColorFilterExt.preset(isFilterBW
                    ? ColorFiltersPreset.inkwell()
                    : ColorFiltersPreset.none()),
                child: const ImageLoad(urlImage: ''),
              ),
            ),
          ),
        )
      ],
    );
  }
}
