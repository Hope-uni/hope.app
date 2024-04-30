import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/presentation/providers/providers.dart';
import 'package:hope_app/presentation/utils/utils.dart';
import 'package:hope_app/presentation/widgets/widgets.dart';

class SideMenu extends ConsumerWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedOpcion = ref.watch(selectedOption);
    return Stack(children: [
      NavigationDrawer(
        selectedIndex: selectedOpcion,
        onDestinationSelected: (value) {
          //Aqui se asigna el nuevo valor el index del menu y se redirecciona a la pantalla
          ref.read(selectedOption.notifier).state = value;
          final menuItem = appMenuItemsDrawer[value];
          context.replace(menuItem.url!);
        },
        tilePadding: EdgeInsets.zero,
        indicatorShape: const BeveledRectangleBorder(),
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/img/background-drawer-header.png'),
              ),
            ),
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            child: Container(
                padding: const EdgeInsets.only(top: 10, right: 17, left: 17),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipOval(
                      child: SizedBox(
                        width: 100,
                        height: 100,
                        child: ImageLoad(urlImage: '', isDoubleTap: false),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Mario Ramos', //TODO: Cambiar cuando este listo el endpoint
                      style: TextStyle(color: $colorTextWhite, fontSize: 15),
                    ),
                    Text(
                        'marioramosmejia2243@gmail.com', //TODO: Cambiar cuando este listo el endpoint
                        style: TextStyle(color: $colorTextWhite, fontSize: 10)),
                  ],
                )),
          ),
          ...appMenuItemsDrawer.sublist(0, appMenuItemsDrawer.length).map(
              (item) => NavigationDrawerDestination(
                  icon: Icon(item.icon), label: Text(item.title))),
          const SizedBox(
            height: 200,
          )
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
                onPressed: () {
                  //Se resetea el index del menu lateral
                  ref.read(selectedOption.notifier).state = 0;
                  ref.read(authProvider.notifier).logout();
                },
                icon: const Icon(
                  Icons.logout,
                  color: $colorTextAndIconFooterDrawer,
                ), // Cambia 'Icons.add' al icono que desees
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
                child: Text(S.current.Derechos_reservados)),
          ],
        ),
      ),
    ]);
  }
}
