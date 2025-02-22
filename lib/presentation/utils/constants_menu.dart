import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/presentation/interfaces/interface.dart';
import 'package:hope_app/presentation/utils/utils.dart';

final List<MenuItem> appMenuItemsDrawer = <MenuItem>[
  MenuItem(
    title: S.current.Ninos,
    subTitle: S.current.Ninos_asignados,
    onClick: ({required BuildContext context, int? idItem}) {
      context.pushReplacementNamed('children');
    },
    icon: Icons.face,
    permission: $listPatients,
  ),
  MenuItem(
    title: S.current.Actividades,
    subTitle: S.current.Actividades_para_los_ninos,
    icon: Icons.sports_esports,
    permission:
        $updatePatienttherapist, //TODO: Reemplazar por permiso correcto cuando este listo
    onClick: ({required BuildContext context, int? idItem}) {
      context.pushReplacementNamed('activities');
    },
  ),
  MenuItem(
    title: S.current.Perfil,
    subTitle: S.current.Datos_personales,
    icon: Icons.account_circle,
    permission: $me,
    onClick: ({required BuildContext context, int? idItem}) {
      context.pushReplacementNamed('profile');
    },
  ),
];

final List<MenuItem> menuPacientTutor = <MenuItem>[
  MenuItem(
    title: S.current.Ver_informacion,
    subTitle: S.current.Informacion_general_del_nino,
    icon: Icons.visibility,
    permission:
        $findPatients, //TODO: Reemplazar por permiso correcto cuando este listo
    onClick: ({required BuildContext context, int? idItem}) {
      context
          .pushNamed('child', pathParameters: {'idChild': idItem.toString()});
    },
  ),
  MenuItem(
    title: S.current.Agregar_pictograma,
    subTitle: S.current.Anadir_nuevo_pictograma_personalizado,
    icon: Icons.add,
    permission: $createCustomPictogram,
    onClick: ({required BuildContext context, int? idItem}) {
      context.pushNamed('pictogram',
          pathParameters: {'idChild': idItem.toString()});
    },
  ),
  MenuItem(
    title: S.current.Listar_pictogramas,
    subTitle: S.current.Pictogramas_personalizados_del_nino,
    icon: Icons.format_list_bulleted,
    permission: $listCustomPictograms,
    onClick: ({required BuildContext context, int? idItem}) {
      context.pushNamed('customPictogram',
          pathParameters: {'idChild': idItem.toString()});
    },
  ),
  MenuItem(
    title: S.current.Cambiar_contrasena,
    subTitle: S.current.Cambio_de_contrasena_de,
    icon: Icons.key,
    permission:
        $findPatients, //TODO: Reemplazar por permiso correcto cuando este listo
    onClick: ({required BuildContext context, int? idItem}) {
      modalPassword(context: context, isVerifided: true);
    },
  ),
];

final List<MenuItem> menuPacientTherapist = <MenuItem>[
  MenuItem(
    title: S.current.Ver_informacion,
    subTitle: S.current.Informacion_general_del_nino,
    icon: Icons.visibility,
    permission:
        $findPatients, //TODO: Reemplazar por permiso correcto cuando este listo
    onClick: ({required BuildContext context, int? idItem}) {
      context
          .pushNamed('child', pathParameters: {'idChild': idItem.toString()});
    },
  ),
  MenuItem(
    title: S.current.Editar_observaciones,
    subTitle: S.current.Editar_observaciones_del_nino,
    icon: Icons.edit,
    permission: $updatePatienttherapist,
    onClick: ({required BuildContext context, int? idItem}) {
      context
          .pushNamed('child', pathParameters: {'idChild': idItem.toString()});
    },
  ),
  MenuItem(
    title: S.current.Quitar_actividad,
    subTitle: S.current.Eliminar_actividad_asignada_del_nino,
    icon: Icons.delete_forever,
    permission:
        $findPatients, //TODO: Reemplazar por permiso correcto cuando este listo
    onClick: ({required BuildContext context, int? idItem}) {
      context.pushNamed('deleteActivity');
    },
  ),
];

final List<MenuItem> menuActivity = <MenuItem>[
  MenuItem(
    title: S.current.Ver_informacion,
    subTitle: S.current.Ver_informacion_detallada_de_la_actividad,
    icon: Icons.visibility,
    permission:
        $findPatients, //TODO: Reemplazar por permiso correcto cuando este listo
    onClick: ({required BuildContext context, int? idItem}) {
      context.pushNamed(
        'activity',
        pathParameters: {
          'idActivity': idItem.toString(),
          'isEdit': false.toString()
        },
      );
    },
  ),
  MenuItem(
    title: S.current.Editar,
    subTitle: S.current.Editar_la_informacion_general_de_la_actividad,
    icon: Icons.edit,
    permission:
        $findPatients, //TODO: Reemplazar por permiso correcto cuando este listo
    onClick: ({required BuildContext context, int? idItem}) {
      context.pushNamed('activity', pathParameters: {
        'idActivity': idItem.toString(),
        'isEdit': true.toString()
      });
    },
  ),
  MenuItem(
    title: S.current.Asignar_actividad,
    subTitle: S.current.Asignar_actividad_a_los_ninos,
    icon: Icons.add,
    permission:
        $findPatients, //TODO: Reemplazar por permiso correcto cuando este listo
    onClick: ({required BuildContext context, int? idItem}) {
      context.pushNamed('addActivity');
    },
  ),
  MenuItem(
    title: S.current.Quitar_actividad,
    subTitle: S.current.Quitar_actividad_a_los_ninos,
    icon: Icons.remove,
    permission:
        $findPatients, //TODO: Reemplazar por permiso correcto cuando este listo
    onClick: ({required BuildContext context, int? idItem}) {
      context.pushNamed('removeActivity');
    },
  ),
  MenuItem(
    title: S.current.Eliminar,
    subTitle: S.current.Eliminacion_permanente_de_la_actividad,
    icon: Icons.delete_forever,
    permission:
        $findPatients, //TODO: Reemplazar por permiso correcto cuando este listo
    onClick: ({required BuildContext context, int? idItem}) {
      modalDialogConfirmation(
        onClic: () {},
        context: context,
        question: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                style: const TextStyle(color: $colorTextBlack),
                children: [
                  TextSpan(
                    text:
                        '${S.current.Esta_seguro_de_eliminar_permanentemente_la_actividad}\n\n',
                  ),
                  const TextSpan(
                    text:
                        'Formar oraciones con animales', //TODO: Cambiar dinamicamente cuando este listo el endpoint
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ])),
        titleButtonConfirm: S.current.Si_Eliminar,
      );
    },
  ),
];
