import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/presentation/providers/providers.dart';
import 'package:hope_app/presentation/utils/utils.dart';
import 'package:hope_app/presentation/widgets/widgets.dart';
import 'package:toastification/toastification.dart';

class ActivityPage extends ConsumerStatefulWidget {
  final int idActivity;
  const ActivityPage({super.key, required this.idActivity});

  @override
  ActivityPageState createState() => ActivityPageState();
}

class ActivityPageState extends ConsumerState<ActivityPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (mounted) {
        ref.read(activityProvider.notifier).resetState();
      }
    });
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();

    Future.microtask(() async {
      final stateActivity = ref.read(activityProvider);
      if (stateActivity.showActivity == null) {
        final notifierActivity = ref.read(activityProvider.notifier);
        await notifierActivity.getActivity(idActivity: widget.idActivity);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final stateWacthActivity = ref.watch(activityProvider);
    final notifierActivity = ref.read(activityProvider.notifier);

    ref.listen(activityProvider, (previous, next) {
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

    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.Actividad),
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
                              S.current.Para_ver_la_imagen_con_mas_detalle,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              S.current.Hacer_doble_clic_sobre_la_imagen,
                            ),
                            const SizedBox(height: 30),
                            Text(
                              S.current.Acciones_en_el_listado_de_pictogramas,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              S.current
                                  .Puede_desplazarse_de_manera_horizontal_en_los_pictogramas_para_poder_ver_mas_registros,
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
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Stack(
          children: [
            if (stateWacthActivity.showActivity != null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 25),
                      InputForm(
                        label: S.current.Nombre,
                        value: stateWacthActivity.showActivity!.name,
                        enable: false,
                        maxLength: 100,
                      ),
                      InputForm(
                        value: stateWacthActivity.showActivity!.description,
                        enable: false,
                        label: S.current.Descripcion,
                        linesDynamic: true,
                        maxLength: 250,
                      ),
                      InputForm(
                        value: stateWacthActivity.showActivity!.phase.name,
                        enable: false,
                        label: S.current.Fase_del_autismo,
                        maxLength: 250,
                      ),
                      InputForm(
                        value: stateWacthActivity
                            .showActivity!.satisfactoryPoints
                            .toString(),
                        enable: false,
                        label: S.current.Puntaje,
                        isNumber: true,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.only(
                            left: 17, right: 15, bottom: 20),
                        child: Text(S.current.Solucion,
                            style: const TextStyle(fontSize: 14.5)),
                      ),
                      InputForm(
                        value: stateWacthActivity.showActivity!.activitySolution
                            .map((item) => item.name)
                            .join(' ')
                            .toString(),
                        enable: false,
                        label: S.current.Oracion,
                        linesDynamic: true,
                      ),
                      ImageListVIew(
                        images:
                            stateWacthActivity.showActivity!.activitySolution,
                        backgroundDecoration: $colorPrimary50,
                        isDecoration: true,
                        isSelect: false,
                      ),
                      const SizedBox(height: 60),
                    ],
                  ),
                ),
              ),
            if (stateWacthActivity.isLoading == true) ...[
              const ModalBarrier(dismissible: false, color: $colorTextWhite),
              Center(
                child: stateWacthActivity.isErrorInitial == true
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
          ],
        ),
      ),
    );
  }
}
