import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hope_app/presentation/interfaces/interface.dart';
import 'package:hope_app/presentation/utils/utils.dart';

class MenuItems extends StatelessWidget {
  final List<MenuItem> menuItems;
  final int idChild;
  const MenuItems({
    super.key,
    required this.menuItems,
    required this.idChild,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        popUpAnimationStyle: AnimationStyle.noAnimation,
        icon: const Icon(Icons.more_vert),
        onSelected: (item) {
          final MenuItem menuItem = item;

          if (menuItem.url != null) {
            context.push(menuItem.url!, extra: idChild);
          } else {
            modalDialogConfirmation(
                onClic: () {},
                context: context,
                question: menuItem.modalMenu!.textDescription,
                titleButtonConfirm: menuItem.modalMenu!.titleButtonModal);
          }
        },
        itemBuilder: (BuildContext context) => <PopupMenuEntry>[
              ...menuItems.map(
                (value) => PopupMenuItem(
                  value: value,
                  child: ListTile(
                    leading: Icon(value.icon),
                    title: Text(value.title),
                  ),
                ),
              )
            ]);
  }
}
