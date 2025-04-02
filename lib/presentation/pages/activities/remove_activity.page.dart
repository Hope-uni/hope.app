import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/presentation/providers/providers.dart';
import 'package:hope_app/presentation/utils/utils.dart';
import 'package:hope_app/presentation/widgets/widgets.dart';
import 'package:toastification/toastification.dart';

class RemoveAcivityPage extends ConsumerStatefulWidget {
  final Map<String, dynamic>? nameActivity;
  final int idActivity;

  const RemoveAcivityPage({
    required this.nameActivity,
    required this.idActivity,
    super.key,
  });

  @override
  RemoveAcivityPageState createState() => RemoveAcivityPageState();
}

class RemoveAcivityPageState extends ConsumerState<RemoveAcivityPage> {
  final scrollController = ScrollController();

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();

    Future.microtask(() async {
      final notifierChildren = ref.read(childrenProvider.notifier);
      final statechildren = ref.read(childrenProvider);

      if (statechildren.paginateChildren[$indexPage]! == 1) {
        await notifierChildren.getChildrenTherapist(
          idActivity: widget.idActivity,
        );
      }

      scrollController.addListener(() async {
        final stateChildren = ref.read(childrenProvider);
        if ((scrollController.position.pixels + 50) >=
                scrollController.position.maxScrollExtent &&
            stateChildren.isLoading == false) {
          if (stateChildren.paginateChildren[$indexPage]! > 1 &&
              stateChildren.paginateChildren[$indexPage]! <=
                  stateChildren.paginateChildren[$pageCount]!) {
            await notifierChildren.getChildrenTherapist(
              idActivity: widget.idActivity,
            );
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final stateChildren = ref.watch(childrenProvider);
    final stateActivityChildren = ref.watch(activityChildrenProvider);

    final notifierChildren = ref.read(childrenProvider.notifier);
    final notifierActivityChildren =
        ref.read(activityChildrenProvider.notifier);

    final profileState = ref.read(profileProvider);

    ref.listen(activityChildrenProvider, (previous, next) {
      if (next.isLoading == false && next.isDelete == true) {
        if (context.mounted) {
          toastAlert(
            iconAlert: const Icon(Icons.delete),
            context: context,
            title: S.current.Actividad_desasignada_exitosamente,
            description: S.current.Se_removio_la_actividad_del_paciente,
            typeAlert: ToastificationType.success,
          );
          notifierActivityChildren.updateResponse();
        }
      }

      if (next.errorMessageApi != null) {
        toastAlert(
          context: context,
          title: S.current.Error,
          description: next.errorMessageApi!,
          typeAlert: ToastificationType.error,
        );
        notifierActivityChildren.updateResponse();
      }
    });

    return Scaffold(
      appBar: AppBar(title: Text(S.current.Quitar_asignacion_de_actividad)),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 7.5),
        child: Column(
          children: [
            const SizedBox(height: 25),
            InputForm(
              value: '',
              enable: true,
              label: S.current.Busqueda_por_nombre,
              marginBottom: 0,
              isSearch: true,
              //TODO: Implementar condicional con provider cuando este listo el endpoint
              suffixIcon: true
                  ? const Icon(
                      Icons.search,
                    )
                  : IconButton(onPressed: () {}, icon: const Icon(Icons.clear)),
            ),
            Expanded(
              child: Stack(
                children: [
                  if (stateChildren.paginateChildren[$indexPage] != 1)
                    SizedBox.expand(
                      child: stateChildren.children.isNotEmpty
                          ? ListView.builder(
                              controller: scrollController,
                              itemCount: stateChildren.children.length,
                              itemBuilder: (context, index) {
                                return ListTileCustom(
                                  title: stateChildren.children[index].fullName,
                                  colorTitle: true,
                                  styleTitle: FontWeight.bold,
                                  subTitle:
                                      '${stateChildren.children[index].age} ${S.current.Anos}\n${S.current.Fase}: ${stateChildren.children[index].currentPhase.name}',
                                  image: stateChildren.children[index].image,
                                  iconButton: IconButton(
                                    onPressed: () {
                                      //TODO: ACTUALIZAR PERMISOS CUANDO EN API ESTEN LISTOS
                                      if (profileState.permmisions!
                                          .contains($updatePatientTutor)) {
                                        modalDialogConfirmation(
                                          context: context,
                                          onClic: () async {
                                            if (await notifierActivityChildren
                                                .unassingActivity(
                                                    idChild: stateChildren
                                                        .children[index].id)) {
                                              notifierChildren
                                                  .removeChildTherapist(
                                                      stateChildren
                                                          .children[index]);
                                            }
                                            if (context.mounted) {
                                              Navigator.of(context).pop();
                                            }
                                          },
                                          question: RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text:
                                                      '${S.current.Esta_seguro_de_quitarle_la_actividad(widget.nameActivity!['nameActivity'])}\n\n',
                                                  style: const TextStyle(
                                                    color: $colorTextBlack,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text:
                                                      '${S.current.Al_paiente}: ',
                                                  style: const TextStyle(
                                                    color: $colorTextBlack,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: stateChildren
                                                      .children[index].fullName,
                                                  style: const TextStyle(
                                                    color: $colorTextBlack,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          titleButtonConfirm:
                                              S.current.Si_Quitar,
                                        );
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
                                    icon: const Icon(
                                      Icons.delete,
                                      color: $colorError,
                                    ),
                                  ),
                                );
                              },
                            )
                          : SvgPicture.asset(
                              fit: BoxFit.contain,
                              'assets/svg/SinDatos.svg',
                            ),
                    ),
                  if (stateChildren.isLoading == true &&
                      stateChildren.paginateChildren[$indexPage] != 1)
                    const Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  // 🔄 LOADING
                  if (stateChildren.paginateChildren[$indexPage] == 1) ...[
                    const Opacity(
                      opacity: 0.5,
                      child: ModalBarrier(
                          dismissible: false, color: $colorTransparent),
                    ),
                    Center(
                      child: stateChildren.isErrorInitial == true
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

                  if (stateActivityChildren.isLoading == true) ...[
                    const Opacity(
                      opacity: 0.5,
                      child: ModalBarrier(
                          dismissible: false, color: $colorTransparent),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
