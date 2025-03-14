import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hope_app/domain/domain.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/presentation/providers/providers.dart';
import 'package:hope_app/presentation/utils/utils.dart';
import 'package:hope_app/presentation/widgets/widgets.dart';
import 'package:toastification/toastification.dart';

class FormActivity extends ConsumerStatefulWidget {
  const FormActivity({super.key});

  @override
  FormActivityState createState() => FormActivityState();
}

class FormActivityState extends ConsumerState<FormActivity> {
  final scrollController = ScrollController();

  final List<PictogramAchievements> selectedPictogram = [];
  String textSolution = '';

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (mounted) {
        ref.read(activityProvider.notifier).updateErrorMessage();
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
      final notifierPhases = ref.read(phasesProvider.notifier);
      final notifierPictograms = ref.read(pictogramsProvider.notifier);
      final statePictograms = ref.read(pictogramsProvider);

      if (statePictograms.paginatePictograms[$indexPage]! == 1) {
        await notifierPictograms.getPictograms();
      }

      await notifierPhases.getPhases();
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

  void onPictogramSelected(PictogramAchievements pictogram) {
    setState(() {
      FocusManager.instance.primaryFocus?.unfocus();
      selectedPictogram.add(pictogram);
      textSolution =
          selectedPictogram.map((item) => item.name).toList().join(' ');

      ref.read(activityProvider.notifier).updateActivityField(
          $pictogramSentence,
          selectedPictogram.map((item) => item.id.toString()).join(','));
    });
  }

  void deletePictogramSelected(PictogramAchievements pictogram) {
    setState(() {
      FocusManager.instance.primaryFocus?.unfocus();
      selectedPictogram.remove(pictogram);
      textSolution =
          selectedPictogram.map((item) => item.name).toList().join(' ');

      ref.read(activityProvider.notifier).updateActivityField(
          $pictogramSentence,
          selectedPictogram.map((item) => item.id.toString()).join(','));
    });
  }

  void onChangeOrderSolution(int indexOld, int indexNew) {
    setState(() {
      final pictogram = selectedPictogram[indexOld];
      if (indexOld < indexNew) {
        indexNew -= 1;
      }

      selectedPictogram.removeAt(indexOld);
      selectedPictogram.insert(indexNew, pictogram);

      textSolution =
          selectedPictogram.map((item) => item.name).toList().join(' ');
    });
  }

  final Map<String, FocusNode> focusNodes = {
    $name: FocusNode(),
    $description: FocusNode(),
    $satisfactoryPoints: FocusNode(),
    $phaseId: FocusNode(),
    $pictogramSentence: FocusNode(),
  };

  @override
  Widget build(BuildContext context) {
    final stateWacthActivity = ref.watch(activityProvider);
    final notifierActivity = ref.read(activityProvider.notifier);
    final statePictograms = ref.watch(pictogramsProvider);
    final statePhases = ref.watch(phasesProvider);

    ref.listen(activityProvider, (previous, next) {
      if (next.validationErrors.isNotEmpty && next.isSave == true) {
        String firstErrorKey = next.validationErrors.keys.first;
        focusNodes[firstErrorKey]?.requestFocus();

        Scrollable.ensureVisible(
          focusNodes[firstErrorKey]!.context!,
          duration: const Duration(milliseconds: 1000),
          curve: Curves.easeInOut,
          alignment: 0.5, // Opcional: Para centrar el widget en la pantalla
        );
      }

      if (next.isLoading == false && next.showtoastAlert == true) {
        if (context.mounted) {
          toastAlert(
            iconAlert: const Icon(Icons.check),
            context: context,
            title: S.current.Guardado_con_exito,
            description: S.current.La_actividad_se_guardo_correctamente,
            typeAlert: ToastificationType.success,
          );

          notifierActivity.updateErrorMessage();
        }
      }

      if (next.errorMessageApi != null) {
        toastAlert(
          context: context,
          title: S.current.Error,
          description: next.errorMessageApi!,
          typeAlert: ToastificationType.error,
        );
        notifierActivity.updateErrorMessage();
      }
    });

    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 25),
                Focus(
                  focusNode: focusNodes[$name],
                  child: InputForm(
                    label: S.current.Nombre,
                    value: stateWacthActivity.activity!.name,
                    enable: true,
                    maxLength: 100,
                    onChanged: (value) {
                      notifierActivity.updateActivityField($name, value);
                    },
                    errorText: stateWacthActivity.validationErrors[$name],
                  ),
                ),
                Focus(
                  focusNode: focusNodes[$description],
                  child: InputForm(
                    value: stateWacthActivity.activity!.description,
                    enable: true,
                    label: S.current.Descripcion,
                    linesDynamic: true,
                    maxLength: 250,
                    onChanged: (value) {
                      notifierActivity.updateActivityField($description, value);
                    },
                    errorText:
                        stateWacthActivity.validationErrors[$description],
                  ),
                ),
                Focus(
                  focusNode: focusNodes[$phaseId],
                  child: SelectBox(
                    listItems: statePhases.phases
                        .map((item) => CatalogObject(
                            id: item.id, name: item.name, description: ''))
                        .toList(),
                    enable: true,
                    label: S.current.Fase_del_autismo,
                    errorText: stateWacthActivity.validationErrors[$phaseId],
                    onSelected: (value) {
                      setState(() {
                        FocusManager.instance.primaryFocus?.unfocus();
                      });
                      notifierActivity.updateActivityField($phaseId, value!);
                    },
                  ),
                ),
                Focus(
                  focusNode: focusNodes[$satisfactoryPoints],
                  child: InputForm(
                    value: stateWacthActivity.activity!.satisfactoryPoints == 0
                        ? ''
                        : stateWacthActivity.activity!.satisfactoryPoints
                            .toString(),
                    enable: true,
                    label: S.current.Puntaje,
                    isNumber: true,
                    onChanged: (value) {
                      notifierActivity.updateActivityField(
                          $satisfactoryPoints, value);
                    },
                    errorText: stateWacthActivity
                        .validationErrors[$satisfactoryPoints],
                  ),
                ),
                Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.only(
                        left: 17,
                        right: 15,
                        bottom: 20,
                      ),
                      child: Text(
                        S.current.Seleccione_pictogramas_de_la_solucion,
                        style: const TextStyle(fontSize: 14.5),
                      ),
                    ),
                    SelectBox(
                      label: S.current.Categoria_de_pictogramas,
                      enable: true,
                      onSelected: (value) {},
                      listItems: statePictograms.categoryPictograms
                          .map((item) => CatalogObject(
                              id: item.id, name: item.name, description: ''))
                          .toList(),
                    ),
                    InputForm(
                      isSearch: true,
                      label: S.current.Busqueda_por_nombre,
                      value: '',
                      enable: true,
                      onChanged: (value) {},
                    ),
                    ImageListVIew(
                      images: statePictograms.pictograms,
                      isDecoration: true,
                      isSelect: true,
                      controller: scrollController,
                      backgroundColorIcon: $colorSuccess,
                      iconSelect: const Icon(Icons.check),
                      onPressed: onPictogramSelected,
                    ),
                    const SizedBox(height: 14.5),
                  ],
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin:
                      const EdgeInsets.only(left: 17, right: 15, bottom: 20),
                  child: Text(S.current.Solucion,
                      style: const TextStyle(fontSize: 14.5)),
                ),
                InputForm(
                  value: textSolution,
                  enable: false,
                  readOnly: true,
                  label: S.current.Oracion,
                  linesDynamic: true,
                  errorText:
                      stateWacthActivity.validationErrors[$pictogramSentence],
                ),
                Focus(
                  focusNode: focusNodes[$pictogramSentence],
                  child: ImageListVIew(
                    images: selectedPictogram,
                    backgroundDecoration: $colorPrimary50,
                    isDecoration: true,
                    isSelect: true,
                    backgroundColorIcon: $colorError,
                    iconSelect: const Icon(Icons.delete),
                    onPressed: deletePictogramSelected,
                    isReorder: true,
                    onReorder: onChangeOrderSolution,
                  ),
                ),
                const SizedBox(height: 60),
              ],
            ),
          ),
        ),
        if (statePictograms.paginatePictograms[$indexPage] == 1 ||
            statePhases.isLoading == true) ...[
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
        if (stateWacthActivity.isLoading == true) ...[
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
    );
  }
}
