import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/presentation/providers/providers.dart';
import 'package:hope_app/presentation/utils/utils.dart';

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
          context.replace(menuItem.url);
        },
        tilePadding: EdgeInsets.zero,
        indicatorShape: const BeveledRectangleBorder(),
        children: [
          DrawerHeader(
            padding: EdgeInsets.zero,
            child: Container(
                padding: const EdgeInsets.only(left: 17, right: 17, top: 10),
                color: $colorBackgroundHeaderDrawer,
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipOval(
                      child: Container(
                        width: 75,
                        height: 75,
                        decoration: const BoxDecoration(shape: BoxShape.circle),
                        child: Image.network(
                          'https://static.wixstatic.com/media/4d02c4_8ea3fe5159c8431689f97f5cc973e34c~mv2.png/v1/fill/w_600,h_338,al_c,q_85,usm_0.66_1.00_0.01,enc_auto/4d02c4_8ea3fe5159c8431689f97f5cc973e34c~mv2.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Mario Ramos',
                      style: TextStyle(color: $colorTextWhite, fontSize: 15),
                    ),
                    const Text('marioramosmejia2243@gmail.com',
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
                  context.pushReplacement('/');
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
