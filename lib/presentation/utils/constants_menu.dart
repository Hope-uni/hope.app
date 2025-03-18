import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hope_app/domain/domain.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/presentation/interfaces/interface.dart';
import 'package:hope_app/presentation/providers/providers.dart';
import 'package:hope_app/presentation/utils/utils.dart';

final List<MenuItem> appMenuItemsDrawer = <MenuItem>[
  MenuItem(
    title: S.current.Ninos_terapeuta,
    subTitle: S.current.Ninos_asignados_Terapeuta,
    onClick: ({
      required BuildContext context,
      required WidgetRef ref,
      CatalogObject? item,
    }) {
      context.pushReplacementNamed($childrenTherapist);
    },
    icon: Icons.diversity_3,
    permission:
        $listPatients, //TODO: Reemplazar por permiso correcto cuando este listo
    roles: [$terapeuta],
  ),
  MenuItem(
    title: S.current.Ninos_tutor,
    subTitle: S.current.Ninos_asignados_Tutor,
    onClick: ({
      required BuildContext context,
      required WidgetRef ref,
      CatalogObject? item,
    }) {
      context.pushReplacementNamed($childrenTutor);
    },
    icon: Icons.family_restroom,
    permission:
        $listPatients, //TODO: Reemplazar por permiso correcto cuando este listo
    roles: [$tutor],
  ),
  MenuItem(
    title: S.current.Actividades,
    subTitle: S.current.Actividades_para_los_ninos,
    icon: Icons.sports_esports,
    permission:
        $updatePatienttherapist, //TODO: Reemplazar por permiso correcto cuando este listo
    onClick: ({
      required BuildContext context,
      required WidgetRef ref,
      CatalogObject? item,
    }) {
      context.pushReplacementNamed($activities);
    },
    roles: [$terapeuta],
  ),
  MenuItem(
    title: S.current.Perfil,
    subTitle: S.current.Datos_personales,
    icon: Icons.account_circle,
    permission: $me,
    onClick: ({
      required BuildContext context,
      required WidgetRef ref,
      CatalogObject? item,
    }) {
      context.pushReplacementNamed($profileRoute);
    },
    roles: [$tutor, $terapeuta],
  ),
];

final List<MenuItem> menuPacientTutor = <MenuItem>[
  MenuItem(
    title: S.current.Ver_informacion,
    subTitle: S.current.Informacion_general_del_nino,
    icon: Icons.visibility,
    permission:
        $findPatients, //TODO: Reemplazar por permiso correcto cuando este listo
    onClick: ({
      required BuildContext context,
      required WidgetRef ref,
      CatalogObject? item,
    }) {
      context
          .pushNamed($child, pathParameters: {$idChild: item!.id.toString()});
    },
    roles: [$tutor],
  ),
  MenuItem(
    title: S.current.Agregar_pictograma,
    subTitle: S.current.Anadir_nuevo_pictograma_personalizado,
    icon: Icons.add,
    permission: $createCustomPictogram,
    onClick: ({
      required BuildContext context,
      required WidgetRef ref,
      CatalogObject? item,
    }) {
      context.pushNamed($pictogram, pathParameters: {
        $idChild: item!.id.toString(),
      });
    },
    roles: [$tutor],
  ),
  MenuItem(
    title: S.current.Listar_pictogramas,
    subTitle: S.current.Pictogramas_personalizados_del_nino,
    icon: Icons.format_list_bulleted,
    permission: $listCustomPictograms,
    onClick: ({
      required BuildContext context,
      required WidgetRef ref,
      CatalogObject? item,
    }) {
      context.pushNamed($customPictogram,
          pathParameters: {$idChild: item!.id.toString()});
    },
    roles: [$tutor],
  ),
  MenuItem(
    title: S.current.Cambiar_contrasena,
    subTitle: S.current.Cambio_de_contrasena_de,
    icon: Icons.key,
    permission:
        $findPatients, //TODO: Reemplazar por permiso correcto cuando este listo
    onClick: ({
      required BuildContext context,
      required WidgetRef ref,
      CatalogObject? item,
    }) {
      modalPassword(context: context, isVerifided: true);
    },
    roles: [$tutor],
  ),
];

