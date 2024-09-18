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

  /// `Oops, algo parece haber ido mal, por favor, inténtelo de nuevo más tarde`
  String get errUnknown {
    return Intl.message(
      'Oops, algo parece haber ido mal, por favor, inténtelo de nuevo más tarde',
      name: 'errUnknown',
      desc: '',
      args: [],
    );
  }

  /// `Cerrar sesión`
  String get signOut {
    return Intl.message(
      'Cerrar sesión',
      name: 'signOut',
      desc: '',
      args: [],
    );
  }

  /// `ID`
  String get lId {
    return Intl.message(
      'ID',
      name: 'lId',
      desc: '',
      args: [],
    );
  }

  /// `Cliente`
  String get lClient {
    return Intl.message(
      'Cliente',
      name: 'lClient',
      desc: '',
      args: [],
    );
  }

  /// `Fecha de asignación`
  String get lAssignedDate {
    return Intl.message(
      'Fecha de asignación',
      name: 'lAssignedDate',
      desc: '',
      args: [],
    );
  }

  /// `Ver`
  String get bView {
    return Intl.message(
      'Ver',
      name: 'bView',
      desc: '',
      args: [],
    );
  }

  /// `Acciones`
  String get lActions {
    return Intl.message(
      'Acciones',
      name: 'lActions',
      desc: '',
      args: [],
    );
  }

  /// `Preinspecciones`
  String get lPreinspections {
    return Intl.message(
      'Preinspecciones',
      name: 'lPreinspections',
      desc: '',
      args: [],
    );
  }

  /// `Inspecciones internas`
  String get lInternalInspections {
    return Intl.message(
      'Inspecciones internas',
      name: 'lInternalInspections',
      desc: '',
      args: [],
    );
  }

  /// `Proyectos asignados`
  String get lAsignedProyects {
    return Intl.message(
      'Proyectos asignados',
      name: 'lAsignedProyects',
      desc: '',
      args: [],
    );
  }

  /// `Proyectos reasignados`
  String get lReasignedProyects {
    return Intl.message(
      'Proyectos reasignados',
      name: 'lReasignedProyects',
      desc: '',
      args: [],
    );
  }

  /// `Nombre`
  String get lName {
    return Intl.message(
      'Nombre',
      name: 'lName',
      desc: '',
      args: [],
    );
  }

  /// `Apellido`
  String get lLastName {
    return Intl.message(
      'Apellido',
      name: 'lLastName',
      desc: '',
      args: [],
    );
  }

  /// `Teléfono`
  String get lPhone {
    return Intl.message(
      'Teléfono',
      name: 'lPhone',
      desc: '',
      args: [],
    );
  }

  /// `Dirección`
  String get lAdrreess {
    return Intl.message(
      'Dirección',
      name: 'lAdrreess',
      desc: '',
      args: [],
    );
  }

  /// `Datos del usuario`
  String get lUserInfo {
    return Intl.message(
      'Datos del usuario',
      name: 'lUserInfo',
      desc: '',
      args: [],
    );
  }

  /// `Datos del proyecto`
  String get lProyectInfo {
    return Intl.message(
      'Datos del proyecto',
      name: 'lProyectInfo',
      desc: '',
      args: [],
    );
  }

  /// `Tipo de proyecto`
  String get lProyectType {
    return Intl.message(
      'Tipo de proyecto',
      name: 'lProyectType',
      desc: '',
      args: [],
    );
  }

  /// `Volumen mínimo`
  String get qMinimumVolume {
    return Intl.message(
      'Volumen mínimo',
      name: 'qMinimumVolume',
      desc: '',
      args: [],
    );
  }

  /// `Alimentación de aire`
  String get qAirSupply {
    return Intl.message(
      'Alimentación de aire',
      name: 'qAirSupply',
      desc: '',
      args: [],
    );
  }

  /// `Salida de aire`
  String get qAirOutlet {
    return Intl.message(
      'Salida de aire',
      name: 'qAirOutlet',
      desc: '',
      args: [],
    );
  }

  /// `Aireación rápida`
  String get qRapidAeration {
    return Intl.message(
      'Aireación rápida',
      name: 'qRapidAeration',
      desc: '',
      args: [],
    );
  }

  /// `Rechazar`
  String get bReject {
    return Intl.message(
      'Rechazar',
      name: 'bReject',
      desc: '',
      args: [],
    );
  }

  /// `Aprobar`
  String get bAprove {
    return Intl.message(
      'Aprobar',
      name: 'bAprove',
      desc: '',
      args: [],
    );
  }

  /// `Cargar isométrico`
  String get bUploadIsometric {
    return Intl.message(
      'Cargar isométrico',
      name: 'bUploadIsometric',
      desc: '',
      args: [],
    );
  }

  /// `Cargar plano de planta`
  String get bUploadFloorPlan {
    return Intl.message(
      'Cargar plano de planta',
      name: 'bUploadFloorPlan',
      desc: '',
      args: [],
    );
  }

  /// `Ver isométrico`
  String get bViewIsometric {
    return Intl.message(
      'Ver isométrico',
      name: 'bViewIsometric',
      desc: '',
      args: [],
    );
  }

  /// `Ver plano de planta`
  String get bViewFloorPlan {
    return Intl.message(
      'Ver plano de planta',
      name: 'bViewFloorPlan',
      desc: '',
      args: [],
    );
  }

  /// `Isométrico`
  String get lIsometric {
    return Intl.message(
      'Isométrico',
      name: 'lIsometric',
      desc: '',
      args: [],
    );
  }

  /// `Plano de planta`
  String get lFloorPlan {
    return Intl.message(
      'Plano de planta',
      name: 'lFloorPlan',
      desc: '',
      args: [],
    );
  }

  /// `Materiales`
  String get lMaterials {
    return Intl.message(
      'Materiales',
      name: 'lMaterials',
      desc: '',
      args: [],
    );
  }

  /// `Seleccione una foto`
  String get bSelectPhoto {
    return Intl.message(
      'Seleccione una foto',
      name: 'bSelectPhoto',
      desc: '',
      args: [],
    );
  }

  /// `Tomar una foto`
  String get bTakePhoto {
    return Intl.message(
      'Tomar una foto',
      name: 'bTakePhoto',
      desc: '',
      args: [],
    );
  }

  /// `Carga exitosa`
  String get lLoadSuccess {
    return Intl.message(
      'Carga exitosa',
      name: 'lLoadSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Actualización exitosa`
  String get lUpdateSuccess {
    return Intl.message(
      'Actualización exitosa',
      name: 'lUpdateSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Eliminar`
  String get bDelete {
    return Intl.message(
      'Eliminar',
      name: 'bDelete',
      desc: '',
      args: [],
    );
  }

  /// `Continuar`
  String get bNext {
    return Intl.message(
      'Continuar',
      name: 'bNext',
      desc: '',
      args: [],
    );
  }

  /// `Observaciones`
  String get lObservations {
    return Intl.message(
      'Observaciones',
      name: 'lObservations',
      desc: '',
      args: [],
    );
  }

  /// `Refrescar`
  String get bReload {
    return Intl.message(
      'Refrescar',
      name: 'bReload',
      desc: '',
      args: [],
    );
  }

  /// `Solicitar inspección`
  String get bRequestInspection {
    return Intl.message(
      'Solicitar inspección',
      name: 'bRequestInspection',
      desc: '',
      args: [],
    );
  }

  /// `Actualizar`
  String get bUpdate {
    return Intl.message(
      'Actualizar',
      name: 'bUpdate',
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
