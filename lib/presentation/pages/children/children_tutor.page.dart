import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hope_app/domain/domain.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/presentation/providers/providers.dart';
import 'package:hope_app/presentation/utils/utils.dart';
import 'package:hope_app/presentation/widgets/widgets.dart';
import 'package:toastification/toastification.dart';

class ChildrenTutorPage extends ConsumerStatefulWidget {
  const ChildrenTutorPage({super.key});

  @override
  ChildrenTutorPageState createState() => ChildrenTutorPageState();
}

class ChildrenTutorPageState extends ConsumerState<ChildrenTutorPage> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (mounted) {
        ref.read(childrenProvider.notifier).resetIsErrorInitial();
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
      final notifierChildren = ref.read(childrenProvider.notifier);
      final statechildren = ref.read(childrenProvider);

      if (statechildren.paginateTutor[$indexPage]! == 1) {
        await notifierChildren.getChildrenTutor();
      }

      scrollController.addListener(() async {
        final stateChildren = ref.read(childrenProvider);
        if ((scrollController.position.pixels + 50) >=
                scrollController.position.maxScrollExtent &&
            stateChildren.isLoading == false) {
          if (stateChildren.paginateTutor[$indexPage]! > 1 &&
              stateChildren.paginateTutor[$indexPage]! <=
                  stateChildren.paginateTutor[$pageCount]!) {
            await notifierChildren.getChildrenTutor();
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final searchsPatients = ref.watch(searchPatients);

    final stateChildren = ref.read(childrenProvider);
    final stateWacthChildren = ref.watch(childrenProvider);

    ref.listen(childrenProvider, (previous, next) {
      if (next.errorMessageApi != null) {
        toastAlert(
          context: context,
          title: S.current.Error,
          description: next.errorMessageApi!,
          typeAlert: ToastificationType.error,
        );
        ref.read(childrenProvider.notifier).updateErrorMessage();
      }
    });

    return Scaffold(
      appBar: AppBar(title: Text(S.current.Ninos_asignados_Tutor)),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 7.5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 20),
            InputForm(
              value: searchsPatients,
              enable: true,
              label: S.current.Buscar_por_primer_nombre,
              marginBottom: 0,
              onChanged: (value) =>
                  ref.read(searchPatients.notifier).state = value,
              isSearch: true,
              suffixIcon: searchsPatients.isEmpty
                  ? const Icon(
                      Icons.search,
                    )
                  : IconButton(
                      onPressed: () {
                        ref.read(searchPatients.notifier).state = '';
                      },
                      icon: const Icon(Icons.clear),
                    ),
            ),
            Expanded(
              child: Stack(
                children: [
                  if (stateWacthChildren.paginateTutor[$indexPage] != 1)
                    SizedBox.expand(
                      child: stateWacthChildren.childrenTutor.isNotEmpty
                          ? ListView.builder(
                              controller: scrollController,
                              itemCount: stateChildren.childrenTutor.length,
                              itemBuilder: (context, index) {
                                return ListTileCustom(
                                  title: stateChildren
                                      .childrenTutor[index].fullName,
                                  colorTitle: true,
                                  styleTitle: FontWeight.bold,
                                  subTitle:
                                      '${stateChildren.childrenTutor[index].age} ${S.current.Anos}\n${S.current.Fase}: ${stateChildren.childrenTutor[index].currentPhase.name} ',
                                  image:
                                      stateChildren.childrenTutor[index].image,
                                  iconButton: MenuItems(
                                    itemObject: CatalogObject(
                                      id: stateChildren.childrenTutor[index].id,
                                      name: stateChildren
                                          .childrenTutor[index].fullName,
                                      description: "",
                                    ),
                                    menuItems: menuPacientTutor,
                                  ),
                                );
                              },
                            )
                          : SvgPicture.asset(
                              fit: BoxFit.contain,
                              'assets/svg/SinDatos.svg',
                            ),
                    ),
                  if (stateWacthChildren.isLoading == true &&
                      stateWacthChildren.paginateTutor[$indexPage]! != 1)
                    const Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  // 🔄 LOADING
                  if (stateWacthChildren.paginateTutor[$indexPage]! == 1) ...[
                    const Opacity(
                      opacity: 0.5,
                      child: ModalBarrier(
                          dismissible: false, color: $colorTransparent),
                    ),
                    Center(
                      child: stateWacthChildren.isErrorInitial == true
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
          ],
        ),
      ),
      drawer: const SideMenu(),
    );
  }
}