final List<MenuItem> menuPacientTherapist = <MenuItem>[
  MenuItem(
    title: S.current.Ver_informacion,
    subTitle: S.current.Informacion_general_del_nino,
    icon: Icons.visibility,
    permission:
        $findPatients, //TODO: Reemplazar por permiso correcto cuando este listo
    onClick: ({
      required BuildContext context,
      required WidgetRef ref,
      CatalogObject? item,
    }) {
      context
          .pushNamed($child, pathParameters: {$idChild: item!.id.toString()});
    },
    roles: [$terapeuta],
  ),
  MenuItem(
    title: S.current.Agregar_observacion,
    subTitle: S.current.Agregar_observacion_al_nino,
    icon: Icons.edit,
    permission: $updatePatienttherapist,
    onClick: ({
      required BuildContext context,
      required WidgetRef ref,
      CatalogObject? item,
    }) {
      context
          .pushNamed($child, pathParameters: {$idChild: item!.id.toString()});
    },
    roles: [$terapeuta],
  ),
  MenuItem(
    title: S.current.Quitar_actividad,
    subTitle: S.current.Eliminar_actividad_asignada_del_nino,
    icon: Icons.delete_forever,
    permission:
        $findPatients, //TODO: Reemplazar por permiso correcto cuando este listo
    onClick: ({
      required BuildContext context,
      required WidgetRef ref,
      CatalogObject? item,
    }) {
      context.pushNamed($deleteActivity);
    },
    roles: [$terapeuta],
  ),
];

final List<MenuItem> menuActivity = <MenuItem>[
  MenuItem(
    title: S.current.Ver_informacion,
    subTitle: S.current.Ver_informacion_detallada_de_la_actividad,
    icon: Icons.visibility,
    permission:
        $findPatients, //TODO: Reemplazar por permiso correcto cuando este listo
    onClick: ({
      required BuildContext context,
      required WidgetRef ref,
      CatalogObject? item,
    }) {
      context.pushNamed(
        $activity,
        pathParameters: {$idActivity: item!.id.toString()},
      );
    },
    roles: [$terapeuta],
  ),
  MenuItem(
    title: S.current.Asignar_actividad,
    subTitle: S.current.Asignar_actividad_a_los_ninos,
    icon: Icons.add,
    permission:
        $findPatients, //TODO: Reemplazar por permiso correcto cuando este listo
    onClick: ({
      required BuildContext context,
      required WidgetRef ref,
      CatalogObject? item,
    }) {
      context.pushNamed($addActivity);
    },
    roles: [$terapeuta],
  ),
  MenuItem(
    title: S.current.Quitar_actividad,
    subTitle: S.current.Quitar_actividad_a_los_ninos,
    icon: Icons.remove,
    permission:
        $findPatients, //TODO: Reemplazar por permiso correcto cuando este listo
    onClick: ({
      required BuildContext context,
      required WidgetRef ref,
      CatalogObject? item,
    }) {
      context.pushNamed($removeActivity);
    },
    roles: [$terapeuta],
  ),
  MenuItem(
    title: S.current.Eliminar,
    subTitle: S.current.Eliminacion_permanente_de_la_actividad,
    icon: Icons.delete_forever,
    permission:
        $findPatients, //TODO: Reemplazar por permiso correcto cuando este listo
    onClick: ({
      required BuildContext context,
      required WidgetRef ref,
      CatalogObject? item,
    }) {
      modalDialogConfirmation(
        onClic: () async {
          await ref
              .read(activityProvider.notifier)
              .deleteActivity(idActivity: item.id);

          if (context.mounted) {
            Navigator.of(context).pop();
          }
        },
        context: context,
        question: RichText(
          textAlign: TextAlign.left,
          text: TextSpan(
            style: const TextStyle(color: $colorTextBlack),
            children: [
              TextSpan(
                text:
                    '${S.current.Esta_seguro_de_eliminar_permanentemente_la_actividad}\n\n',
              ),
              TextSpan(
                text: item!.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        titleButtonConfirm: S.current.Si_Eliminar,
      );
    },
    roles: [$terapeuta],
  ),
];
