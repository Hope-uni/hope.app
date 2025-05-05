import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hope_app/domain/domain.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/presentation/providers/providers.dart';
import 'package:hope_app/presentation/utils/utils.dart';
import 'package:hope_app/presentation/widgets/widgets.dart';
import 'package:color_filter_extension/color_filter_extension.dart';
import 'package:toastification/toastification.dart';

class BoardPage extends ConsumerStatefulWidget {
  const BoardPage({super.key});

  @override
  BoardPageState createState() => BoardPageState();
}

class BoardPageState extends ConsumerState<BoardPage> {
  final scrollController = ScrollController();

  bool _initialized = false;
  bool _initializedWidgetsBinding = false;
  bool _isMonochrome = false;
  bool showErrorPermissionCategory = false;
  bool showErrorPermissionPictograms = false;

  int? indexSeleccionado;

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();

    if (!_initialized) {
      _initialized = true;

      Future.microtask(() async {
        final notifierPictograms = ref.read(pictogramsProvider.notifier);
        final notifierBoard = ref.read(boardProvider.notifier);
        await notifierPictograms.getPictogramsPatient();
        await notifierBoard.getPatientActivity();
        _isMonochrome =
            ref.read(profileProvider).profile!.isMonochrome ?? false;

        scrollController.addListener(() async {
          final statePictograms = ref.read(pictogramsProvider);

          if ((scrollController.position.pixels + 50) >=
                  scrollController.position.maxScrollExtent &&
              statePictograms.isLoading == false) {
            if (statePictograms.paginatePictograms[$indexPage]! > 1 &&
                statePictograms.paginatePictograms[$indexPage]! <=
                    statePictograms.paginatePictograms[$pageCount]!) {
              await notifierPictograms.getPictogramsPatient();
            }
          }
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    // Establecer la orientación por defecto como horizontal para el tablero de comunicacion
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    final statePictograms = ref.watch(pictogramsProvider);
    final stateBoard = ref.watch(boardProvider);
    final notifierPictograms = ref.read(pictogramsProvider.notifier);

    final stateProfile = ref.watch(profileProvider);
    final notifierBoard = ref.read(boardProvider.notifier);

    ref.listen(pictogramsProvider, (previous, next) {
      if (next.errorMessageApi != null) {
        toastAlert(
          context: context,
          title: S.current.Error,
          description: next.errorMessageApi!,
          typeAlert: ToastificationType.error,
        );
        ref.read(pictogramsProvider.notifier).updateResponse();
      }
    });

    ref.listen(boardProvider, (previous, next) {
      if (next.errorMessageApi != null) {
        toastAlert(
          context: context,
          title: S.current.Error,
          description: next.errorMessageApi!,
          typeAlert: ToastificationType.error,
        );
        notifierBoard.updateResponse();
      }

      if (next.checkSuccess != null) {
        toastAlert(
          context: context,
          title: S.current.Verificado,
          description: next.checkSuccess!,
          typeAlert: ToastificationType.success,
        );

        notifierBoard.updateResponse();
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_initializedWidgetsBinding == false) {
        _initializedWidgetsBinding = true;
        if (!stateProfile.permmisions!.contains($listCategory) &&
            showErrorPermissionCategory == false) {
          toastAlert(
            iconAlert: const Icon(Icons.error),
            context: context,
            title: S.current.Error,
            description: S
                .current.No_tiene_permiso_para_listar_categorias_de_pictogramas,
            typeAlert: ToastificationType.error,
          );
          showErrorPermissionCategory = true;
        }

        if (!stateProfile.permmisions!.contains($listCustomPictogram) &&
            showErrorPermissionPictograms == false) {
          toastAlert(
            iconAlert: const Icon(Icons.error),
            context: context,
            title: S.current.Error,
            description: S.current.No_tiene_permiso_para_listar_los_pictogramas,
            typeAlert: ToastificationType.error,
          );
          showErrorPermissionPictograms = true;
        }
      }
    });

    return Scaffold(
      appBar: stateBoard.patientActivity!.currentActivity == null &&
              stateBoard.patientActivity!.latestCompletedActivity == null
          ? null
          : AppBar(
              title: stateBoard.patientActivity!.currentActivity == null
                  ? Text(
                      '${S.current.Ultima_actividad_terminada}: ${stateBoard.patientActivity!.latestCompletedActivity!.name}',
                      maxLines: 2,
                    )
                  : Text(
                      '${S.current.Actividad_actual}: ${stateBoard.patientActivity!.currentActivity!.name}',
                      maxLines: 2,
                    ),
            ),
      body: Container(
        height: size.height,
        margin:
            const EdgeInsets.only(top: 20, bottom: 10, left: 7.5, right: 7.5),
        child: Stack(
          children: [
            if (stateBoard.isLoading == false)
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        if (statePictograms.pictograms.isEmpty == false)
                          Expanded(
                            child: GridView.builder(
                              controller: scrollController,
                              itemCount: statePictograms.pictograms.length,
                              scrollDirection: Axis.vertical,
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 175,
                                crossAxisSpacing: 20.0,
                                mainAxisSpacing: 10.0,
                              ),
                              itemBuilder: (context, index) {
                                return buildDraggableExample(
                                  isFilterBW: _isMonochrome,
                                  pictogram: statePictograms.pictograms[index],
                                );
                              },
                            ),
                          ),
                        if (statePictograms.pictograms.isEmpty == true)
                          Expanded(
                            child: Center(
                              child: SizedBox(
                                height: 400,
                                child: SvgPicture.asset(
                                  fit: BoxFit.contain,
                                  'assets/svg/SinDatos.svg',
                                ),
                              ),
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
                                  onConfirm: () async {
                                    await ref
                                        .read(authProvider.notifier)
                                        .logout();
                                  },
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
                                    child: statePictograms
                                                .categoryPictograms.isEmpty ==
                                            false
                                        ? ListView.builder(
                                            itemCount: statePictograms
                                                .categoryPictograms.length,
                                            itemBuilder: (context, index) {
                                              return Container(
                                                width: 170,
                                                color:
                                                    indexSeleccionado == index
                                                        ? $colorSelectMenu
                                                        : null,
                                                child: ListTile(
                                                  //leading: const Icon(Icons.pets),
                                                  style: ListTileStyle.drawer,
                                                  title: Text(statePictograms
                                                      .categoryPictograms[index]
                                                      .name),
                                                  onTap: () async {
                                                    if (index ==
                                                        indexSeleccionado) {
                                                      await notifierPictograms
                                                          .getPictogramsPatient();
                                                    } else {
                                                      await notifierPictograms
                                                          .getPictogramsPatient(
                                                              idCategory:
                                                                  statePictograms
                                                                      .categoryPictograms[
                                                                          index]
                                                                      .id);
                                                    }
                                                    setState(() {
                                                      if (index ==
                                                          indexSeleccionado) {
                                                        indexSeleccionado =
                                                            null;
                                                      } else {
                                                        indexSeleccionado =
                                                            index;
                                                      }
                                                    });
                                                  },
                                                ),
                                              );
                                            },
                                          )
                                        : Center(
                                            child: SizedBox(
                                              height: 400,
                                              child: SvgPicture.asset(
                                                fit: BoxFit.contain,
                                                'assets/svg/SinDatos.svg',
                                              ),
                                            ),
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
                    margin:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    height: 75,
                    alignment: Alignment.center,
                    child: Text(
                      stateBoard.pictograms
                          .map((item) => item.name)
                          .toList()
                          .join(' '),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                  ),
                  DragTarget<PictogramAchievements>(
                    builder: (
                      BuildContext context,
                      List<dynamic> accepted,
                      List<dynamic> rejected,
                    ) {
                      return Container(
                        decoration: BoxDecoration(
                            color: $colorBackgroundDrawer,
                            borderRadius: BorderRadius.circular(20)),
                        margin: const EdgeInsets.only(
                            bottom: 10, left: 12.5, right: 12),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        height: 155.0,
                        width: size.width,
                        child: Row(
                          children: [
                            ButtonTextIcon(
                              title: S.current.Limpiar,
                              buttonColor: $colorError,
                              icon: const Icon(Icons.delete),
                              onClic: () {
                                notifierBoard.clearPictogramSolution();
                                notifierPictograms.setPictogramsPatients();
                              },
                            ),
                            Expanded(
                              child: ImageListVIew(
                                images: stateBoard.pictograms,
                                backgroundLine: true,
                                isDecoration: false,
                                isSelect: false,
                                isReorder: true,
                                onReorder: notifierBoard.onChangeOrderSolution,
                              ),
                            ),
                            Visibility(
                              visible:
                                  stateBoard.patientActivity!.currentActivity !=
                                          null ||
                                      stateBoard.patientActivity!
                                              .latestCompletedActivity !=
                                          null,
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
                                  onConfirm: () async {
                                    if (stateProfile.permmisions!
                                        .contains($verifyActivityAnswer)) {
                                      if (await notifierBoard.checkAnswer()) {
                                        notifierBoard.clearPictogramSolution();
                                        notifierPictograms
                                            .setPictogramsPatients();
                                      }
                                    } else {
                                      toastAlert(
                                        iconAlert: const Icon(Icons.info),
                                        context: context,
                                        title: S.current.No_autorizado,
                                        description: S.current
                                            .No_cuenta_con_el_permiso_necesario,
                                        typeAlert: ToastificationType.info,
                                      );
                                    }
                                  },
                                  strokeWidth: 10,
                                  width: 200,
                                  height: 43,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(Icons.check,
                                          color: $colorTextWhite),
                                      const SizedBox(width: 10),
                                      Text(
                                        S.current.Verificar,
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
                    onAcceptWithDetails:
                        (DragTargetDetails<PictogramAchievements> details) {
                      notifierBoard.addPictogramSolution(
                          newPictogram: details.data);

                      notifierPictograms.deletePictogram(
                        idPictogram: details.data.id,
                      );
                    },
                  ),
                ],
              ),
            if (stateBoard.isLoading != false) ...[
              const ModalBarrier(dismissible: false, color: $colorTextWhite),
              Center(
                child: Column(
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
    );
  }
}

Widget buildDraggableExample({
  required PictogramAchievements pictogram,
  required bool isFilterBW,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[
      Draggable<PictogramAchievements>(
        data: pictogram,
        feedback: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: SizedBox(
            height: 200.0,
            width: 200.0,
            child: ColorFiltered(
              colorFilter: ColorFilterExt.preset(
                isFilterBW
                    ? ColorFiltersPreset.inkwell()
                    : ColorFiltersPreset.none(),
              ),
              child: ImageLoad(urlImage: pictogram.imageUrl),
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
        child: SizedBox(
          width: 140.0,
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: SizedBox(
                  height: 140.0,
                  width: 140.0,
                  child: ColorFiltered(
                    colorFilter: ColorFilterExt.preset(
                      isFilterBW
                          ? ColorFiltersPreset.inkwell()
                          : ColorFiltersPreset.none(),
                    ),
                    child: ImageLoad(urlImage: pictogram.imageUrl),
                  ),
                ),
              ),
              Text(
                pictogram.name,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
