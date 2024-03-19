import 'package:flutter/material.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/presentation/interfaces/interface.dart';

final appMenuItemsDrawer = <MenuItem>[
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

const List<MenuItem> menuPacientTutor = [
  MenuItem(
      title: 'Ver Información',
      subTitle: 'Información general del niño',
      url: '/dataChildren',
      icon: Icons.visibility),
  MenuItem(
      title: 'Agregar pictograma',
      subTitle: 'Añadir nuevo pictograma personalizado',
      url: '/addPictograma',
      icon: Icons.add),
  MenuItem(
      title: 'Listar pictogramas',
      subTitle: 'Pictogramas personalizados del niño',
      url: '/pictogramasPersonalizados',
      icon: Icons.format_list_bulleted),
];
