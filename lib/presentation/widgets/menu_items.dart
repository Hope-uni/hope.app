import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../interfaces/interface.dart';

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
        onSelected: (itemUrl) {
          context.push(itemUrl, extra: idChild);
        },
        itemBuilder: (BuildContext context) => <PopupMenuEntry>[
              ...menuItems.map(
                (value) => PopupMenuItem(
                  value: value.url,
                  child: ListTile(
                    leading: Icon(
                      value.icon,
                    ),
                    title: Text(
                      value.title,
                    ),
                  ),
                ),
              )
            ]);
  }
}
