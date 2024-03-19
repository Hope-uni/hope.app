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

final List<MenuItem> menuPacientTutor = [
  MenuItem(
      title: S.current.Ver_informacion,
      subTitle: S.current.Informacion_general_del_nino,
      url: '/dataChildren',
      icon: Icons.visibility),
  MenuItem(
      title: S.current.Agregar_pictograma,
      subTitle: S.current.Anadir_nuevo_pictograma_personalizado,
      url: '/addPictogram',
      icon: Icons.add),
  MenuItem(
      title: S.current.Listar_pictogramas,
      subTitle: S.current.Pictogramas_personalizados_del_nino,
      url: '/pictogram',
      icon: Icons.format_list_bulleted),
];
