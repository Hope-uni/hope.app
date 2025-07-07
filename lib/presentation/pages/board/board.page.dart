import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_tts/flutter_tts.dart';
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

  FlutterTts flutterTts = FlutterTts();
  bool isTtsReady = false;

  int? indexSeleccionado;

  @override
  void initState() {
    super.initState();
    // Establecer la orientación por defecto como horizontal para el tablero de comunicacion
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
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
        final stateBoard = ref.read(boardProvider);
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
              await notifierPictograms.getPictogramsPatient(
                  pictogramsSolution: stateBoard.pictograms,
                  idCategory: indexSeleccionado != null
                      ? statePictograms
                          .categoryPictograms[indexSeleccionado!].id
                      : null);
            }
          }
        });
      });
    }
  }

  Future<void> initTTS() async {
    await flutterTts.setLanguage("es-ES");
    await flutterTts.setPitch(1.0);
    await flutterTts.awaitSpeakCompletion(true);

    // Verificamos si el motor está disponible
    var available = await flutterTts.isLanguageAvailable("es-ES");
    isTtsReady = available ?? false;
  }

  Future<void> speak(String text) async {
    if (!isTtsReady) await initTTS();

    final engines = await flutterTts.getEngines;
    //⚠️ No TTS engines installed (emulador)
    if (engines == null || engines.isEmpty) return;

    if (isTtsReady) {
      await flutterTts.speak(text);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

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

      if (next.checkSuccess != null && next.isCompleteActivity == true) {
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

    void showToast({required BuildContext context, required bool isError}) {
      final overlay = Overlay.of(context);
      late OverlayEntry overlayEntry; // ← Aquí la declaramos primero
      overlayEntry = OverlayEntry(
        builder: (context) => Dismissible(
          key: const Key($toast),
          direction: DismissDirection.horizontal,
          onDismissed: (_) => overlayEntry.remove(),
          child: Center(
            child: Material(
              color: $colorTransparent,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                decoration: BoxDecoration(
                  color: $colorBlack85,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 160,
                      width: 160,
                      child: Image.asset(isError ? $iconAgain : $success),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      isError
                          ? S.current.Intente_otra_solucion
                          : S.current.Bien_hecho,
                      style: const TextStyle(
                        color: $colorTextWhite,
                        fontSize: 22,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

      overlay.insert(overlayEntry);

      // Eliminar automáticamente después de 3 segundo
      Future.delayed(const Duration(seconds: 3), () {
        if (overlayEntry.mounted) overlayEntry.remove();
      });
    }

    return Scaffold(
      appBar: stateBoard.patientActivity!.currentActivity == null &&
              stateBoard.patientActivity!.latestCompletedActivity == null
          ? null
          : AppBar(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Tooltip(
                    // Muestra el nombre completo
                    message: stateBoard.patientActivity!.currentActivity == null
                        ? '${S.current.Ultima_actividad_terminada}: ${stateBoard.patientActivity!.latestCompletedActivity!.name}'
                        : '${S.current.Actividad_actual}: ${stateBoard.patientActivity!.currentActivity!.name}',
                    waitDuration: const Duration(
                        milliseconds: 100), // Espera antes de mostrarse
                    showDuration: const Duration(seconds: 2), // Tiempo visible
                    child: stateBoard.patientActivity!.currentActivity == null
                        ? Text(
                            '${S.current.Ultima_actividad_terminada}: ${stateBoard.patientActivity!.latestCompletedActivity!.name}',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          )
                        : Text(
                            '${S.current.Actividad_actual}: ${stateBoard.patientActivity!.currentActivity!.name}',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                  ),
                  const Spacer(),
                  if (stateBoard.patientActivity!.currentActivity != null)
                    Text(
                      '${stateBoard.patientActivity!.currentActivity!.satisfactoryAttempts}/${stateBoard.patientActivity!.currentActivity!.satisfactoryPoints}',
                      style: const TextStyle(color: $colorTextWhite),
                    ),
                  if (stateBoard.patientActivity!.currentActivity != null)
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      width: 120,
                      child: LinearProgressIndicator(
                        value: double.parse(stateBoard
                                .patientActivity!.currentActivity!.progress) /
                            100,
                        minHeight: 7,
                        color: $colorIndicadorTabBar,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                ],
              ),
              actions: [
                Opacity(
                  opacity: 0.35,
                  child: Container(
                    margin: const EdgeInsets.only(right: 15),
                    child: IconButton(
                      icon: const Icon(Icons.help),
                      onPressed: () {
                        showDialog<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Container(
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20)),
                                  color: $colorBlueGeneral,
                                ),
                                padding: const EdgeInsets.only(
                                    left: 22, top: 20, bottom: 20),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  S.current.Ayuda,
                                  style: const TextStyle(
                                    color: $colorTextWhite,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              titlePadding: EdgeInsets.zero,
                              content: SingleChildScrollView(
                                child: SizedBox(
                                  width: 200,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        S.current.Descripcion_de_la_actividad,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        stateBoard.patientActivity!
                                                    .currentActivity ==
                                                null
                                            ? stateBoard
                                                .patientActivity!
                                                .latestCompletedActivity!
                                                .description
                                            : stateBoard.patientActivity!
                                                .currentActivity!.description,
                                      ),
                                      const SizedBox(height: 30),
                                      Text(
                                        S.current
                                            .Para_verificar_la_actividad_o_cerrar_sesion,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(S.current
                                          .Debe_presionar_el_boton_correspondiente_durante_tres_segundos_para_realizar_la_accion),
                                      const SizedBox(height: 30),
                                      Text(
                                        S.current
                                            .Si_algun_texto_no_se_muestra_completo,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(S.current
                                          .Mantener_el_dedo_sobre_el_texto_durante_1_segundo_para_verlo_completo),
                                    ],
                                  ),
                                ),
                              ),
                              insetPadding: EdgeInsets.zero,
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
      body: Stack(
        children: [
          Container(
            height: size.height,
            margin: const EdgeInsets.only(
              top: 20,
              bottom: 10,
              left: 7.5,
              right: 7.5,
            ),
            child: Stack(
              children: [
                if (stateBoard.isLoading == false)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: Stack(
                                children: [
                                  if (statePictograms.pictograms.isEmpty ==
                                          false &&
                                      statePictograms.isNewFilter != true)
                                    GridView.builder(
                                      controller: scrollController,
                                      itemCount:
                                          statePictograms.pictograms.length,
                                      scrollDirection: Axis.vertical,
                                      gridDelegate:
                                          const SliverGridDelegateWithMaxCrossAxisExtent(
                                        maxCrossAxisExtent: 175,
                                        crossAxisSpacing: 20.0,
                                        mainAxisSpacing: 10.0,
                                      ),
                                      itemBuilder: (context, index) {
                                        return buildDraggableExample(
                                          speak: speak,
                                          isFilterBW: _isMonochrome,
                                          pictogram:
                                              statePictograms.pictograms[index],
                                        );
                                      },
                                    ),
                                  if (statePictograms.pictograms.isEmpty ==
                                      true)
                                    Center(
                                      child: SizedBox(
                                        height: 400,
                                        child: SvgPicture.asset(
                                            fit: BoxFit.contain, $noData),
                                      ),
                                    ),
                                  if (statePictograms.isLoading == true &&
                                      statePictograms
                                              .paginatePictograms[$indexPage] ==
                                          1)
                                    Container(
                                      color: $colorTransparent,
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                                    ),
                                ],
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: statePictograms
                                                    .categoryPictograms
                                                    .isEmpty ==
                                                false
                                            ? ListView.builder(
                                                itemCount: statePictograms
                                                    .categoryPictograms.length,
                                                itemBuilder: (context, index) {
                                                  return Container(
                                                    width: 170,
                                                    color: indexSeleccionado ==
                                                            index
                                                        ? $colorSelectMenu
                                                        : null,
                                                    child: ListTile(
                                                      style:
                                                          ListTileStyle.drawer,
                                                      title: Tooltip(
                                                        // Muestra el nombre completo
                                                        message: statePictograms
                                                            .categoryPictograms[
                                                                index]
                                                            .name,
                                                        // Espera antes de mostrarse
                                                        waitDuration:
                                                            const Duration(
                                                          milliseconds: 100,
                                                        ),
                                                        // Tiempo visible
                                                        showDuration:
                                                            const Duration(
                                                          seconds: 2,
                                                        ),
                                                        child: Text(statePictograms
                                                            .categoryPictograms[
                                                                index]
                                                            .name),
                                                      ),
                                                      onTap: () async {
                                                        if (index ==
                                                            indexSeleccionado) {
                                                          await notifierPictograms
                                                              .getPictogramsPatient(
                                                                  pictogramsSolution:
                                                                      stateBoard
                                                                          .pictograms);
                                                        } else {
                                                          await notifierPictograms.getPictogramsPatient(
                                                              idCategory:
                                                                  statePictograms
                                                                      .categoryPictograms[
                                                                          index]
                                                                      .id,
                                                              pictogramsSolution:
                                                                  stateBoard
                                                                      .pictograms);
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
                                                    $noData,
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
                        margin: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 5,
                        ),
                        height: 75,
                        alignment: Alignment.center,
                        child: SingleChildScrollView(
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
                                    isFilterBW: _isMonochrome,
                                    isDecoration: false,
                                    isSelect: false,
                                    isReorder: true,
                                    onReorder:
                                        notifierBoard.onChangeOrderSolution,
                                  ),
                                ),
                                Visibility(
                                  visible: stateBoard.patientActivity!
                                              .currentActivity !=
                                          null ||
                                      stateBoard.patientActivity!
                                              .latestCompletedActivity !=
                                          null,
                                  child: IgnorePointer(
                                    ignoring: !stateBoard.pictograms
                                        .isNotEmpty, // 👈 true = ignora, no se puede presionar
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 10,
                                      ),
                                      child: PressLoadButton(
                                        resetAfterFinish: true,
                                        buttonColor:
                                            !stateBoard.pictograms.isNotEmpty
                                                ? $colorButtonDisable
                                                : $colorSuccess,
                                        loadingColor: $colorBlueGeneral,
                                        duration: 2500,
                                        radius: 20,
                                        onConfirm: () async {
                                          if (stateProfile.permmisions!
                                              .contains(
                                                  $verifyActivityAnswer)) {
                                            if (stateBoard
                                                .pictograms.isNotEmpty) {
                                              String words = stateBoard
                                                  .pictograms
                                                  .map((item) => item.name)
                                                  .toList()
                                                  .join(' ');
                                              speak(words);
                                              Future.delayed(
                                                  const Duration(
                                                      milliseconds: 3000),
                                                  () {});
                                              if (await notifierBoard
                                                  .checkAnswer()) {
                                                notifierBoard
                                                    .clearPictogramSolution();
                                                notifierPictograms
                                                    .setPictogramsPatients();
                                                if (context.mounted) {
                                                  showToast(
                                                    context: context,
                                                    isError: false,
                                                  );
                                                }
                                              } else {
                                                if (context.mounted) {
                                                  showToast(
                                                    context: context,
                                                    isError: true,
                                                  );
                                                }
                                              }
                                            } else {
                                              toastAlert(
                                                iconAlert:
                                                    const Icon(Icons.info),
                                                context: context,
                                                title: S.current.Aviso,
                                                description: S.current
                                                    .Debe_seleccionar_al_menos_un_pictograma_para_la_solucion,
                                                typeAlert:
                                                    ToastificationType.info,
                                              );
                                            }
                                          } else {
                                            toastAlert(
                                              iconAlert: const Icon(Icons.info),
                                              context: context,
                                              title: S.current.No_autorizado,
                                              description: S.current
                                                  .No_cuenta_con_el_permiso_necesario,
                                              typeAlert:
                                                  ToastificationType.info,
                                            );
                                          }
                                        },
                                        strokeWidth: 10,
                                        width: 200,
                                        height: 43,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                  const ModalBarrier(
                    dismissible: false,
                    color: $colorTextWhite,
                  ),
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
          if (stateBoard.isCheking == true) ...[
            const Opacity(
              opacity: 0.5,
              child: ModalBarrier(dismissible: false, color: $colorTextBlack),
            ),
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
    );
  }
}

Widget buildDraggableExample({
  required PictogramAchievements pictogram,
  required bool isFilterBW,
  required Future<void> Function(String text) speak,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[
      LongPressDraggable<PictogramAchievements>(
        delay: const Duration(milliseconds: 150),
        data: pictogram,
        onDragStarted: () {
          speak(pictogram.name);
        },
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
          width: 125.0,
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  color: $colorTextWhite,
                  height: 125.0,
                  width: 125.0,
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
              Container(
                margin: const EdgeInsets.only(top: 5),
                child: Tooltip(
                  // Muestra el nombre completo
                  message: pictogram.name,
                  // Espera antes de mostrarse
                  waitDuration: const Duration(
                    milliseconds: 100,
                  ),
                  // Tiempo visible
                  showDuration: const Duration(
                    seconds: 2,
                  ),
                  child: Text(
                    pictogram.name,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
