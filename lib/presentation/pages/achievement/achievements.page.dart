import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hope_app/domain/domain.dart'
    show CatalogObject, PictogramAchievements;
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/presentation/providers/providers.dart';
import 'package:hope_app/presentation/utils/utils.dart';
import 'package:hope_app/presentation/widgets/widgets.dart';
import 'package:toastification/toastification.dart';

class AchievementPage extends ConsumerStatefulWidget {
  final int idChild;
  final Map<String, dynamic>? extra;

  const AchievementPage({
    super.key,
    required this.idChild,
    required this.extra,
  });

  @override
  AchievementPageState createState() => AchievementPageState();
}

class AchievementPageState extends ConsumerState<AchievementPage> {
  final scrollController = ScrollController();

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    Future.microtask(() async {
      final notifierAchievement = ref.read(achievementProvider.notifier);
      notifierAchievement.getAchievements(idPatient: widget.idChild);

      scrollController.addListener(() async {
        final statePictograms = ref.read(achievementProvider);

        if ((scrollController.position.pixels + 50) >=
                scrollController.position.maxScrollExtent &&
            statePictograms.isLoading == false) {
          if (statePictograms.paginateAchievement[$indexPage]! > 1 &&
              statePictograms.paginateAchievement[$indexPage]! <=
                  statePictograms.paginateAchievement[$pageCount]!) {
            await notifierAchievement.getAchievements(
              idPatient: widget.idChild,
            );
          }
        }
      });
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final stateAchievement = ref.watch(achievementProvider);
    final notifierAchievement = ref.read(achievementProvider.notifier);

    ref.listen(achievementProvider, (previous, next) {
      if (next.isComplete == true) {
        toastAlert(
          context: context,
          title: S.current.Asignacion_exitosa,
          description: S.current.Se_asigno_el_logro_correctamente_al_paciente,
          typeAlert: ToastificationType.success,
        );
        notifierAchievement.updateResponse();
      }
      if (next.errorMessageApi != null) {
        toastAlert(
          context: context,
          title: S.current.Error,
          description: next.errorMessageApi!,
          typeAlert: ToastificationType.error,
        );
        notifierAchievement.updateResponse();
      }
    });

    return Scaffold(
        appBar: AppBar(
          title: Text(S.current.Logros_disponibles_paciente),
          actions: [
            Container(
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
                        content: SizedBox(
                          width: 200,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                S.current
                                    .Si_el_nombre_del_logro_no_se_muestra_completo_puede,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                S.current
                                    .Mantener_el_dedo_sobre_el_nombre_durante_1_segundo_para_verlo_completo,
                              ),
                              const SizedBox(height: 30),
                              Text(
                                S.current.Para_ver_la_imagen_con_mas_detalle,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                S.current.Hacer_doble_clic_sobre_la_imagen,
                              ),
                              const SizedBox(height: 30),
                              Text(
                                S.current.Para_asignar_un_logro,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                S.current
                                    .Dar_clic_en_el_icono_de_ubicado_debajo_de_la_imagen_del_logro,
                              ),
                            ],
                          ),
                        ),
                        insetPadding: EdgeInsets.zero,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
        body: Stack(
          children: [
            if (stateAchievement.paginateAchievement[$indexPage] != 1)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: stateAchievement.achievement.isNotEmpty
                    ? GridView.builder(
                        controller: scrollController,
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 150,
                          childAspectRatio: 0.6,
                        ),
                        itemCount: stateAchievement.achievement.length,
                        itemBuilder: (context, index) {
                          return _ImageGrid(
                            pictogram: stateAchievement.achievement[index],
                            ref: ref,
                            childData: CatalogObject(
                              id: widget.idChild,
                              name: widget.extra![$nameChild],
                              description: '',
                            ),
                          );
                        },
                      )
                    : SvgPicture.asset(fit: BoxFit.contain, $noData),
              ),
            if (stateAchievement.isLoading == true &&
                stateAchievement.paginateAchievement[$indexPage]! != 1)
              const Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: CircularProgressIndicator(),
                ),
              ),
            // 🔄 LOADING
            if (stateAchievement.paginateAchievement[$indexPage]! == 1) ...[
              const Opacity(
                opacity: 0.5,
                child:
                    ModalBarrier(dismissible: false, color: $colorTransparent),
              ),
              Center(
                child: stateAchievement.isErrorInitial == true
                    ? SvgPicture.asset(fit: BoxFit.contain, $noData)
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
            if (stateAchievement.isAssign == true) ...[
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
        ));
  }
}

class _ImageGrid extends StatelessWidget {
  final PictogramAchievements pictogram;
  final WidgetRef ref;
  final CatalogObject childData;

  const _ImageGrid({
    required this.pictogram,
    required this.childData,
    required this.ref,
  });

  @override
  Widget build(BuildContext context) {
    final profileState = ref.read(profileProvider);
    final notifierAchievement = ref.read(achievementProvider.notifier);

    return Column(
      children: [
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
              child: Consumer(
                builder: (context, ref, child) {
                  return IconButton(
                    tooltip: S.current.Asignar_Logro,
                    onPressed: () {
                      if (profileState.permmisions!
                          .contains($assignAchievement)) {
                        modalDialogConfirmation(
                          context: context,
                          question: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text:
                                      '${S.current.Esta_seguro_de_asignar_el_logro_al_paciente(pictogram.name)}\n\n',
                                  style: const TextStyle(
                                      fontSize: 14, color: $colorTextBlack),
                                ),
                                TextSpan(
                                  text: childData.name,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: $colorTextBlack,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          ),
                          titleButtonConfirm: S.current.Si_asignar,
                          onClic: () async {
                            if (context.mounted) {
                              Navigator.of(context).pop();
                              await notifierAchievement.assignAchievement(
                                achievementId: pictogram.id,
                                idPatient: childData.id,
                              );
                            }
                          },
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
                    icon: const Icon(Icons.add, color: $colorSuccess),
                  );
                },
              ),
            )
          ],
        )
      ],
    );
  }
}
