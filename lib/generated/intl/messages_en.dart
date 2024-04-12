// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(namePictogram) =>
      "¿Está seguro de actualizar el pictograma ${namePictogram}?";

  static String m1(nameChild) =>
      "¿ Está seguro de avanzar de fase a ${nameChild} ?";

  static String m2(nameImage, nameChild) =>
      "Esta seguro que desea eliminar el pictograma \'${nameImage}\' de \'${nameChild}\'";

  static String m3(namePictogram) =>
      "Se actualizo correctamente el pictograma personalizado: ${namePictogram}";

  static String m4(numFase, nameChild) =>
      "Se avanzó a la fase ${numFase} a ${nameChild}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "Actividad_Actual":
            MessageLookupByLibrary.simpleMessage("Actividad actual"),
        "Actividades": MessageLookupByLibrary.simpleMessage("Actividades"),
        "Actividades_para_los_ninos":
            MessageLookupByLibrary.simpleMessage("Actividades para los niños"),
        "Actualizado_con_exito":
            MessageLookupByLibrary.simpleMessage("Actualizado con éxito!"),
        "Actualizar": MessageLookupByLibrary.simpleMessage("Actualizar"),
        "Agregar_pictograma":
            MessageLookupByLibrary.simpleMessage("Agregar pictograma"),
        "Anadir_nuevo_pictograma_personalizado":
            MessageLookupByLibrary.simpleMessage(
                "Añadir nuevo pictograma personalizado"),
        "Avance_de_fase_exitosa":
            MessageLookupByLibrary.simpleMessage("Avance de fase exitosa!"),
        "Avanzar_de_fase":
            MessageLookupByLibrary.simpleMessage("Avanzar de fase"),
        "Aviso": MessageLookupByLibrary.simpleMessage("Aviso!"),
        "Buscar": MessageLookupByLibrary.simpleMessage("Buscar"),
        "Busqueda_por_nombre":
            MessageLookupByLibrary.simpleMessage("Búsqueda por nombre"),
        "Camara": MessageLookupByLibrary.simpleMessage("Cámara"),
        "Cancelar": MessageLookupByLibrary.simpleMessage("Cancelar"),
        "Categoria_de_pictogramas":
            MessageLookupByLibrary.simpleMessage("Categoría de pictogramas"),
        "Cedula": MessageLookupByLibrary.simpleMessage("Cédula"),
        "Celular": MessageLookupByLibrary.simpleMessage("Celular"),
        "Cerrar_sesion": MessageLookupByLibrary.simpleMessage("Cerrar sesión"),
        "Configuracion": MessageLookupByLibrary.simpleMessage("Configuración"),
        "Contacto_terapeuta":
            MessageLookupByLibrary.simpleMessage("Contacto terapeuta"),
        "Contacto_tutor":
            MessageLookupByLibrary.simpleMessage("Contacto tutor"),
        "Contrasena": MessageLookupByLibrary.simpleMessage("Contraseña"),
        "Correo_electronico":
            MessageLookupByLibrary.simpleMessage("Correo electrónico"),
        "Correo_o_nombre_de_usuario":
            MessageLookupByLibrary.simpleMessage("Correo o nombre de usuario"),
        "Datos_del_usuario":
            MessageLookupByLibrary.simpleMessage("Datos del usuario"),
        "Datos_personales":
            MessageLookupByLibrary.simpleMessage("Datos personales"),
        "Debe_ingresar_el_nombre_de_usuario_o_correo":
            MessageLookupByLibrary.simpleMessage(
                "Debe ingresar el nombre de usuario o correo"),
        "Derechos_reservados": MessageLookupByLibrary.simpleMessage(
            "© 2023 Hope. All rights reserved"),
        "Direccion": MessageLookupByLibrary.simpleMessage("Dirección"),
        "Edad": MessageLookupByLibrary.simpleMessage("Edad"),
        "Editar": MessageLookupByLibrary.simpleMessage("Editar"),
        "Editar_imagen": MessageLookupByLibrary.simpleMessage("Editar Imagen"),
        "Editar_observaciones":
            MessageLookupByLibrary.simpleMessage("Editar observaciones"),
        "Editar_observaciones_del_nino": MessageLookupByLibrary.simpleMessage(
            "Editar observaciones del niño"),
        "Eliminar": MessageLookupByLibrary.simpleMessage("Eliminar"),
        "Eliminar_actividad_asignada_del_nino":
            MessageLookupByLibrary.simpleMessage(
                "Eliminar actividad asignada del niño"),
        "Entrar": MessageLookupByLibrary.simpleMessage("Entrar"),
        "Enviar_correo": MessageLookupByLibrary.simpleMessage("Enviar correo"),
        "Error_inesperado": MessageLookupByLibrary.simpleMessage(
            "Lamentablemente, ocurrió un error inesperado. Por favor, intenta nuevamente más tarde."),
        "Error_solicitud": MessageLookupByLibrary.simpleMessage(
            "Lo sentimos, ha ocurrido un error al procesar tu solicitud. Por favor, intenta nuevamente más tarde."),
        "Esta_Seguro_de_actualizar_los_datos":
            MessageLookupByLibrary.simpleMessage(
                "¿Está seguro de actualizar los datos?"),
        "Esta_seguro_de_actualizar_el_pictograma": m0,
        "Esta_seguro_de_avanzar_de_fase_a": m1,
        "Esta_seguro_de_salir_de_la_edicion":
            MessageLookupByLibrary.simpleMessage(
                "¿Está seguro de salir de la edición?"),
        "Esta_seguro_que_desea_eliminar_el_pictograma": m2,
        "Fases": MessageLookupByLibrary.simpleMessage("Fases"),
        "Fecha_de_nacimiento":
            MessageLookupByLibrary.simpleMessage("Fecha de nacimiento"),
        "Galeria": MessageLookupByLibrary.simpleMessage("Galería"),
        "Guardar": MessageLookupByLibrary.simpleMessage("Guardar"),
        "Hope_App": MessageLookupByLibrary.simpleMessage("Hope App"),
        "Informacion_del_nino":
            MessageLookupByLibrary.simpleMessage("Información del niño"),
        "Informacion_del_nino_actualizada":
            MessageLookupByLibrary.simpleMessage(
                "Información del niño actualizada"),
        "Informacion_general_del_nino": MessageLookupByLibrary.simpleMessage(
            "Información general del niño"),
        "Informacion_personal_actualizada":
            MessageLookupByLibrary.simpleMessage(
                "Información personal actualizada"),
        "Iniciar_sesion":
            MessageLookupByLibrary.simpleMessage("Iniciar sesión"),
        "Limpiar_filtros":
            MessageLookupByLibrary.simpleMessage("Limpiar filtros"),
        "Listar_pictogramas":
            MessageLookupByLibrary.simpleMessage("Listar pictogramas"),
        "Logros": MessageLookupByLibrary.simpleMessage("Logros"),
        "Los_campos_no_pueden_estar_vacios":
            MessageLookupByLibrary.simpleMessage(
                "Los campos no pueden estar vacios"),
        "Ninos": MessageLookupByLibrary.simpleMessage("Niños"),
        "Ninos_asignados":
            MessageLookupByLibrary.simpleMessage("Niños asignados"),
        "Nombre_de_usuario":
            MessageLookupByLibrary.simpleMessage("Nombre de usuario"),
        "Observaciones": MessageLookupByLibrary.simpleMessage("Observaciones"),
        "Olvido_su_contrasena":
            MessageLookupByLibrary.simpleMessage("¿Olvido su contraseña?"),
        "Perfil": MessageLookupByLibrary.simpleMessage("Perfil"),
        "Pictogramas_blanco_negro":
            MessageLookupByLibrary.simpleMessage("Pictogramas Blanco/Negro"),
        "Pictogramas_personalizados":
            MessageLookupByLibrary.simpleMessage("Pictogramas Personalizados"),
        "Pictogramas_personalizados_del_nino":
            MessageLookupByLibrary.simpleMessage(
                "Pictogramas personalizados del niño"),
        "Primer_apellido":
            MessageLookupByLibrary.simpleMessage("Primer Apellido"),
        "Primer_nombre": MessageLookupByLibrary.simpleMessage("Primer Nombre"),
        "Progreso": MessageLookupByLibrary.simpleMessage("Progreso"),
        "Quitar_actividad":
            MessageLookupByLibrary.simpleMessage("Quitar actividad"),
        "Restablecer_contrasena":
            MessageLookupByLibrary.simpleMessage("Restablecer contraseña"),
        "Se_actualizo_correctamente_el_pictograma_personalizado": m3,
        "Se_avanzo_a_la_fase": m4,
        "Segundo_apellido":
            MessageLookupByLibrary.simpleMessage("Segundo Apellido"),
        "Segundo_nombre":
            MessageLookupByLibrary.simpleMessage("Segundo Nombre"),
        "Seleccione_foto_de_perfil":
            MessageLookupByLibrary.simpleMessage("Seleccione foto de perfil"),
        "Sexo": MessageLookupByLibrary.simpleMessage("Sexo"),
        "Si_Eliminar": MessageLookupByLibrary.simpleMessage("Si, Eliminar"),
        "Si_actualizar": MessageLookupByLibrary.simpleMessage("Si, actualizar"),
        "Si_avanzar": MessageLookupByLibrary.simpleMessage("Si, avanzar"),
        "Si_salir": MessageLookupByLibrary.simpleMessage("Si, Salir"),
        "Telefono": MessageLookupByLibrary.simpleMessage("Teléfono"),
        "Telefono_de_casa":
            MessageLookupByLibrary.simpleMessage("Teléfono de casa"),
        "Terapeuta": MessageLookupByLibrary.simpleMessage("Terapeuta"),
        "Total_de_resultados":
            MessageLookupByLibrary.simpleMessage("Total de resultados:"),
        "Tutor": MessageLookupByLibrary.simpleMessage("Tutor"),
        "Usuario": MessageLookupByLibrary.simpleMessage("Usuario"),
        "Ver_informacion":
            MessageLookupByLibrary.simpleMessage("Ver Información"),
        "hope": MessageLookupByLibrary.simpleMessage("hope")
      };
}
