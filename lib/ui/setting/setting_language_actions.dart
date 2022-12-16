import 'package:flutter/material.dart';
import 'package:create_flutter_provider_app/app_localizations.dart';
import 'package:create_flutter_provider_app/providers/language_provider.dart';
import 'package:provider/provider.dart';

enum LanguagesActions { english, chinese, spanish }

class SettingLanguageActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LanguageProvider languageProvider = Provider.of(context);
    Locale _appCurrentLocale = languageProvider.appLocale;

    return PopupMenuButton<LanguagesActions>(
      icon: Icon(Icons.language),
      onSelected: (LanguagesActions result) {
        switch (result) {
          case LanguagesActions.english:
            languageProvider.updateLanguage("en");
            break;
          case LanguagesActions.chinese:
            languageProvider.updateLanguage("zh");
            break;
          case LanguagesActions.spanish:
            languageProvider.updateLanguage("es");
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<LanguagesActions>>[
        PopupMenuItem<LanguagesActions>(
          value: LanguagesActions.english,
          enabled: _appCurrentLocale == Locale("en") ? false : true,
          child: Text(AppLocalizations.of(context)
              .translate("settingPopUpToggleEnglish")),
        ),
        PopupMenuItem<LanguagesActions>(
          value: LanguagesActions.chinese,
          enabled: _appCurrentLocale == Locale("zh") ? false : true,
          child: Text(AppLocalizations.of(context)
              .translate("settingPopUpToggleChinese")),
        ),
        PopupMenuItem<LanguagesActions>(
          value: LanguagesActions.spanish,
          enabled: _appCurrentLocale == Locale("es") ? false : true,
          child: Text(AppLocalizations.of(context)
              .translate("settingPopUpToggleSpanish")),
        ),
      ],
    );
  }
}
