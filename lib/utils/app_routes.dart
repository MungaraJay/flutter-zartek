import 'package:flutter/material.dart';
import 'package:flutter_zartek_test/core/view/details/details_screen.dart';
import 'package:flutter_zartek_test/core/view/home/home_screen.dart';
import 'package:flutter_zartek_test/core/view/login/login_screen.dart';
import 'package:flutter_zartek_test/core/view/splash/splash_screen.dart';
import 'package:flutter_zartek_test/utils/app_constant.dart';

final Map<String, WidgetBuilder> appRoutes = {
  AppConstant.routeSplashScreen: (context) => const SplashScreen(),
  AppConstant.routeLoginScreen: (context) => const LoginScreen(),
  AppConstant.routeHomeScreen: (context) => const HomeScreen(),
  AppConstant.routeDetailScreen: (context) => const DetailsScreen(),
};
