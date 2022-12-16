import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:create_flutter_provider_app/flavor.dart';
import 'package:create_flutter_provider_app/my_app.dart';
import 'package:create_flutter_provider_app/providers/auth_provider.dart';
import 'package:create_flutter_provider_app/providers/language_provider.dart';
import 'package:create_flutter_provider_app/providers/theme_provider.dart';
import 'package:create_flutter_provider_app/services/firestore_database.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'restart_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
   options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) async {
    runApp(
      /*
      * MultiProvider for top services that do not depends on any runtime values
      * such as user uid/email.
       */
      MultiProvider(
        providers: [
          Provider<Flavor>.value(value: Flavor.dev),
          ChangeNotifierProvider<ThemeProvider>(
            create: (context) => ThemeProvider(),
          ),
          ChangeNotifierProvider<AuthProvider>(
            create: (context) => AuthProvider(),
          ),
          ChangeNotifierProvider<LanguageProvider>(
            create: (context) => LanguageProvider(),
          ),
        ],
        child: RestartWidget(
          child: MyApp(
            databaseBuilder: (_, uid) => FirestoreDatabase(uid: uid),
            key: const Key('MyApp'),
          ),
        ),
      ),
    );
  });
}
