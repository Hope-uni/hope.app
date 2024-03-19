import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../interfaces/interface.dart';

class MenuItems extends StatelessWidget {
  final List<MenuItem> menuItems;
  const MenuItems({
    super.key,
    required this.menuItems,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        popUpAnimationStyle: AnimationStyle.noAnimation,
        icon: const Icon(Icons.more_vert),
        onSelected: (itemUrl) {
          context.push(itemUrl);
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
