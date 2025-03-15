import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/presentation/providers/providers.dart';
import 'package:hope_app/presentation/utils/utils.dart';
import 'package:hope_app/presentation/widgets/widgets.dart';

class ActivityPage extends ConsumerStatefulWidget {
  final int idItem;
  const ActivityPage({super.key, required this.idItem});

  @override
  ActivityPageState createState() => ActivityPageState();
}

class ActivityPageState extends ConsumerState<ActivityPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();

    Future.microtask(() async {
      final stateActivity = ref.read(activityProvider);
      if (stateActivity.showActivity == null) {
        final notifierActivity = ref.read(activityProvider.notifier);
        await notifierActivity.getActivity(idActivity: widget.idItem);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final stateWacthActivity = ref.watch(activityProvider);

    return Scaffold(
      appBar: AppBar(title: Text(S.current.Actividad)),
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
          ],
        ),
      ),
      floatingActionButton: ButtonTextIcon(
        title: S.current.Salir,
        icon: const Icon(Icons.cancel),
        buttonColor: $colorError,
        onClic: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
