import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hope_app/domain/domain.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/presentation/interfaces/interface.dart';
import 'package:hope_app/presentation/utils/utils.dart';

class MenuItems extends ConsumerStatefulWidget {
  final List<MenuItem> menuItems;
  final CatalogObject itemObject;
  const MenuItems({
    super.key,
    required this.menuItems,
    required this.itemObject,
  });

  @override
  MenuItemsState createState() => MenuItemsState();
}

class MenuItemsState extends ConsumerState<MenuItems> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        popUpAnimationStyle: AnimationStyle.noAnimation,
        icon: const Icon(
          Icons.more_vert,
          color: $colorBlueGeneral,
        ),
        tooltip: S.current.Opciones,
        onSelected: (item) {
          final MenuItem menuItem = item;
          menuItem.onClick(context: context, ref: ref, item: widget.itemObject);
        },
        itemBuilder: (BuildContext context) => <PopupMenuEntry>[
              ...widget.menuItems.map(
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
