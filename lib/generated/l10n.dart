// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Hope App`
  String get Hope_App {
    return Intl.message(
      'Hope App',
      name: 'Hope_App',
      desc: '',
      args: [],
    );
  }

  /// `hope`
  String get hope {
    return Intl.message(
      'hope',
      name: 'hope',
      desc: '',
      args: [],
    );
  }

  /// `Iniciar sesión`
  String get Iniciar_sesion {
    return Intl.message(
      'Iniciar sesión',
      name: 'Iniciar_sesion',
      desc: '',
      args: [],
    );
  }

  /// `© 2023 Hope. All rights reserved`
  String get Derechos_reservados {
    return Intl.message(
      '© 2023 Hope. All rights reserved',
      name: 'Derechos_reservados',
      desc: '',
      args: [],
    );
  }

  /// `Usuario`
  String get Usuario {
    return Intl.message(
      'Usuario',
      name: 'Usuario',
      desc: '',
      args: [],
    );
  }

  /// `Contraseña`
  String get Contrasena {
    return Intl.message(
      'Contraseña',
      name: 'Contrasena',
      desc: '',
      args: [],
    );
  }

  /// `¿Olvido su contraseña?`
  String get Olvido_su_contrasena {
    return Intl.message(
      '¿Olvido su contraseña?',
      name: 'Olvido_su_contrasena',
      desc: '',
      args: [],
    );
  }

  /// `Entrar`
  String get Entrar {
    return Intl.message(
      'Entrar',
      name: 'Entrar',
      desc: '',
      args: [],
    );
  }

  /// `Los campos no pueden estar vacios`
  String get Los_campos_no_pueden_estar_vacios {
    return Intl.message(
      'Los campos no pueden estar vacios',
      name: 'Los_campos_no_pueden_estar_vacios',
      desc: '',
      args: [],
    );
  }

  /// `Niños`
  String get Ninos {
    return Intl.message(
      'Niños',
      name: 'Ninos',
      desc: '',
      args: [],
    );
  }

  /// `Actividades`
  String get Actividades {
    return Intl.message(
      'Actividades',
      name: 'Actividades',
      desc: '',
      args: [],
    );
  }

  /// `Configuración`
  String get Configuracion {
    return Intl.message(
      'Configuración',
      name: 'Configuracion',
      desc: '',
      args: [],
    );
  }

  /// `Cerrar sesión`
  String get Cerrar_sesion {
    return Intl.message(
      'Cerrar sesión',
      name: 'Cerrar_sesion',
      desc: '',
      args: [],
    );
  }

  /// `Niños asignados`
  String get Ninos_asignados {
    return Intl.message(
      'Niños asignados',
      name: 'Ninos_asignados',
      desc: '',
      args: [],
    );
  }

  /// `Actividades para los niños`
  String get Actividades_para_los_ninos {
    return Intl.message(
      'Actividades para los niños',
      name: 'Actividades_para_los_ninos',
      desc: '',
      args: [],
    );
  }

  /// `Datos personales`
  String get Datos_personales {
    return Intl.message(
      'Datos personales',
      name: 'Datos_personales',
      desc: '',
      args: [],
    );
  }

  /// `Restablecer contraseña`
  String get Restablecer_contrasena {
    return Intl.message(
      'Restablecer contraseña',
      name: 'Restablecer_contrasena',
      desc: '',
      args: [],
    );
  }

  /// `Correo o nombre de usuario`
  String get Correo_o_nombre_de_usuario {
    return Intl.message(
      'Correo o nombre de usuario',
      name: 'Correo_o_nombre_de_usuario',
      desc: '',
      args: [],
    );
  }

  /// `Enviar correo`
  String get Enviar_correo {
    return Intl.message(
      'Enviar correo',
      name: 'Enviar_correo',
      desc: '',
      args: [],
    );
  }

  /// `Debe ingresar el nombre de usuario o correo`
  String get Debe_ingresar_el_nombre_de_usuario_o_correo {
    return Intl.message(
      'Debe ingresar el nombre de usuario o correo',
      name: 'Debe_ingresar_el_nombre_de_usuario_o_correo',
      desc: '',
      args: [],
    );
  }

  /// `Pictogramas Personalizados`
  String get Pictogramas_personalizados {
    return Intl.message(
      'Pictogramas Personalizados',
      name: 'Pictogramas_personalizados',
      desc: '',
      args: [],
    );
  }

  /// `Ver Información`
  String get Ver_informacion {
    return Intl.message(
      'Ver Información',
      name: 'Ver_informacion',
      desc: '',
      args: [],
    );
  }

  /// `Información general del niño`
  String get Informacion_general_del_nino {
    return Intl.message(
      'Información general del niño',
      name: 'Informacion_general_del_nino',
      desc: '',
      args: [],
    );
  }

  /// `Agregar pictograma`
  String get Agregar_pictograma {
    return Intl.message(
      'Agregar pictograma',
      name: 'Agregar_pictograma',
      desc: '',
      args: [],
    );
  }

  /// `Añadir nuevo pictograma personalizado`
  String get Anadir_nuevo_pictograma_personalizado {
    return Intl.message(
      'Añadir nuevo pictograma personalizado',
      name: 'Anadir_nuevo_pictograma_personalizado',
      desc: '',
      args: [],
    );
  }

  /// `Listar pictogramas`
  String get Listar_pictogramas {
    return Intl.message(
      'Listar pictogramas',
      name: 'Listar_pictogramas',
      desc: '',
      args: [],
    );
  }

  /// `Pictogramas personalizados del niño`
  String get Pictogramas_personalizados_del_nino {
    return Intl.message(
      'Pictogramas personalizados del niño',
      name: 'Pictogramas_personalizados_del_nino',
      desc: '',
      args: [],
    );
  }

  /// `Categoría de pictogramas`
  String get Categoria_de_pictogramas {
    return Intl.message(
      'Categoría de pictogramas',
      name: 'Categoria_de_pictogramas',
      desc: '',
      args: [],
    );
  }

  /// `Búsqueda por nombre`
  String get Busqueda_por_nombre {
    return Intl.message(
      'Búsqueda por nombre',
      name: 'Busqueda_por_nombre',
      desc: '',
      args: [],
    );
  }

  /// `Buscar`
  String get Buscar {
    return Intl.message(
      'Buscar',
      name: 'Buscar',
      desc: '',
      args: [],
    );
  }

  /// `Limpiar filtros`
  String get Limpiar_filtros {
    return Intl.message(
      'Limpiar filtros',
      name: 'Limpiar_filtros',
      desc: '',
      args: [],
    );
  }

  /// `Editar`
  String get Editar {
    return Intl.message(
      'Editar',
      name: 'Editar',
      desc: '',
      args: [],
    );
  }

  /// `Eliminar`
  String get Eliminar {
    return Intl.message(
      'Eliminar',
      name: 'Eliminar',
      desc: '',
      args: [],
    );
  }

  /// `Editar Imagen`
  String get Editar_imagen {
    return Intl.message(
      'Editar Imagen',
      name: 'Editar_imagen',
      desc: '',
      args: [],
    );
  }

  /// `Guardar`
  String get Guardar {
    return Intl.message(
      'Guardar',
      name: 'Guardar',
      desc: '',
      args: [],
    );
  }

  /// `Cancelar`
  String get Cancelar {
    return Intl.message(
      'Cancelar',
      name: 'Cancelar',
      desc: '',
      args: [],
    );
  }

  /// `Actualizar`
  String get Actualizar {
    return Intl.message(
      'Actualizar',
      name: 'Actualizar',
      desc: '',
      args: [],
    );
  }

  /// `Si, Eliminar`
  String get Si_Eliminar {
    return Intl.message(
      'Si, Eliminar',
      name: 'Si_Eliminar',
      desc: '',
      args: [],
    );
  }

  /// `¡Aviso!`
  String get Aviso {
    return Intl.message(
      '¡Aviso!',
      name: 'Aviso',
      desc: '',
      args: [],
    );
  }

  /// `¿Está seguro que desea eliminar el pictograma '{nameImage}' de '{nameChild}'?`
  String Esta_seguro_que_desea_eliminar_el_pictograma(
      Object nameImage, Object nameChild) {
    return Intl.message(
      '¿Está seguro que desea eliminar el pictograma \'$nameImage\' de \'$nameChild\'?',
      name: 'Esta_seguro_que_desea_eliminar_el_pictograma',
      desc: '',
      args: [nameImage, nameChild],
    );
  }

  /// `Galería`
  String get Galeria {
    return Intl.message(
      'Galería',
      name: 'Galeria',
      desc: '',
      args: [],
    );
  }

  /// `Cámara`
  String get Camara {
    return Intl.message(
      'Cámara',
      name: 'Camara',
      desc: '',
      args: [],
    );
  }

  /// `Lo sentimos, ha ocurrido un error al procesar tu solicitud. Por favor, intenta nuevamente más tarde.`
  String get Error_solicitud {
    return Intl.message(
      'Lo sentimos, ha ocurrido un error al procesar tu solicitud. Por favor, intenta nuevamente más tarde.',
      name: 'Error_solicitud',
      desc: '',
      args: [],
    );
  }

  /// `Lamentablemente, ocurrió un error inesperado. Por favor, intenta nuevamente más tarde.`
  String get Error_inesperado {
    return Intl.message(
      'Lamentablemente, ocurrió un error inesperado. Por favor, intenta nuevamente más tarde.',
      name: 'Error_inesperado',
      desc: '',
      args: [],
    );
  }

  /// `Perfil`
  String get Perfil {
    return Intl.message(
      'Perfil',
      name: 'Perfil',
      desc: '',
      args: [],
    );
  }

  /// `Datos del usuario`
  String get Datos_del_usuario {
    return Intl.message(
      'Datos del usuario',
      name: 'Datos_del_usuario',
      desc: '',
      args: [],
    );
  }

  /// `Primer Nombre`
  String get Primer_nombre {
    return Intl.message(
      'Primer Nombre',
      name: 'Primer_nombre',
      desc: '',
      args: [],
    );
  }

  /// `Segundo Nombre`
  String get Segundo_nombre {
    return Intl.message(
      'Segundo Nombre',
      name: 'Segundo_nombre',
      desc: '',
      args: [],
    );
  }

  /// `Primer Apellido`
  String get Primer_apellido {
    return Intl.message(
      'Primer Apellido',
      name: 'Primer_apellido',
      desc: '',
      args: [],
    );
  }

  /// `Segundo Apellido`
  String get Segundo_apellido {
    return Intl.message(
      'Segundo Apellido',
      name: 'Segundo_apellido',
      desc: '',
      args: [],
    );
  }

  /// `Cédula`
  String get Cedula {
    return Intl.message(
      'Cédula',
      name: 'Cedula',
      desc: '',
      args: [],
    );
  }

  /// `Edad`
  String get Edad {
    return Intl.message(
      'Edad',
      name: 'Edad',
      desc: '',
      args: [],
    );
  }

  /// `Teléfono`
  String get Telefono {
    return Intl.message(
      'Teléfono',
      name: 'Telefono',
      desc: '',
      args: [],
    );
  }

  /// `Celular`
  String get Celular {
    return Intl.message(
      'Celular',
      name: 'Celular',
      desc: '',
      args: [],
    );
  }

  /// `Dirección`
  String get Direccion {
    return Intl.message(
      'Dirección',
      name: 'Direccion',
      desc: '',
      args: [],
    );
  }

  /// `Seleccione foto de perfil`
  String get Seleccione_foto_de_perfil {
    return Intl.message(
      'Seleccione foto de perfil',
      name: 'Seleccione_foto_de_perfil',
      desc: '',
      args: [],
    );
  }

  /// `Nombre de usuario`
  String get Nombre_de_usuario {
    return Intl.message(
      'Nombre de usuario',
      name: 'Nombre_de_usuario',
      desc: '',
      args: [],
    );
  }

  /// `Correo electrónico`
  String get Correo_electronico {
    return Intl.message(
      'Correo electrónico',
      name: 'Correo_electronico',
      desc: '',
      args: [],
    );
  }

  /// `Fecha de nacimiento`
  String get Fecha_de_nacimiento {
    return Intl.message(
      'Fecha de nacimiento',
      name: 'Fecha_de_nacimiento',
      desc: '',
      args: [],
    );
  }

  /// `Sexo`
  String get Sexo {
    return Intl.message(
      'Sexo',
      name: 'Sexo',
      desc: '',
      args: [],
    );
  }

  /// `Teléfono de casa`
  String get Telefono_de_casa {
    return Intl.message(
      'Teléfono de casa',
      name: 'Telefono_de_casa',
      desc: '',
      args: [],
    );
  }

  /// `Tutor`
  String get Tutor {
    return Intl.message(
      'Tutor',
      name: 'Tutor',
      desc: '',
      args: [],
    );
  }

  /// `Contacto tutor`
  String get Contacto_tutor {
    return Intl.message(
      'Contacto tutor',
      name: 'Contacto_tutor',
      desc: '',
      args: [],
    );
  }

  /// `Terapeuta`
  String get Terapeuta {
    return Intl.message(
      'Terapeuta',
      name: 'Terapeuta',
      desc: '',
      args: [],
    );
  }

  /// `Contacto terapeuta`
  String get Contacto_terapeuta {
    return Intl.message(
      'Contacto terapeuta',
      name: 'Contacto_terapeuta',
      desc: '',
      args: [],
    );
  }

  /// `Observaciones`
  String get Observaciones {
    return Intl.message(
      'Observaciones',
      name: 'Observaciones',
      desc: '',
      args: [],
    );
  }

  /// `Pictogramas Blanco/Negro`
  String get Pictogramas_blanco_negro {
    return Intl.message(
      'Pictogramas Blanco/Negro',
      name: 'Pictogramas_blanco_negro',
      desc: '',
      args: [],
    );
  }

  /// `Actividad actual`
  String get Actividad_Actual {
    return Intl.message(
      'Actividad actual',
      name: 'Actividad_Actual',
      desc: '',
      args: [],
    );
  }

  /// `Fases`
  String get Fases {
    return Intl.message(
      'Fases',
      name: 'Fases',
      desc: '',
      args: [],
    );
  }

  /// `Avanzar de fase`
  String get Avanzar_de_fase {
    return Intl.message(
      'Avanzar de fase',
      name: 'Avanzar_de_fase',
      desc: '',
      args: [],
    );
  }

  /// `Logros`
  String get Logros {
    return Intl.message(
      'Logros',
      name: 'Logros',
      desc: '',
      args: [],
    );
  }

  /// `Información del niño`
  String get Informacion_del_nino {
    return Intl.message(
      'Información del niño',
      name: 'Informacion_del_nino',
      desc: '',
      args: [],
    );
  }

  /// `Si, avanzar`
  String get Si_avanzar {
    return Intl.message(
      'Si, avanzar',
      name: 'Si_avanzar',
      desc: '',
      args: [],
    );
  }

  /// `¿Está seguro de avanzar de fase a {nameChild}?`
  String Esta_seguro_de_avanzar_de_fase_a(Object nameChild) {
    return Intl.message(
      '¿Está seguro de avanzar de fase a $nameChild?',
      name: 'Esta_seguro_de_avanzar_de_fase_a',
      desc: '',
      args: [nameChild],
    );
  }

  /// `Editar observaciones`
  String get Editar_observaciones {
    return Intl.message(
      'Editar observaciones',
      name: 'Editar_observaciones',
      desc: '',
      args: [],
    );
  }

  /// `Quitar actividad`
  String get Quitar_actividad {
    return Intl.message(
      'Quitar actividad',
      name: 'Quitar_actividad',
      desc: '',
      args: [],
    );
  }

  /// `Editar observaciones del niño`
  String get Editar_observaciones_del_nino {
    return Intl.message(
      'Editar observaciones del niño',
      name: 'Editar_observaciones_del_nino',
      desc: '',
      args: [],
    );
  }

  /// `Eliminar actividad asignada del niño`
  String get Eliminar_actividad_asignada_del_nino {
    return Intl.message(
      'Eliminar actividad asignada del niño',
      name: 'Eliminar_actividad_asignada_del_nino',
      desc: '',
      args: [],
    );
  }

  /// `¡Avance de fase exitosa!`
  String get Avance_de_fase_exitosa {
    return Intl.message(
      '¡Avance de fase exitosa!',
      name: 'Avance_de_fase_exitosa',
      desc: '',
      args: [],
    );
  }

  /// `Se avanzó a la fase {numFase} a {nameChild}`
  String Se_avanzo_a_la_fase(Object numFase, Object nameChild) {
    return Intl.message(
      'Se avanzó a la fase $numFase a $nameChild',
      name: 'Se_avanzo_a_la_fase',
      desc: '',
      args: [numFase, nameChild],
    );
  }

  /// `Si, actualizar`
  String get Si_actualizar {
    return Intl.message(
      'Si, actualizar',
      name: 'Si_actualizar',
      desc: '',
      args: [],
    );
  }

  /// `¿Está seguro de actualizar los datos?`
  String get Esta_Seguro_de_actualizar_los_datos {
    return Intl.message(
      '¿Está seguro de actualizar los datos?',
      name: 'Esta_Seguro_de_actualizar_los_datos',
      desc: '',
      args: [],
    );
  }

  /// `¡Actualizado con éxito!`
  String get Actualizado_con_exito {
    return Intl.message(
      '¡Actualizado con éxito!',
      name: 'Actualizado_con_exito',
      desc: '',
      args: [],
    );
  }

  /// `Información del niño actualizada`
  String get Informacion_del_nino_actualizada {
    return Intl.message(
      'Información del niño actualizada',
      name: 'Informacion_del_nino_actualizada',
      desc: '',
      args: [],
    );
  }

  /// `Si, Salir`
  String get Si_salir {
    return Intl.message(
      'Si, Salir',
      name: 'Si_salir',
      desc: '',
      args: [],
    );
  }

  /// `¿Está seguro de salir de la edición?`
  String get Esta_seguro_de_salir_de_la_edicion {
    return Intl.message(
      '¿Está seguro de salir de la edición?',
      name: 'Esta_seguro_de_salir_de_la_edicion',
      desc: '',
      args: [],
    );
  }

  /// `Información personal actualizada`
  String get Informacion_personal_actualizada {
    return Intl.message(
      'Información personal actualizada',
      name: 'Informacion_personal_actualizada',
      desc: '',
      args: [],
    );
  }

  /// `Se actualizó correctamente el pictograma personalizado: {namePictogram}`
  String Se_actualizo_correctamente_el_pictograma_personalizado(
      Object namePictogram) {
    return Intl.message(
      'Se actualizó correctamente el pictograma personalizado: $namePictogram',
      name: 'Se_actualizo_correctamente_el_pictograma_personalizado',
      desc: '',
      args: [namePictogram],
    );
  }

  /// `Total de resultados:`
  String get Total_de_resultados {
    return Intl.message(
      'Total de resultados:',
      name: 'Total_de_resultados',
      desc: '',
      args: [],
    );
  }

  /// `Lista de pictogramas generales`
  String get Lista_de_pictogramas_generales {
    return Intl.message(
      'Lista de pictogramas generales',
      name: 'Lista_de_pictogramas_generales',
      desc: '',
      args: [],
    );
  }

  /// `Información general`
  String get Informacion_general {
    return Intl.message(
      'Información general',
      name: 'Informacion_general',
      desc: '',
      args: [],
    );
  }

  /// `Información del progreso`
  String get Informacion_del_progreso {
    return Intl.message(
      'Información del progreso',
      name: 'Informacion_del_progreso',
      desc: '',
      args: [],
    );
  }

  /// `Información personal`
  String get Informacion_personal {
    return Intl.message(
      'Información personal',
      name: 'Informacion_personal',
      desc: '',
      args: [],
    );
  }

  /// `Progresos`
  String get Progresos {
    return Intl.message(
      'Progresos',
      name: 'Progresos',
      desc: '',
      args: [],
    );
  }

  /// `Progreso general`
  String get Progreso_general {
    return Intl.message(
      'Progreso general',
      name: 'Progreso_general',
      desc: '',
      args: [],
    );
  }

  /// `Progreso de fase`
  String get progreso_de_fase {
    return Intl.message(
      'Progreso de fase',
      name: 'progreso_de_fase',
      desc: '',
      args: [],
    );
  }

  /// `Crear actividad`
  String get Crear_actividad {
    return Intl.message(
      'Crear actividad',
      name: 'Crear_actividad',
      desc: '',
      args: [],
    );
  }

  /// `Nombre`
  String get Nombre {
    return Intl.message(
      'Nombre',
      name: 'Nombre',
      desc: '',
      args: [],
    );
  }

  /// `Fase`
  String get Fase {
    return Intl.message(
      'Fase',
      name: 'Fase',
      desc: '',
      args: [],
    );
  }

  /// `Puntos`
  String get Puntos {
    return Intl.message(
      'Puntos',
      name: 'Puntos',
      desc: '',
      args: [],
    );
  }

  /// `Opciones`
  String get Opciones {
    return Intl.message(
      'Opciones',
      name: 'Opciones',
      desc: '',
      args: [],
    );
  }

  /// `Página`
  String get Pagina {
    return Intl.message(
      'Página',
      name: 'Pagina',
      desc: '',
      args: [],
    );
  }

  /// `de`
  String get De {
    return Intl.message(
      'de',
      name: 'De',
      desc: '',
      args: [],
    );
  }

  /// `Ver Información detallada de la actividad`
  String get Ver_informacion_detallada_de_la_actividad {
    return Intl.message(
      'Ver Información detallada de la actividad',
      name: 'Ver_informacion_detallada_de_la_actividad',
      desc: '',
      args: [],
    );
  }

  /// `Editar la Información general de la actividad`
  String get Editar_la_informacion_general_de_la_actividad {
    return Intl.message(
      'Editar la Información general de la actividad',
      name: 'Editar_la_informacion_general_de_la_actividad',
      desc: '',
      args: [],
    );
  }

  /// `Asignar actividad a los niños`
  String get Asignar_actividad_a_los_ninos {
    return Intl.message(
      'Asignar actividad a los niños',
      name: 'Asignar_actividad_a_los_ninos',
      desc: '',
      args: [],
    );
  }

  /// `Quitar actividad a los niños`
  String get Quitar_actividad_a_los_ninos {
    return Intl.message(
      'Quitar actividad a los niños',
      name: 'Quitar_actividad_a_los_ninos',
      desc: '',
      args: [],
    );
  }

  /// `Eliminación permanente de la actividad`
  String get Eliminacion_permanente_de_la_actividad {
    return Intl.message(
      'Eliminación permanente de la actividad',
      name: 'Eliminacion_permanente_de_la_actividad',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get Error {
    return Intl.message(
      'Error',
      name: 'Error',
      desc: '',
      args: [],
    );
  }

  /// `La contraseña debe contener entre 8 y 30 caracteres`
  String get La_contrasena_debe_contener_entre_8_y_30_caracteres {
    return Intl.message(
      'La contraseña debe contener entre 8 y 30 caracteres',
      name: 'La_contrasena_debe_contener_entre_8_y_30_caracteres',
      desc: '',
      args: [],
    );
  }

  /// `La contraseña es requerida`
  String get La_contrasena_es_requerida {
    return Intl.message(
      'La contraseña es requerida',
      name: 'La_contrasena_es_requerida',
      desc: '',
      args: [],
    );
  }

  /// `El usuario es requerido`
  String get El_usuario_es_requerido {
    return Intl.message(
      'El usuario es requerido',
      name: 'El_usuario_es_requerido',
      desc: '',
      args: [],
    );
  }

  /// `Asignar actividad`
  String get Asignar_actividad {
    return Intl.message(
      'Asignar actividad',
      name: 'Asignar_actividad',
      desc: '',
      args: [],
    );
  }

  /// `¿Está seguro de eliminar permanentemente la actividad?`
  String get Esta_seguro_de_eliminar_permanentemente_la_actividad {
    return Intl.message(
      '¿Está seguro de eliminar permanentemente la actividad?',
      name: 'Esta_seguro_de_eliminar_permanentemente_la_actividad',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'es', countryCode: 'NI'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
