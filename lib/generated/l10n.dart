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

  /// ``
  String get Hope_App {
    return Intl.message(
      '',
      name: 'Hope_App',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get hope {
    return Intl.message(
      '',
      name: 'hope',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get Iniciar_sesion {
    return Intl.message(
      '',
      name: 'Iniciar_sesion',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get Derechos_reservados {
    return Intl.message(
      '',
      name: 'Derechos_reservados',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get Usuario {
    return Intl.message(
      '',
      name: 'Usuario',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get Contrasena {
    return Intl.message(
      '',
      name: 'Contrasena',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get Olvido_su_contrasena {
    return Intl.message(
      '',
      name: 'Olvido_su_contrasena',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get Entrar {
    return Intl.message(
      '',
      name: 'Entrar',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get Los_campos_no_pueden_estar_vacios {
    return Intl.message(
      '',
      name: 'Los_campos_no_pueden_estar_vacios',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get Ninos {
    return Intl.message(
      '',
      name: 'Ninos',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get Actividades {
    return Intl.message(
      '',
      name: 'Actividades',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get Configuracion {
    return Intl.message(
      '',
      name: 'Configuracion',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get Cerrar_sesion {
    return Intl.message(
      '',
      name: 'Cerrar_sesion',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get Ninos_asignados {
    return Intl.message(
      '',
      name: 'Ninos_asignados',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get Actividades_para_los_ninos {
    return Intl.message(
      '',
      name: 'Actividades_para_los_ninos',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get Datos_personales {
    return Intl.message(
      '',
      name: 'Datos_personales',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get Restablecer_contrasena {
    return Intl.message(
      '',
      name: 'Restablecer_contrasena',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get Correo_o_nombre_de_usuario {
    return Intl.message(
      '',
      name: 'Correo_o_nombre_de_usuario',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get Enviar_correo {
    return Intl.message(
      '',
      name: 'Enviar_correo',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get Debe_ingresar_el_nombre_de_usuario_o_correo {
    return Intl.message(
      '',
      name: 'Debe_ingresar_el_nombre_de_usuario_o_correo',
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
