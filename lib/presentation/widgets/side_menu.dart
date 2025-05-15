import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/presentation/interfaces/interface.dart';
import 'package:hope_app/presentation/providers/providers.dart';
import 'package:hope_app/presentation/utils/utils.dart';
import 'package:hope_app/presentation/widgets/widgets.dart';

class SideMenu extends ConsumerWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final DateTime dateNow = DateTime.now();
    final selectedOpcion = ref.watch(selectedOption);
    final profileState = ref.watch(profileProvider);

    if (profileState.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    final List<MenuItem> menuPermmisions;
    if (profileState.permmisions == null) {
      menuPermmisions = [];
    } else {
      final menuPermmision = appMenuItemsDrawer
          .where((item) => profileState.permmisions!.contains(item.permission))
          .toList();

      final menuPermmisionRoles = menuPermmision
          .where((item) => profileState.roles!
              .any((element) => item.roles.contains(element)))
          .toList();

      menuPermmisions = menuPermmisionRoles;
    }

    final size = MediaQuery.of(context).size;

    return Stack(children: [
      NavigationDrawer(
        backgroundColor: $colorBlueGeneral,
        selectedIndex: selectedOpcion,
        onDestinationSelected: (value) {
          //Aqui se asigna el nuevo valor el index del menu y se redirecciona a la pantalla
          ref.read(selectedOption.notifier).state = value;
          final menuItem = menuPermmisions[value];
          menuItem.onClick(context: context, ref: ref);
        },
        tilePadding: EdgeInsets.zero,
        indicatorShape: const BeveledRectangleBorder(),
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage($backgroundDrawerheader),
              ),
            ),
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            child: Container(
                padding: const EdgeInsets.only(top: 10, right: 17, left: 17),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipOval(
                      child: SizedBox(
                        width: 100,
                        height: 100,
                        child: ImageLoad(
                          urlImage: profileState.profile!.imageUrl ?? '',
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      profileState.userName ?? '',
                      style:
                          const TextStyle(color: $colorTextWhite, fontSize: 15),
                    ),
                    Text(profileState.email ?? '',
                        style: const TextStyle(
                            color: $colorTextWhite, fontSize: 10)),
                  ],
                )),
          ),
          ...menuPermmisions.map(
            (item) => NavigationDrawerDestination(
              backgroundColor: $colorBackgroundDrawer,
              icon: Icon(item.icon),
              label: Text(item.title),
            ),
          ),
          Container(
            height: size.height / 1.5,
            color: $colorBackgroundDrawer,
          ),
        ],
      ),
      Positioned(
        left: 0,
        right: 0,
        bottom: 0,
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                //Si se cambia del $colorScheme se tiene que cambiar aqui al mismo
                color: $colorBackgroundDrawer,
                border: Border(
                  top: BorderSide(
                    color: $colorBorderFooterDrawer,
                    width: 2.0,
                  ),
                ),
              ),
              padding: const EdgeInsets.only(left: 7),
              width: double.infinity,
              child: TextButton.icon(
                style: const ButtonStyle(
                  alignment: Alignment.centerLeft,
                ),
                onPressed: () async {
                  //Se resetea el index del menu lateral
                  ref.read(selectedOption.notifier).state = 0;
                  await ref.read(authProvider.notifier).logout();
                },
                icon: const Icon(
                  Icons.logout,
                  color: $colorTextAndIconFooterDrawer,
                ),
                label: Text(
                  S.current.Cerrar_sesion,
                  style: const TextStyle(color: $colorTextAndIconFooterDrawer),
                ),
              ),
            ),
            Container(
              color: $colorBackgroundDrawer,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(15),
              child: Text(
                S.current.Derechos_reservados(dateNow.year),
              ),
            ),
          ],
        ),
      ),
    ]);
  }
}
