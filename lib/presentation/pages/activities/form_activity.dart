import 'package:clearable_dropdown/clearable_dropdown.dart' as clearable;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hope_app/domain/domain.dart' show PictogramAchievements;
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
  final TextEditingController searchController = TextEditingController();
  String? namePicto;
  int? idCategory;
  bool isFirst = true;

  List<PictogramAchievements> selectedPictogram = [];
  String textSolution = '';
  bool showErrorPermission = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (mounted) {
        ref.read(activityProvider.notifier).updateResponse();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    searchController.dispose();
    super.dispose();
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();

    Future.microtask(() async {
      final notifierPhases = ref.read(phasesProvider.notifier);
      final notifierPictograms = ref.read(pictogramsProvider.notifier);
      final statePictograms = ref.read(pictogramsProvider);
      final profileState = ref.watch(profileProvider);

      if (statePictograms.paginatePictograms[$indexPage]! == 1) {
        await notifierPictograms.getPictograms();
      }

      await notifierPhases.getPhases(
          isPermission: profileState.permmisions!.contains($listPhase));

      scrollController.addListener(() async {
        final statePictograms = ref.read(pictogramsProvider);

        if ((scrollController.position.pixels + 50) >=
                scrollController.position.maxScrollExtent &&
            statePictograms.isLoading == false) {
          if (statePictograms.paginatePictograms[$indexPage]! > 1 &&
              statePictograms.paginatePictograms[$indexPage]! <=
                  statePictograms.paginatePictograms[$pageCount]!) {
            await notifierPictograms.getPictograms(
              namePictogram: namePicto,
              idCategory: idCategory,
            );
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
            fieldName: $pictogramSentence,
            newValue:
                selectedPictogram.map((item) => item.id.toString()).join(','),
          );
    });
  }

  void deletePictogramSelected(PictogramAchievements pictogram) {
    setState(() {
      FocusManager.instance.primaryFocus?.unfocus();
      int index =
          selectedPictogram.indexWhere((item) => item.id == pictogram.id);
      if (index < 0) return;
      selectedPictogram.removeAt(index);
      textSolution =
          selectedPictogram.map((item) => item.name).toList().join(' ');

      ref.read(activityProvider.notifier).updateActivityField(
            fieldName: $pictogramSentence,
            newValue:
                selectedPictogram.map((item) => item.id.toString()).join(','),
          );
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
    final profileState = ref.watch(profileProvider);
    final notifierPictograms = ref.read(pictogramsProvider.notifier);

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
        toastAlert(
          iconAlert: const Icon(Icons.check),
          context: context,
          title: S.current.Guardado_con_exito,
          description: S.current.La_actividad_se_guardo_correctamente,
          typeAlert: ToastificationType.success,
        );
        notifierActivity.updateResponse();
        ref.read(activitiesProvider.notifier).resetState();
        ref.read(activitiesProvider.notifier).getActivities();
      }

      if (next.errorMessageApi != null) {
        toastAlert(
          context: context,
          title: S.current.Error,
          description: next.errorMessageApi!,
          typeAlert: ToastificationType.error,
        );
        notifierActivity.updateResponse();
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!profileState.permmisions!.contains($listPhase) &&
          showErrorPermission == false) {
        toastAlert(
          iconAlert: const Icon(Icons.error),
          context: context,
          title: S.current.Error,
          description:
              S.current.No_tiene_permiso_para_listar_las_fases_del_autismo,
          typeAlert: ToastificationType.error,
        );
        showErrorPermission = true;
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
                      notifierActivity.updateActivityField(
                        fieldName: $name,
                        newValue: value,
                      );
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
                      notifierActivity.updateActivityField(
                        fieldName: $description,
                        newValue: value,
                      );
                    },
                    errorText:
                        stateWacthActivity.validationErrors[$description],
                  ),
                ),
                clearable.ClearableDropdown(
                  helperText: ' ',
                  focus: focusNodes[$phaseId],
                  listItems: statePhases.phases
                      .map((item) =>
                          clearable.CatalogObject(id: item.id, name: item.name))
                      .toList(),
                  label: S.current.Fase_del_autismo,
                  colorLabel: stateWacthActivity.activity!.phaseId != 0
                      ? $colorTextBlack
                      : $hintColorInput,
                  errorText: stateWacthActivity.validationErrors[$phaseId],
                  onSelected: (value) {
                    setState(() {
                      FocusManager.instance.primaryFocus?.unfocus();
                    });
                    notifierActivity.updateActivityField(
                      fieldName: $phaseId,
                      newValue: value!,
                    );
                  },
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
                    maxLength: 2,
                    onChanged: (value) {
                      notifierActivity.updateActivityField(
                        fieldName: $satisfactoryPoints,
                        newValue: value,
                      );
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
                    clearable.ClearableDropdown(
                      helperText: ' ',
                      listItems: statePictograms.categoryPictograms
                          .map(
                            (item) => clearable.CatalogObject(
                              id: item.id,
                              name: item.name,
                            ),
                          )
                          .toList(),
                      label: S.current.Categoria_de_pictogramas,
                      colorLabel: idCategory != null
                          ? $colorTextBlack
                          : $hintColorInput,
                      onSelected: (value) async {
                        isFirst = false;
                        await notifierPictograms.getPictograms(
                          idCategory: int.parse(value!),
                        );
                        idCategory = int.parse(value);
                      },
                      onDeleteSelection: () {
                        idCategory = null;
                        notifierPictograms.resetFilters(
                          namePictogram: namePicto,
                          isCustom: false,
                          idChild: null,
                        );
                      },
                    ),
                    InputForm(
                      hint: S.current.Busqueda_por_nombre,
                      value: '',
                      controllerExt: searchController,
                      enable: true,
                      onSearch: () async {
                        await notifierPictograms.getPictograms(
                          namePictogram: namePicto,
                          idCategory: idCategory,
                        );
                      },
                      suffixIcon: searchController.text.isNotEmpty
                          ? GestureDetector(
                              onTap: () {
                                namePicto = null;
                                searchController.clear();
                                notifierPictograms.resetFilters(
                                  namePictogram: null,
                                  isCustom: false,
                                  idChild: null,
                                );
                              },
                              child: Container(
                                margin: const EdgeInsets.only(right: 10),
                                child: const Icon(Icons.clear),
                              ),
                            )
                          : null,
                      onChanged: (String value) {
                        isFirst = false;
                        namePicto = value.isNotEmpty ? value : null;
                      },
                    ),
                    (isFirst == false &&
                            statePictograms.paginatePictograms[$indexPage] ==
                                1 &&
                            statePictograms.isLoading == true)
                        ? Container(
                            margin: const EdgeInsets.only(
                                left: 15, right: 15, bottom: 12.5),
                            decoration: BoxDecoration(
                              color: $colorSuccess100,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(width: 0.5),
                            ),
                            width: double.infinity,
                            height: 150,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
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
                          )
                        : ImageListVIew(
                            images: statePictograms.pictograms,
                            newImages: selectedPictogram,
                            isDecoration: true,
                            isShowSvg: true,
                            isSelect: true,
                            controller: scrollController,
                            onTap: onPictogramSelected,
                            isTap: true,
                            onPressed: deletePictogramSelected,
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
                    newImages: selectedPictogram,
                    backgroundDecoration: $colorPrimary50,
                    isDecoration: true,
                    isSelect: true,
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
        if (isFirst == true &&
                statePictograms.paginatePictograms[$indexPage] == 1 ||
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
      ],
    );
  }
}
