import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/presentation/providers/providers.dart';
import 'package:hope_app/presentation/utils/utils.dart';
import 'package:hope_app/presentation/widgets/widgets.dart';

class ChildrenPage extends ConsumerStatefulWidget {
  const ChildrenPage({super.key});

  @override
  ChildrenPageState createState() => ChildrenPageState();
}

class ChildrenPageState extends ConsumerState<ChildrenPage> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    final activities = ref.read(patientsProvider.notifier);
    scrollController.addListener(() {
      if ((scrollController.position.pixels + 150) >=
          scrollController.position.maxScrollExtent) {
        activities.getNextPatients();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchsPatients = ref.watch(searchPatients);
    final listPatients = ref.watch(patientsProvider);
    final TextEditingController controller =
        TextEditingController(text: searchsPatients);
    final textLength = controller.value.text.length;
    controller.selection = TextSelection.collapsed(offset: textLength);

    return Scaffold(
      appBar: AppBar(title: Text(S.current.Ninos_asignados)),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 7.5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 20),
            InputForm(
              value: searchsPatients,
              enable: true,
              //TODO: Crear variable Intl
              label: 'Buscar por primer nombre',
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
              child: ListView.builder(
                controller: scrollController,
                //TODO: Cambiar cuando este listo el endpoint
                itemCount: listPatients.totalPatients.length + 1,
                itemBuilder: (context, index) {
                  //TODO: Cambiar el 14 cuando este listo el endpoint
                  if (index < listPatients.totalPatients.length) {
                    return ListTileCustom(
                      //TODO: Cambiar cuando este listo el endpoint
                      title: 'Mario Jose Ramos Mejia',
                      //TODO: Cambiar cuando este listo el endpoint
                      subTitle: 'Fase 4 | 20 años',
                      //TODO: Cambiar cuando este listo el endpoint
                      image: '',
                      //TODO: Cambiar cuando este listo el endpoint
                      iconButton: MenuItems(
                        idChild:
                            int.parse(listPatients.totalPatients[index].id),
                        menuItems: menuPacientTutor,
                      ),
                    );
                  } else {
                    return const SizedBox(height: 75);
                  }
                },
              ),
            )
          ],
        ),
      ),
      drawer: const SideMenu(),
    );
  }
}
