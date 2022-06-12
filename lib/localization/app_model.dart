import 'dart:developer' as logger;

import 'package:flutter/material.dart';

class AppModel with ChangeNotifier {
  bool isLoading = true;
  static const Locale enLocale = Locale('en');
  Locale? _appLocale;

  Locale? get appLocal {
    if (_appLocale == null) return AppModel.enLocale;
    return _appLocale;
  }

  AppModel() {
    setupInitial();
  }

  // List<Locale> get supportedLocales => [enLocale, arLocale, zhLocale];
  List<Locale> get supportedLocales => [enLocale];

  Future setupInitial() async {
    logger.log('Perform Initial Setup');
    _appLocale = enLocale;

    isLoading = false;
    notifyListeners();
  }
}
