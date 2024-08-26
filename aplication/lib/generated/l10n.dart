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

  /// `Notificaciones`
  String get tNotifications {
    return Intl.message(
      'Notificaciones',
      name: 'tNotifications',
      desc: '',
      args: [],
    );
  }

  /// `Acerca de`
  String get tAbout {
    return Intl.message(
      'Acerca de',
      name: 'tAbout',
      desc: '',
      args: [],
    );
  }

  /// `Buscar`
  String get lSearch {
    return Intl.message(
      'Buscar',
      name: 'lSearch',
      desc: '',
      args: [],
    );
  }

  /// `Continuar`
  String get bContinue {
    return Intl.message(
      'Continuar',
      name: 'bContinue',
      desc: '',
      args: [],
    );
  }

  /// `Ingresar`
  String get bLogin {
    return Intl.message(
      'Ingresar',
      name: 'bLogin',
      desc: '',
      args: [],
    );
  }

  /// `Iniciar sesión`
  String get bSignin {
    return Intl.message(
      'Iniciar sesión',
      name: 'bSignin',
      desc: '',
      args: [],
    );
  }

  /// `¿Olvidaste tu contraseña?`
  String get lForgetYourPassword {
    return Intl.message(
      '¿Olvidaste tu contraseña?',
      name: 'lForgetYourPassword',
      desc: '',
      args: [],
    );
  }

  /// `¿Es tu primera vez en Mikinder?`
  String get lNoAccount {
    return Intl.message(
      '¿Es tu primera vez en Mikinder?',
      name: 'lNoAccount',
      desc: '',
      args: [],
    );
  }

  /// `Registrate aqui`
  String get bSignup {
    return Intl.message(
      'Registrate aqui',
      name: 'bSignup',
      desc: '',
      args: [],
    );
  }

  /// `Recuperar cuenta`
  String get bRecoverAccount {
    return Intl.message(
      'Recuperar cuenta',
      name: 'bRecoverAccount',
      desc: '',
      args: [],
    );
  }

  /// `Guardar`
  String get bSaveChanges {
    return Intl.message(
      'Guardar',
      name: 'bSaveChanges',
      desc: '',
      args: [],
    );
  }

  /// `Subir`
  String get bUpload {
    return Intl.message(
      'Subir',
      name: 'bUpload',
      desc: '',
      args: [],
    );
  }

  /// `Cancelar`
  String get bCancel {
    return Intl.message(
      'Cancelar',
      name: 'bCancel',
      desc: '',
      args: [],
    );
  }

  /// `Confirmar`
  String get bConfirm {
    return Intl.message(
      'Confirmar',
      name: 'bConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Finalizar`
  String get bFinish {
    return Intl.message(
      'Finalizar',
      name: 'bFinish',
      desc: '',
      args: [],
    );
  }

  /// `Aceptar`
  String get bAccept {
    return Intl.message(
      'Aceptar',
      name: 'bAccept',
      desc: '',
      args: [],
    );
  }

  /// `Hecho`
  String get bDone {
    return Intl.message(
      'Hecho',
      name: 'bDone',
      desc: '',
      args: [],
    );
  }

  /// `Cambiar contraseña`
  String get bChangePassword {
    return Intl.message(
      'Cambiar contraseña',
      name: 'bChangePassword',
      desc: '',
      args: [],
    );
  }

  /// `Regresar`
  String get bReturn {
    return Intl.message(
      'Regresar',
      name: 'bReturn',
      desc: '',
      args: [],
    );
  }

  /// `Correo electrónico`
  String get hEmail {
    return Intl.message(
      'Correo electrónico',
      name: 'hEmail',
      desc: '',
      args: [],
    );
  }

  /// `Contraseña`
  String get hPassword {
    return Intl.message(
      'Contraseña',
      name: 'hPassword',
      desc: '',
      args: [],
    );
  }

  /// `Verifica la contraseña`
  String get hPasswordConfirmation {
    return Intl.message(
      'Verifica la contraseña',
      name: 'hPasswordConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `Perfil`
  String get lProfile {
    return Intl.message(
      'Perfil',
      name: 'lProfile',
      desc: '',
      args: [],
    );
  }

  /// `Aceptar`
  String get bOk {
    return Intl.message(
      'Aceptar',
      name: 'bOk',
      desc: '',
      args: [],
    );
  }

  /// `Si`
  String get bYes {
    return Intl.message(
      'Si',
      name: 'bYes',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get bNo {
    return Intl.message(
      'No',
      name: 'bNo',
      desc: '',
      args: [],
    );
  }

  /// `Reintentar`
  String get bReTry {
    return Intl.message(
      'Reintentar',
      name: 'bReTry',
      desc: '',
      args: [],
    );
  }

  /// `Mínimo de caracteres {number}`
  String eValidatoCharacters(Object number) {
    return Intl.message(
      'Mínimo de caracteres $number',
      name: 'eValidatoCharacters',
      desc: '',
      args: [number],
    );
  }

  /// `El formato del correo es incorrecto`
  String get eValidatoEmail {
    return Intl.message(
      'El formato del correo es incorrecto',
      name: 'eValidatoEmail',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'es'),
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
