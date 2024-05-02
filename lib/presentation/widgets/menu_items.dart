import 'package:flutter/material.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/presentation/interfaces/interface.dart';

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
        tooltip: S.current.Opciones,
        onSelected: (item) {
          final MenuItem menuItem = item;
          menuItem.onClick(context: context, idItem: idChild);
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
