import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppTranslations implements WidgetsLocalizations {
  const AppTranslations();

  static AppTranslations? current;

  // Helper method to keep the code in the widgets concise Localizations are accessed using an InheritedWidget "of" syntax
  static AppTranslations? of(BuildContext context) {
    return Localizations.of<AppTranslations>(context, AppTranslations);
  }

  // Static member to have a simple access to the delegate from the MaterialApp
  static const LocalizationsDelegate<AppTranslations> delegate =
      _TranslationsDelegate();

  @override
  TextDirection get textDirection => TextDirection.ltr;

  String get appName => 'Zartek';
  String get strNoMenuFound => 'No Menus Found.';
  String get strRetry => 'Retry';
}

class _TranslationsDelegate extends LocalizationsDelegate<AppTranslations> {
  const _TranslationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en'].contains(locale.languageCode);
  }

  @override
  Future<AppTranslations> load(Locale locale) async {
    AppTranslations.current = const AppTranslations();

    return SynchronousFuture<AppTranslations>(AppTranslations.current!);
  }

  @override
  bool shouldReload(_TranslationsDelegate old) => false;
}
