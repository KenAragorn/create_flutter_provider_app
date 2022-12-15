import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:noteapp/flavor.dart';
import 'package:noteapp/my_app.dart';
import 'package:noteapp/providers/auth_provider.dart';
import 'package:noteapp/providers/language_provider.dart';
import 'package:noteapp/providers/theme_provider.dart';
import 'package:noteapp/services/firestore_database.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) async {
    runApp(
      /*
      * MultiProvider for top services that do not depends on any runtime values
      * such as user uid/email.
       */
      MultiProvider(
        providers: DependencyInjector.instance.providers,
        ],
        child: MyApp(
          databaseBuilder: (_, uid) => FirestoreDatabase(uid: uid),
          key: Key('MyApp'),
        ),
      ),
    );
  });
}

class DependencyInjector {
  static DependencyInjector? _instance;

  static DependencyInjector get instance {
    _instance ??= DependencyInjector._init();
    return _instance!;
  }
  
  DependencyInjector._init() {
  }


 List<ChangeNotifierProvider<ChangeNotifier>> get providers => [
   Provider<Flavor>.value(value: Flavor.dev),
        ChangeNotifierProvider<ThemeProvider>(
            create: (context) => ThemeProvider()),
        ChangeNotifierProvider<AuthProvider>(
            create: (context) => AuthProvider()),
        ChangeNotifierProvider<LanguageProvider>(
            create: (context) => LanguageProvider()),
      ];
