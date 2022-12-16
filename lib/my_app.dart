import 'package:flutter/material.dart';
import 'package:create_flutter_provider_app/app_localizations.dart';
import 'package:create_flutter_provider_app/auth_widget_builder.dart';
import 'package:create_flutter_provider_app/constants/app_themes.dart';
import 'package:create_flutter_provider_app/flavor.dart';
import 'package:create_flutter_provider_app/models/user_model.dart';
import 'package:create_flutter_provider_app/providers/auth_provider.dart';
import 'package:create_flutter_provider_app/providers/language_provider.dart';
import 'package:create_flutter_provider_app/providers/theme_provider.dart';
import 'package:create_flutter_provider_app/routes.dart';
import 'package:create_flutter_provider_app/services/firestore_database.dart';
import 'package:create_flutter_provider_app/ui/auth/sign_in_screen.dart';
import 'package:create_flutter_provider_app/ui/home/home.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'caches/sharedpref/shared_preference_helper.dart';

class MyApp extends StatelessWidget {
  const MyApp({required Key key, required this.databaseBuilder})
      : super(key: key);

  // Expose builders for 3rd party services at the root of the widget tree
  // This is useful when mocking services while testing
  final FirestoreDatabase Function(BuildContext context, String uid)
      databaseBuilder;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (_, themeProviderRef, __) {
        //{context, data, child}
        return Consumer<LanguageProvider>(
          builder: (_, languageProviderRef, __) {
            return 
            FutureBuilder(
             future: SharedPreferenceHelper.initSharedPrefs(),
             builder: (_, __) => AuthWidgetBuilder(
              databaseBuilder: databaseBuilder,
              builder: (BuildContext context,
                  AsyncSnapshot<UserModel> userSnapshot) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  locale: languageProviderRef.appLocale,
                  //List of all supported locales
                  supportedLocales: const [
                    Locale('en', 'US'),
                    Locale('zh', 'CN'),
                    Locale('es', 'ES'),
                  ],
                  //These delegates make sure that the localization data for the proper language is loaded

                  localizationsDelegates: const [
                    //A class which loads the translations from JSON files
                    AppLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                    //Built-in localization of basic text for Material widgets (means those default Material widget such as alert dialog icon text)
                    GlobalMaterialLocalizations.delegate,
                    //Built-in localization for text direction LTR/RTL
                    GlobalWidgetsLocalizations.delegate,
                  ],
                  
                  //return a locale which will be used by the app
                  localeResolutionCallback: (locale, supportedLocales) {
                    //check if the current device locale is supported or not
                    for (var supportedLocale in supportedLocales) {
                      if (supportedLocale.languageCode ==
                              locale?.languageCode ||
                          supportedLocale.countryCode == locale?.countryCode) {
                        return supportedLocale;
                      }
                    }
                    //if the locale from the mobile device is not supported yet,
                    //user the first one from the list (in our case, that will be English)
                    return supportedLocales.first;
                  },
                  title: Provider.of<Flavor>(context).toString(),
                  routes: Routes.routes,
                  theme: AppThemes.lightTheme,
                  darkTheme: AppThemes.darkTheme,
                  themeMode: themeProviderRef.isDarkModeOn
                      ? ThemeMode.dark
                      : ThemeMode.light,
                  home: Consumer<AuthProvider>(
                    builder: (_, authProviderRef, __) {
                      if (userSnapshot.connectionState ==
                          ConnectionState.active) {
                      return userSnapshot.data?.uid != 'null'
                            ? HomeScreen()
                            : const SignInScreen();
                      }

                      return const Material(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                );
              },
              key: const Key('AuthWidget'),
            )
            );
          },
        );
      },
    );
  }
}
