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
      title: S.current.Perfil,
      subTitle: S.current.Datos_personales,
      url: '/profile',
      icon: Icons.account_circle),
];

final List<MenuItem> menuPacientTutor = [
  MenuItem(
      title: S.current.Ver_informacion,
      subTitle: S.current.Informacion_general_del_nino,
      url: '/child',
      icon: Icons.visibility),
  MenuItem(
      title: S.current.Agregar_pictograma,
      subTitle: S.current.Anadir_nuevo_pictograma_personalizado,
      url: '/pictogram',
      icon: Icons.add),
  MenuItem(
      title: S.current.Listar_pictogramas,
      subTitle: S.current.Pictogramas_personalizados_del_nino,
      url: '/customPictogram',
      icon: Icons.format_list_bulleted),
];

final List<MenuItem> menuPacientTherapist = [
  MenuItem(
      title: S.current.Ver_informacion,
      subTitle: S.current.Informacion_general_del_nino,
      url: '/child',
      icon: Icons.visibility),
  MenuItem(
      title: S.current.Editar_observaciones,
      subTitle: S.current.Editar_observaciones_del_nino,
      url: '/child',
      icon: Icons.edit),
  MenuItem(
      title: S.current.Quitar_actividad,
      subTitle: S.current.Eliminar_actividad_asignada_del_nino,
      url: '/deleteActivity',
      icon: Icons.delete_forever),
];

final List<MenuItem> menuActivity = [
  MenuItem(
      title: S.current.Ver_informacion,
      subTitle: S.current.Ver_informacion_detallada_de_la_actividad,
      url: '/activity',
      icon: Icons.visibility),
  MenuItem(
      title: S.current.Editar,
      subTitle: S.current.Editar_la_informacion_general_de_la_actividad,
      url: '/activity',
      icon: Icons.edit),
  MenuItem(
      title: 'Asignar actividad',
      subTitle: S.current.Asignar_actividad_a_los_ninos,
      url: '/addActivity',
      icon: Icons.add),
  MenuItem(
      title: S.current.Quitar_actividad,
      subTitle: S.current.Quitar_actividad_a_los_nino,
      url: '/removeActivity',
      icon: Icons.remove),
  MenuItem(
      title: S.current.Eliminar,
      subTitle: S.current.Eliminacion_permanente_de_la_actividad,
      url: '/deleteActivity',
      icon: Icons.delete_forever),
];
