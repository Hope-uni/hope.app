import 'package:flutter/material.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/presentation/interfaces/interface.dart';

final appMenuItems = <MenuItem>[
  MenuItem(
      title: S.current.Ninos,
      subTitle: S.current.Ninos_asignados,
      url: '/children',
      icon: Icons.face),
  MenuItem(
      title: S.current.Actividades,
      subTitle: S.current.Actividades_para_los_ninos,
      url: '/activity',
      icon: Icons.sports_esports),
  MenuItem(
      title: S.current.Configuracion,
      subTitle: S.current.Datos_personales,
      url: '/settings',
      icon: Icons.settings),
];
