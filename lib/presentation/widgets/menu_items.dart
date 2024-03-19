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
        color: Colors.white, //Color.fromARGB(255, 147, 143, 143),
        popUpAnimationStyle: AnimationStyle.noAnimation,
        icon: const Icon(Icons.more_vert),
        onSelected: (itemUrl) {
          context.go(itemUrl);
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
