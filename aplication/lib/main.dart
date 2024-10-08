import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:mikinder/constants/constants.dart';
import 'package:mikinder/constants/glob_keys.dart' as global;
import 'package:mikinder/constants/types_constants.dart';
import 'package:mikinder/generated/l10n.dart';
import 'package:mikinder/src/providers/preferences_provider.dart';
import 'package:mikinder/src/screens/inspections/inspections_screen.dart';
import 'package:mikinder/src/screens/instalations/instalations_screen.dart';
import 'package:mikinder/src/screens/login/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferencesProvider().init();
  final pref = PreferencesProvider();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  pref.locale = 'es';
  runApp(MyApp(pref: pref));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.pref});

  final PreferencesProvider pref;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: kNameApp,
      navigatorKey: global.navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontSize: 12),
        ),
        iconTheme: const IconThemeData(
          size: 20.0,
        ),
      ),
      initialRoute: getInitialRoute(),
      routes: {
        'login': (BuildContext context) => const LoginScreen(),
        'inspections': (BuildContext context) => InspectionsScreen(),
        'instalations': (BuildContext context) => InstalationsScreen(),
      },
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        S.delegate,
      ],
      locale: Locale(pref.locale),
      supportedLocales: S.delegate.supportedLocales,
      home: const LoginScreen(),
    );
  }

  String getInitialRoute() {
    if (pref.isAuth) {
      if (pref.user.roles.contains(TypesRol.instalator)) {
        return 'instalations';
      }
      return 'inspections';
    }

    return 'login';
  }
}
