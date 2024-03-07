import 'package:flutter/material.dart';
import 'package:hope_app/presentation/interfaces/interface.dart';
import 'package:hope_app/presentation/utils/utils.dart';

const appMenuItems = <MenuItem>[
  MenuItem(
      title: $titleMenuChildren,
      subTitle: $subTitleMenuChildren,
      url: '/children',
      icon: Icons.face),
  MenuItem(
      title: $titleMenuActivity,
      subTitle: $subTitleMenuActivity,
      url: '/activity',
      icon: Icons.sports_esports),
  MenuItem(
      title: $titleMenuSettings,
      subTitle: $subTitleMenuSettings,
      url: '/settings',
      icon: Icons.settings),
];
