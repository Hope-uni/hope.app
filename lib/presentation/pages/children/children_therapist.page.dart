import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hope_app/domain/domain.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/presentation/providers/providers.dart';
import 'package:hope_app/presentation/utils/utils.dart';
import 'package:hope_app/presentation/widgets/widgets.dart';
import 'package:toastification/toastification.dart';

class ChildrenTherapistPage extends ConsumerStatefulWidget {
  const ChildrenTherapistPage({super.key});

  @override
  ChildrenTherapistPageState createState() => ChildrenTherapistPageState();
}

class ChildrenTherapistPageState extends ConsumerState<ChildrenTherapistPage> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (mounted) {
        ref.read(childrenProvider.notifier).resetState();
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

      if (statechildren.paginateChildren[$indexPage]! == 1) {
        await notifierChildren.getChildrenTherapist();
      }

      scrollController.addListener(() async {
        final stateChildren = ref.read(childrenProvider);
        if ((scrollController.position.pixels + 50) >=
                scrollController.position.maxScrollExtent &&
            stateChildren.isLoading == false) {
          if (stateChildren.paginateChildren[$indexPage]! > 1 &&
              stateChildren.paginateChildren[$indexPage]! <=
                  stateChildren.paginateChildren[$pageCount]!) {
            await notifierChildren.getChildrenTherapist();
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
        ref.read(childrenProvider.notifier).updateResponse();
      }
    });

    return Scaffold(
      appBar: AppBar(title: Text(S.current.Ninos_asignados_Terapeuta)),
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
                  if (stateWacthChildren.paginateChildren[$indexPage] != 1)
                    SizedBox.expand(
                      child: stateWacthChildren.children.isNotEmpty
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
                                  iconButton: MenuItems(
                                    itemObject: CatalogObject(
                                      id: stateChildren.children[index].id,
                                      name: stateChildren
                                          .children[index].fullName,
                                      description: '',
                                    ),
                                    menuItems: menuPacientTherapist,
                                  ),
                                  onTap: () {
                                    context.pushNamed($child, pathParameters: {
                                      $idChild: stateChildren.children[index].id
                                          .toString()
                                    }, extra: {
                                      $isTutor: false
                                    });
                                  },
                                );
                              },
                            )
                          : SvgPicture.asset(
                              fit: BoxFit.contain,
                              'assets/svg/SinDatos.svg',
                            ),
                    ),
                  if (stateWacthChildren.isLoading == true &&
                      stateWacthChildren.paginateChildren[$indexPage] != 1)
                    const Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  // 🔄 LOADING
                  if (stateWacthChildren.paginateChildren[$indexPage] == 1) ...[
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
