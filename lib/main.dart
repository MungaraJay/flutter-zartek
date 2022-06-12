import 'dart:async';
import 'dart:developer' as logger;

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_zartek_test/core/view_model/login/google_auth_store.dart';
import 'package:flutter_zartek_test/core/view_model/menu/menu_store.dart';
import 'package:flutter_zartek_test/localization/app_model.dart';
import 'package:flutter_zartek_test/localization/cupertino_localisation_delegate.dart';
import 'package:flutter_zartek_test/localization/localization.dart';
import 'package:flutter_zartek_test/utils/app_color.dart';
import 'package:flutter_zartek_test/utils/app_constant.dart';
import 'package:flutter_zartek_test/utils/app_routes.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark));

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runZonedGuarded<Future<void>>(() async {
    SystemChrome.setPreferredOrientations(
            [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
        .then((_) {
      runApp(MyApp());
    });
  }, (err, trace) {
    logger.log('dart error : $err : $trace');
  });
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final AppModel _appModel = AppModel();
  final GoogleAuthStore _googleAuthStore = GoogleAuthStore();
  final MenuStore _menuStore = MenuStore();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppModel>.value(value: _appModel),
        Provider<GoogleAuthStore>(create: (_) => _googleAuthStore),
        Provider<MenuStore>(create: (_) => _menuStore),
      ],
      child: Consumer<AppModel>(
        builder: (context, value, child) {
          if (value.isLoading) {
            return Container(
                color: AppColor.whiteColor, alignment: Alignment.center);
          } else {
            return MaterialApp(
                debugShowCheckedModeBanner: false,
                onGenerateTitle: (BuildContext context) =>
                    AppTranslations.of(context)!.appName,
                localizationsDelegates: const [
                  AppTranslations.delegate,
                  FallbackCupertinoLocalisationsDelegate(),
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                ],
                locale: value.appLocal,
                supportedLocales: value.supportedLocales,
                theme: ThemeData(
                    primarySwatch: AppColor.colorBlue,
                    fontFamily: AppConstant.fontFamilyLato),
                initialRoute: AppConstant.routeSplashScreen,
                routes: appRoutes);
          }
        },
      ),
    );
  }
}
