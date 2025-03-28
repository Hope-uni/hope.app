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

  /// `hope`
  String get Hope {
    return Intl.message(
      'hope',
      name: 'Hope',
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

  /// `© {year} Hope. All rights reserved`
  String Derechos_reservados(Object year) {
    return Intl.message(
      '© $year Hope. All rights reserved',
      name: 'Derechos_reservados',
      desc: '',
      args: [year],
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

  /// `Los campos no pueden estar vacíos`
  String get Los_campos_no_pueden_estar_vacios {
    return Intl.message(
      'Los campos no pueden estar vacíos',
      name: 'Los_campos_no_pueden_estar_vacios',
      desc: '',
      args: [],
    );
  }

  /// `Niños - Terapeuta`
  String get Ninos_terapeuta {
    return Intl.message(
      'Niños - Terapeuta',
      name: 'Ninos_terapeuta',
      desc: '',
      args: [],
    );
  }

  /// `Niños - Tutor`
  String get Ninos_tutor {
    return Intl.message(
      'Niños - Tutor',
      name: 'Ninos_tutor',
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

  /// `Niños asignados - Terapeuta`
  String get Ninos_asignados_Terapeuta {
    return Intl.message(
      'Niños asignados - Terapeuta',
      name: 'Ninos_asignados_Terapeuta',
      desc: '',
      args: [],
    );
  }

  /// `Niños asignados - Tutor`
  String get Ninos_asignados_Tutor {
    return Intl.message(
      'Niños asignados - Tutor',
      name: 'Ninos_asignados_Tutor',
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

  /// `Crear`
  String get Crear {
    return Intl.message(
      'Crear',
      name: 'Crear',
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

  /// `Editar pictograma`
  String get Editar_pictograma {
    return Intl.message(
      'Editar pictograma',
      name: 'Editar_pictograma',
      desc: '',
      args: [],
    );
  }

  /// `Actualizar pictograma`
  String get Actualizar_pictograma {
    return Intl.message(
      'Actualizar pictograma',
      name: 'Actualizar_pictograma',
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

  /// `Si, eliminar`
  String get Si_Eliminar {
    return Intl.message(
      'Si, eliminar',
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

  /// `¿Está seguro que desea eliminar el pictograma?`
  String get Esta_seguro_que_desea_eliminar_el_pictograma {
    return Intl.message(
      '¿Está seguro que desea eliminar el pictograma?',
      name: 'Esta_seguro_que_desea_eliminar_el_pictograma',
      desc: '',
      args: [],
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

  /// `Observación`
  String get Observacion {
    return Intl.message(
      'Observación',
      name: 'Observacion',
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

  /// `Quitar actividad`
  String get Quitar_actividad {
    return Intl.message(
      'Quitar actividad',
      name: 'Quitar_actividad',
      desc: '',
      args: [],
    );
  }

  /// `Agregar observación al niño`
  String get Agregar_observacion_al_nino {
    return Intl.message(
      'Agregar observación al niño',
      name: 'Agregar_observacion_al_nino',
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

  /// `Si, salir`
  String get Si_salir {
    return Intl.message(
      'Si, salir',
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

  /// `Se creó correctamente el pictograma personalizado: {namePictogram}`
  String Se_creo_correctamente_el_pictograma_personalizado(
      Object namePictogram) {
    return Intl.message(
      'Se creó correctamente el pictograma personalizado: $namePictogram',
      name: 'Se_creo_correctamente_el_pictograma_personalizado',
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

  /// `Pictogramas generales`
  String get Pictogramas_generales {
    return Intl.message(
      'Pictogramas generales',
      name: 'Pictogramas_generales',
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

  /// `Progreso general de las fases`
  String get Progreso_general_de_las_fase {
    return Intl.message(
      'Progreso general de las fases',
      name: 'Progreso_general_de_las_fase',
      desc: '',
      args: [],
    );
  }

  /// `Progreso de fase actual`
  String get progreso_de_fase_Actual {
    return Intl.message(
      'Progreso de fase actual',
      name: 'progreso_de_fase_Actual',
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

  /// `Si, guardar`
  String get Si_guardar {
    return Intl.message(
      'Si, guardar',
      name: 'Si_guardar',
      desc: '',
      args: [],
    );
  }

  /// `¿Está seguro de crear la actividad?`
  String get Esta_seguro_de_crear_la_actividad {
    return Intl.message(
      '¿Está seguro de crear la actividad?',
      name: 'Esta_seguro_de_crear_la_actividad',
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

  /// `Quitar asignación de actividad`
  String get Quitar_asignacion_de_actividad {
    return Intl.message(
      'Quitar asignación de actividad',
      name: 'Quitar_asignacion_de_actividad',
      desc: '',
      args: [],
    );
  }

  /// `¿Está seguro de quitarle la actividad?`
  String get Esta_seguro_de_quitarle_la_actividad {
    return Intl.message(
      '¿Está seguro de quitarle la actividad?',
      name: 'Esta_seguro_de_quitarle_la_actividad',
      desc: '',
      args: [],
    );
  }

  /// `a`
  String get A {
    return Intl.message(
      'a',
      name: 'A',
      desc: '',
      args: [],
    );
  }

  /// `Si, quitar`
  String get Si_Quitar {
    return Intl.message(
      'Si, quitar',
      name: 'Si_Quitar',
      desc: '',
      args: [],
    );
  }

  /// `Selección de niños para actividad`
  String get Seleccion_de_ninos_para_actividad {
    return Intl.message(
      'Selección de niños para actividad',
      name: 'Seleccion_de_ninos_para_actividad',
      desc: '',
      args: [],
    );
  }

  /// `Confirmación`
  String get Confirmacion {
    return Intl.message(
      'Confirmación',
      name: 'Confirmacion',
      desc: '',
      args: [],
    );
  }

  /// `Atrás`
  String get Atras {
    return Intl.message(
      'Atrás',
      name: 'Atras',
      desc: '',
      args: [],
    );
  }

  /// `Siguiente`
  String get Siguiente {
    return Intl.message(
      'Siguiente',
      name: 'Siguiente',
      desc: '',
      args: [],
    );
  }

  /// `Asignación exitosa`
  String get Asignacion_exitosa {
    return Intl.message(
      'Asignación exitosa',
      name: 'Asignacion_exitosa',
      desc: '',
      args: [],
    );
  }

  /// `Se asignó correctamente la actividad a los niños seleccionados`
  String get Se_asigno_correctamente_la_actividad_a_los_ninos_seleccionados {
    return Intl.message(
      'Se asignó correctamente la actividad a los niños seleccionados',
      name: 'Se_asigno_correctamente_la_actividad_a_los_ninos_seleccionados',
      desc: '',
      args: [],
    );
  }

  /// `Cambio de contraseña de`
  String get Cambio_de_contrasena_de {
    return Intl.message(
      'Cambio de contraseña de',
      name: 'Cambio_de_contrasena_de',
      desc: '',
      args: [],
    );
  }

  /// `Contraseña actual`
  String get Contrasena_actual {
    return Intl.message(
      'Contraseña actual',
      name: 'Contrasena_actual',
      desc: '',
      args: [],
    );
  }

  /// `Nueva contraseña`
  String get Nueva_contrasena {
    return Intl.message(
      'Nueva contraseña',
      name: 'Nueva_contrasena',
      desc: '',
      args: [],
    );
  }

  /// `Confirmar nueva contraseña`
  String get Confirmar_nueva_contrasena {
    return Intl.message(
      'Confirmar nueva contraseña',
      name: 'Confirmar_nueva_contrasena',
      desc: '',
      args: [],
    );
  }

  /// `Actividad`
  String get Actividad {
    return Intl.message(
      'Actividad',
      name: 'Actividad',
      desc: '',
      args: [],
    );
  }

  /// `Se actualizo correctamente la información de la actividad`
  String get Se_actualizo_correctamente_la_informacion_de_la_actividad {
    return Intl.message(
      'Se actualizo correctamente la información de la actividad',
      name: 'Se_actualizo_correctamente_la_informacion_de_la_actividad',
      desc: '',
      args: [],
    );
  }

  /// `Esta seguro de salir de la edición de la actividad`
  String get Esta_seguro_de_salir_de_la_edicion_de_la_actividad {
    return Intl.message(
      'Esta seguro de salir de la edición de la actividad',
      name: 'Esta_seguro_de_salir_de_la_edicion_de_la_actividad',
      desc: '',
      args: [],
    );
  }

  /// `Buscar por nombre de actividad`
  String get Buscar_por_nombre_de_actividad {
    return Intl.message(
      'Buscar por nombre de actividad',
      name: 'Buscar_por_nombre_de_actividad',
      desc: '',
      args: [],
    );
  }

  /// `Descripción`
  String get Descripcion {
    return Intl.message(
      'Descripción',
      name: 'Descripcion',
      desc: '',
      args: [],
    );
  }

  /// `Fase del autismo`
  String get Fase_del_autismo {
    return Intl.message(
      'Fase del autismo',
      name: 'Fase_del_autismo',
      desc: '',
      args: [],
    );
  }

  /// `Puntaje`
  String get Puntaje {
    return Intl.message(
      'Puntaje',
      name: 'Puntaje',
      desc: '',
      args: [],
    );
  }

  /// `Seleccione pictogramas de la solución`
  String get Seleccione_pictogramas_de_la_solucion {
    return Intl.message(
      'Seleccione pictogramas de la solución',
      name: 'Seleccione_pictogramas_de_la_solucion',
      desc: '',
      args: [],
    );
  }

  /// `Solución`
  String get Solucion {
    return Intl.message(
      'Solución',
      name: 'Solucion',
      desc: '',
      args: [],
    );
  }

  /// `Oración`
  String get Oracion {
    return Intl.message(
      'Oración',
      name: 'Oracion',
      desc: '',
      args: [],
    );
  }

  /// `¡Guardado con éxito!`
  String get Guardado_con_exito {
    return Intl.message(
      '¡Guardado con éxito!',
      name: 'Guardado_con_exito',
      desc: '',
      args: [],
    );
  }

  /// `La actividad se guardó correctamente`
  String get La_actividad_se_guardo_correctamente {
    return Intl.message(
      'La actividad se guardó correctamente',
      name: 'La_actividad_se_guardo_correctamente',
      desc: '',
      args: [],
    );
  }

  /// `¿Está seguro de salir de la creación de la actividad?`
  String get Esta_seguro_de_salir_de_la_creacion_de_la_actividad {
    return Intl.message(
      '¿Está seguro de salir de la creación de la actividad?',
      name: 'Esta_seguro_de_salir_de_la_creacion_de_la_actividad',
      desc: '',
      args: [],
    );
  }

  /// `Buscar por primer nombre`
  String get Buscar_por_primer_nombre {
    return Intl.message(
      'Buscar por primer nombre',
      name: 'Buscar_por_primer_nombre',
      desc: '',
      args: [],
    );
  }

  /// `Limpiar`
  String get Limpiar {
    return Intl.message(
      'Limpiar',
      name: 'Limpiar',
      desc: '',
      args: [],
    );
  }

  /// `Verificar actividad`
  String get Verificar_actividad {
    return Intl.message(
      'Verificar actividad',
      name: 'Verificar_actividad',
      desc: '',
      args: [],
    );
  }

  /// `Actividad pendiente`
  String get Actividad_pendiente {
    return Intl.message(
      'Actividad pendiente',
      name: 'Actividad_pendiente',
      desc: '',
      args: [],
    );
  }

  /// `Petición enviada`
  String get Peticion_enviada {
    return Intl.message(
      'Petición enviada',
      name: 'Peticion_enviada',
      desc: '',
      args: [],
    );
  }

  /// `Error al actualizar los permisos`
  String get Error_al_actualizar_los_permisos {
    return Intl.message(
      'Error al actualizar los permisos',
      name: 'Error_al_actualizar_los_permisos',
      desc: '',
      args: [],
    );
  }

  /// `Error no controlado`
  String get Error_no_controlado {
    return Intl.message(
      'Error no controlado',
      name: 'Error_no_controlado',
      desc: '',
      args: [],
    );
  }

  /// `Agregar observación`
  String get Agregar_observacion {
    return Intl.message(
      'Agregar observación',
      name: 'Agregar_observacion',
      desc: '',
      args: [],
    );
  }

  /// `Actividad actual`
  String get Actividad_actual {
    return Intl.message(
      'Actividad actual',
      name: 'Actividad_actual',
      desc: '',
      args: [],
    );
  }

  /// `Actividades terminadas`
  String get Actividades_terminadas {
    return Intl.message(
      'Actividades terminadas',
      name: 'Actividades_terminadas',
      desc: '',
      args: [],
    );
  }

  /// `Bienvenido - Página de inicio`
  String get Bienvenido_pagina_de_inicio {
    return Intl.message(
      'Bienvenido - Página de inicio',
      name: 'Bienvenido_pagina_de_inicio',
      desc: '',
      args: [],
    );
  }

  /// `Cambiar contraseña`
  String get Cambiar_contrasena {
    return Intl.message(
      'Cambiar contraseña',
      name: 'Cambiar_contrasena',
      desc: '',
      args: [],
    );
  }

  // skipped getter for the 'Cambio_de_contrasena_del_niño' key

  /// `No autorizado`
  String get No_autorizado {
    return Intl.message(
      'No autorizado',
      name: 'No_autorizado',
      desc: '',
      args: [],
    );
  }

  /// `No cuenta con el permiso necesario`
  String get No_cuenta_con_el_permiso_necesario {
    return Intl.message(
      'No cuenta con el permiso necesario',
      name: 'No_cuenta_con_el_permiso_necesario',
      desc: '',
      args: [],
    );
  }

  /// `El nombre de usuario no puede estar vacío`
  String get El_nombre_de_usuario_no_puede_estar_vacio {
    return Intl.message(
      'El nombre de usuario no puede estar vacío',
      name: 'El_nombre_de_usuario_no_puede_estar_vacio',
      desc: '',
      args: [],
    );
  }

  /// `El correo no puede estar vacío`
  String get El_correo_no_puede_estar_vacio {
    return Intl.message(
      'El correo no puede estar vacío',
      name: 'El_correo_no_puede_estar_vacio',
      desc: '',
      args: [],
    );
  }

  /// `El primer nombre no puede estar vacío`
  String get El_primer_nombre_no_puede_estar_vacio {
    return Intl.message(
      'El primer nombre no puede estar vacío',
      name: 'El_primer_nombre_no_puede_estar_vacio',
      desc: '',
      args: [],
    );
  }

  /// `El primer apellido no puede estar vacío`
  String get El_primer_apellido_no_puede_estar_vacio {
    return Intl.message(
      'El primer apellido no puede estar vacío',
      name: 'El_primer_apellido_no_puede_estar_vacio',
      desc: '',
      args: [],
    );
  }

  /// `La dirección no puede estar vacía`
  String get La_direccion_no_puede_estar_vacia {
    return Intl.message(
      'La dirección no puede estar vacía',
      name: 'La_direccion_no_puede_estar_vacia',
      desc: '',
      args: [],
    );
  }

  /// `La fecha de nacimiento no puede estar vacía`
  String get La_fecha_de_nacimiento_no_puede_estar_vacia {
    return Intl.message(
      'La fecha de nacimiento no puede estar vacía',
      name: 'La_fecha_de_nacimiento_no_puede_estar_vacia',
      desc: '',
      args: [],
    );
  }

  /// `El sexo no puede estar vacío`
  String get El_sexo_no_puede_estar_vacio {
    return Intl.message(
      'El sexo no puede estar vacío',
      name: 'El_sexo_no_puede_estar_vacio',
      desc: '',
      args: [],
    );
  }

  /// `Formato incorrecto de cédula (###-######-####L)`
  String get Formato_incorrecto_de_cedula {
    return Intl.message(
      'Formato incorrecto de cédula (###-######-####L)',
      name: 'Formato_incorrecto_de_cedula',
      desc: '',
      args: [],
    );
  }

  /// `El celular deber ser un numero valido y no estar vacío`
  String get El_celular_deber_ser_un_numero_valido_y_no_estar_vacio {
    return Intl.message(
      'El celular deber ser un numero valido y no estar vacío',
      name: 'El_celular_deber_ser_un_numero_valido_y_no_estar_vacio',
      desc: '',
      args: [],
    );
  }

  /// `El teléfono deber ser un numero valido y no estar vacío`
  String get El_telefono_deber_ser_un_numero_valido_y_no_estar_vacio {
    return Intl.message(
      'El teléfono deber ser un numero valido y no estar vacío',
      name: 'El_telefono_deber_ser_un_numero_valido_y_no_estar_vacio',
      desc: '',
      args: [],
    );
  }

  /// `Cargando…`
  String get Cargando {
    return Intl.message(
      'Cargando…',
      name: 'Cargando',
      desc: '',
      args: [],
    );
  }

  /// `La contraseña actual no puede estar vacía`
  String get La_contrasena_actual_no_puede_estar_vacia {
    return Intl.message(
      'La contraseña actual no puede estar vacía',
      name: 'La_contrasena_actual_no_puede_estar_vacia',
      desc: '',
      args: [],
    );
  }

  /// `La contraseña debe tener entre 8 y 30 caracteres además contener letras y números`
  String
      get La_contrasena_debe_tener_entre_caracteres_ademas_contener_letras_y_numeros {
    return Intl.message(
      'La contraseña debe tener entre 8 y 30 caracteres además contener letras y números',
      name:
          'La_contrasena_debe_tener_entre_caracteres_ademas_contener_letras_y_numeros',
      desc: '',
      args: [],
    );
  }

  /// `Las contraseñas no coinciden`
  String get Las_contrasena_no_coinciden {
    return Intl.message(
      'Las contraseñas no coinciden',
      name: 'Las_contrasena_no_coinciden',
      desc: '',
      args: [],
    );
  }

  /// `Años`
  String get Anos {
    return Intl.message(
      'Años',
      name: 'Anos',
      desc: '',
      args: [],
    );
  }

  /// `Sin terapeuta asignado`
  String get Sin_terapeuta_asignado {
    return Intl.message(
      'Sin terapeuta asignado',
      name: 'Sin_terapeuta_asignado',
      desc: '',
      args: [],
    );
  }

  /// `Grado de autismo actual`
  String get Grado_de_autismo_actual {
    return Intl.message(
      'Grado de autismo actual',
      name: 'Grado_de_autismo_actual',
      desc: '',
      args: [],
    );
  }

  /// `Fase actual`
  String get Fase_actual {
    return Intl.message(
      'Fase actual',
      name: 'Fase_actual',
      desc: '',
      args: [],
    );
  }

  /// `Sin actividad activa por el momento`
  String get Sin_actividad_activa_por_el_momento {
    return Intl.message(
      'Sin actividad activa por el momento',
      name: 'Sin_actividad_activa_por_el_momento',
      desc: '',
      args: [],
    );
  }

  /// `Puntos requeridos`
  String get Puntos_requeridos {
    return Intl.message(
      'Puntos requeridos',
      name: 'Puntos_requeridos',
      desc: '',
      args: [],
    );
  }

  /// `¡Eliminación exitosa!`
  String get Eliminacion_exitosa {
    return Intl.message(
      '¡Eliminación exitosa!',
      name: 'Eliminacion_exitosa',
      desc: '',
      args: [],
    );
  }

  /// `Se eliminó correctamente el pictograma personalizado`
  String get Se_elimino_correctamente_el_pictograma_personalizado {
    return Intl.message(
      'Se eliminó correctamente el pictograma personalizado',
      name: 'Se_elimino_correctamente_el_pictograma_personalizado',
      desc: '',
      args: [],
    );
  }

  /// `Si el nombre del pictograma no se muestra completo, puede:`
  String get Si_el_nombre_del_pictograma_no_se_muestra_completo_puede {
    return Intl.message(
      'Si el nombre del pictograma no se muestra completo, puede:',
      name: 'Si_el_nombre_del_pictograma_no_se_muestra_completo_puede',
      desc: '',
      args: [],
    );
  }

  /// `• Mantener el dedo sobre el nombre durante 1 segundo para verlo completo.`
  String
      get Mantener_el_dedo_sobre_el_nombre_durante_1_segundo_para_verlo_completo {
    return Intl.message(
      '• Mantener el dedo sobre el nombre durante 1 segundo para verlo completo.',
      name:
          'Mantener_el_dedo_sobre_el_nombre_durante_1_segundo_para_verlo_completo',
      desc: '',
      args: [],
    );
  }

  /// `• Hacer clic en el botón de editar.`
  String get Hacer_clic_en_el_boton_de_editar {
    return Intl.message(
      '• Hacer clic en el botón de editar.',
      name: 'Hacer_clic_en_el_boton_de_editar',
      desc: '',
      args: [],
    );
  }

  /// `Para ver la imagen con más detalle:`
  String get Para_ver_la_imagen_con_mas_detalle {
    return Intl.message(
      'Para ver la imagen con más detalle:',
      name: 'Para_ver_la_imagen_con_mas_detalle',
      desc: '',
      args: [],
    );
  }

  /// `• Hacer doble clic sobre la imagen.`
  String get Hacer_doble_clic_sobre_la_imagen {
    return Intl.message(
      '• Hacer doble clic sobre la imagen.',
      name: 'Hacer_doble_clic_sobre_la_imagen',
      desc: '',
      args: [],
    );
  }

  /// `Ayuda`
  String get Ayuda {
    return Intl.message(
      'Ayuda',
      name: 'Ayuda',
      desc: '',
      args: [],
    );
  }

  /// `Salir`
  String get Salir {
    return Intl.message(
      'Salir',
      name: 'Salir',
      desc: '',
      args: [],
    );
  }

  /// `El nombre de la actividad no puede estar vacío`
  String get El_nombre_de_la_actividad_no_puede_estar_vacio {
    return Intl.message(
      'El nombre de la actividad no puede estar vacío',
      name: 'El_nombre_de_la_actividad_no_puede_estar_vacio',
      desc: '',
      args: [],
    );
  }

  /// `La descripción de la actividad no puede estar vacía`
  String get La_descripcion_de_la_actividad_no_puede_estar_vacia {
    return Intl.message(
      'La descripción de la actividad no puede estar vacía',
      name: 'La_descripcion_de_la_actividad_no_puede_estar_vacia',
      desc: '',
      args: [],
    );
  }

  /// `Debe seleccionar una fase para la actividad`
  String get Debe_seleccionar_una_fase_para_la_actividad {
    return Intl.message(
      'Debe seleccionar una fase para la actividad',
      name: 'Debe_seleccionar_una_fase_para_la_actividad',
      desc: '',
      args: [],
    );
  }

  /// `Debe seleccionar al menos un pictograma para la solución`
  String get Debe_seleccionar_al_menos_un_pictograma_para_la_solucion {
    return Intl.message(
      'Debe seleccionar al menos un pictograma para la solución',
      name: 'Debe_seleccionar_al_menos_un_pictograma_para_la_solucion',
      desc: '',
      args: [],
    );
  }

  /// `Los puntos para completar la actividad no puede ser cero o estar vacío`
  String
      get Los_puntos_para_completar_la_actividad_no_puede_ser_cero_o_estar_vacio {
    return Intl.message(
      'Los puntos para completar la actividad no puede ser cero o estar vacío',
      name:
          'Los_puntos_para_completar_la_actividad_no_puede_ser_cero_o_estar_vacio',
      desc: '',
      args: [],
    );
  }

  /// `Para reordenar la solución`
  String get Para_reordenar_la_solucion {
    return Intl.message(
      'Para reordenar la solución',
      name: 'Para_reordenar_la_solucion',
      desc: '',
      args: [],
    );
  }

  /// `• Mantener el dedo sobre el pictograma de la solución para poder ordenarlo a su voluntad`
  String
      get Mantener_el_dedo_sobre_el_pictograma_de_la_solucion_para_poder_ordenarlo_a_su_voluntad {
    return Intl.message(
      '• Mantener el dedo sobre el pictograma de la solución para poder ordenarlo a su voluntad',
      name:
          'Mantener_el_dedo_sobre_el_pictograma_de_la_solucion_para_poder_ordenarlo_a_su_voluntad',
      desc: '',
      args: [],
    );
  }

  /// `Se eliminó correctamente la actividad seleccionada`
  String get Se_elimino_correctamente_la_actividad_seleccionada {
    return Intl.message(
      'Se eliminó correctamente la actividad seleccionada',
      name: 'Se_elimino_correctamente_la_actividad_seleccionada',
      desc: '',
      args: [],
    );
  }

  /// `El nombre no puede ser menor a 3 o mayor a 100 caracteres`
  String get El_nombre_no_puede_ser_menor_a_tres_o_mayor_a_cien_caracteres {
    return Intl.message(
      'El nombre no puede ser menor a 3 o mayor a 100 caracteres',
      name: 'El_nombre_no_puede_ser_menor_a_tres_o_mayor_a_cien_caracteres',
      desc: '',
      args: [],
    );
  }

  /// `La descripción no puede ser menor a 6 o mayor a 255 caracteres`
  String
      get La_descripcion_no_puede_ser_menor_a_seis_o_mayor_a_docientocincuentaycinco_caracteres {
    return Intl.message(
      'La descripción no puede ser menor a 6 o mayor a 255 caracteres',
      name:
          'La_descripcion_no_puede_ser_menor_a_seis_o_mayor_a_docientocincuentaycinco_caracteres',
      desc: '',
      args: [],
    );
  }

  /// `El nombre del usuario no puede ser menor a 3 o mayor a 15 caracteres`
  String
      get El_nombre_del_usuario_no_puede_ser_menor_a_tres_o_mayor_a_quince_caracteres {
    return Intl.message(
      'El nombre del usuario no puede ser menor a 3 o mayor a 15 caracteres',
      name:
          'El_nombre_del_usuario_no_puede_ser_menor_a_tres_o_mayor_a_quince_caracteres',
      desc: '',
      args: [],
    );
  }

  /// `El primer nombre no puede ser menor a 3 o mayor a 15 caracteres`
  String
      get El_primer_nombre_no_puede_ser_menor_a_tres_o_mayor_a_quince_caracteres {
    return Intl.message(
      'El primer nombre no puede ser menor a 3 o mayor a 15 caracteres',
      name:
          'El_primer_nombre_no_puede_ser_menor_a_tres_o_mayor_a_quince_caracteres',
      desc: '',
      args: [],
    );
  }

  /// `El primer apellido no puede ser menor a 3 o mayor a 15 caracteres`
  String
      get El_primer_apellido_no_puede_ser_menor_a_tres_o_mayor_a_quince_caracteres {
    return Intl.message(
      'El primer apellido no puede ser menor a 3 o mayor a 15 caracteres',
      name:
          'El_primer_apellido_no_puede_ser_menor_a_tres_o_mayor_a_quince_caracteres',
      desc: '',
      args: [],
    );
  }

  /// `La dirección no puede ser menor a 6 o mayor a 255 caracteres`
  String
      get La_direccion_no_puede_ser_menor_a_seis_o_mayor_a_docientocincuentaycinco_caracteres {
    return Intl.message(
      'La dirección no puede ser menor a 6 o mayor a 255 caracteres',
      name:
          'La_direccion_no_puede_ser_menor_a_seis_o_mayor_a_docientocincuentaycinco_caracteres',
      desc: '',
      args: [],
    );
  }

  /// `Formato incorrecto de correo electrónico`
  String get Formato_incorrecto_de_correo_electronico {
    return Intl.message(
      'Formato incorrecto de correo electrónico',
      name: 'Formato_incorrecto_de_correo_electronico',
      desc: '',
      args: [],
    );
  }

  /// `Personalizar pictograma`
  String get Personalizar_pictograma {
    return Intl.message(
      'Personalizar pictograma',
      name: 'Personalizar_pictograma',
      desc: '',
      args: [],
    );
  }

  /// `El nombre no puede ser menor a 3 o mayor a 60 caracteres`
  String get El_nombre_no_puede_ser_menor_a_tres_o_mayor_a_sesenta_caracteres {
    return Intl.message(
      'El nombre no puede ser menor a 3 o mayor a 60 caracteres',
      name: 'El_nombre_no_puede_ser_menor_a_tres_o_mayor_a_sesenta_caracteres',
      desc: '',
      args: [],
    );
  }

  /// `El nombre del pictograma no puede estar vacío`
  String get El_nombre_del_pictograma_no_puede_estar_vacio {
    return Intl.message(
      'El nombre del pictograma no puede estar vacío',
      name: 'El_nombre_del_pictograma_no_puede_estar_vacio',
      desc: '',
      args: [],
    );
  }

  /// `La descripción debe tener entre 6 y 255 caracteres`
  String
      get La_descripcion_debe_tener_entre_seis_y_docientocincuentaycinco_caracteres {
    return Intl.message(
      'La descripción debe tener entre 6 y 255 caracteres',
      name:
          'La_descripcion_debe_tener_entre_seis_y_docientocincuentaycinco_caracteres',
      desc: '',
      args: [],
    );
  }

  /// `Seleccione al menos a un paciente para la actividad`
  String get Seleccione_al_menos_a_un_paciente_para_la_actividad {
    return Intl.message(
      'Seleccione al menos a un paciente para la actividad',
      name: 'Seleccione_al_menos_a_un_paciente_para_la_actividad',
      desc: '',
      args: [],
    );
  }

  /// `Regresar`
  String get Regresar {
    return Intl.message(
      'Regresar',
      name: 'Regresar',
      desc: '',
      args: [],
    );
  }

  /// `Cerrar`
  String get Cerrar {
    return Intl.message(
      'Cerrar',
      name: 'Cerrar',
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
