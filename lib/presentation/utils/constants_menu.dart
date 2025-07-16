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
    title: S.current.Pacientes_terapeuta,
    subTitle: S.current.Pacientes_asignados_Terapeuta,
    onClick: ({
      required BuildContext context,
      required WidgetRef ref,
      CatalogObject? item,
    }) {
      context.pushReplacementNamed($childrenTherapist);
    },
    icon: Icons.diversity_3,
    permission: $listAssignedPatient,
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
    permission: $listAssignedPatient,
    roles: [$tutor],
  ),
  MenuItem(
    title: S.current.Actividades,
    subTitle: S.current.Actividades_para_los_ninos,
    icon: Icons.sports_esports,
    permission: $listActivity,
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
    permission: $getProfile,
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
    permission: $getPatient,
    onClick: ({
      required BuildContext context,
      required WidgetRef ref,
      CatalogObject? item,
    }) {
      context.pushNamed($child,
          pathParameters: {$idChild: item!.id.toString()},
          extra: {$isTutor: true});
    },
    roles: [$tutor],
  ),
  MenuItem(
    title: S.current.Agregar_pictograma,
    subTitle: S.current.Anadir_nuevo_pictograma_personalizado,
    icon: Icons.add,
    permission: $listPictogram,
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
    title: S.current.Pictogramas_personalizados,
    subTitle: S.current.Pictogramas_personalizados_del_nino,
    icon: Icons.format_list_bulleted,
    permission: $listCustomPictogram,
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
    permission: $changePasswordAssignedPatient,
    onClick: ({
      required BuildContext context,
      required WidgetRef ref,
      CatalogObject? item,
    }) {
      modalPassword(context: context, isVerifided: true, patient: item);
    },
    roles: [$tutor],
  ),
];

final List<MenuItem> menuPacientTherapist = <MenuItem>[
  MenuItem(
    title: S.current.Ver_informacion,
    subTitle: S.current.Informacion_general_del_nino,
    icon: Icons.visibility,
    permission: $getPatient,
    onClick: ({
      required BuildContext context,
      required WidgetRef ref,
      CatalogObject? item,
    }) {
      context.pushNamed($child,
          pathParameters: {$idChild: item!.id.toString()},
          extra: {$isTutor: false});
    },
    roles: [$terapeuta],
  ),
  MenuItem(
    title: S.current.Agregar_observacion,
    subTitle: S.current.Agregar_observacion_al_nino,
    icon: Icons.add,
    permission: $addObservation,
    onClick: ({
      required BuildContext context,
      required WidgetRef ref,
      CatalogObject? item,
    }) {
      modalObservation(context: context, dataChild: item!, isPageChild: false);
    },
    roles: [$terapeuta],
  ),
  MenuItem(
    title: S.current.Asignar_Logro,
    subTitle: S.current.Listado_de_logros_para_el_paciente,
    icon: Icons.add,
    permission: $listAchievement,
    onClick: ({
      required BuildContext context,
      required WidgetRef ref,
      CatalogObject? item,
    }) {
      context.pushNamed(
        $achievement,
        pathParameters: {$idChild: item!.id.toString()},
        extra: {$nameChild: item.name},
      );
    },
    roles: [$terapeuta],
  ),
];

final List<MenuItem> menuActivity = <MenuItem>[
  MenuItem(
    title: S.current.Ver_informacion,
    subTitle: S.current.Ver_informacion_detallada_de_la_actividad,
    icon: Icons.visibility,
    permission: $getActivity,
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
    permission: $assignActivity,
    onClick: ({
      required BuildContext context,
      required WidgetRef ref,
      CatalogObject? item,
    }) {
      context.pushNamed(
        $addActivity,
        pathParameters: {$idActivity: item!.id.toString()},
      );
    },
    roles: [$terapeuta],
  ),
  MenuItem(
    title: S.current.Desasignar_actividad,
    subTitle: S.current.Desasignar_actividad_a_los_ninos,
    icon: Icons.remove,
    permission: $unassignActivity,
    onClick: ({
      required BuildContext context,
      required WidgetRef ref,
      CatalogObject? item,
    }) {
      context.pushNamed($removeActivity,
          pathParameters: {$idActivity: item!.id.toString()},
          extra: {'nameActivity': item.name});
    },
    roles: [$terapeuta],
  ),
  MenuItem(
    title: S.current.Eliminar,
    subTitle: S.current.Eliminacion_permanente_de_la_actividad,
    icon: Icons.delete_forever,
    permission: $deleteActivity,
    onClick: ({
      required BuildContext context,
      required WidgetRef ref,
      CatalogObject? item,
    }) {
      modalDialogConfirmation(
        onClic: () async {
          Navigator.of(context).pop();
          await ref
              .read(activityProvider.notifier)
              .deleteActivity(idActivity: item.id);
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
