import 'package:flutter/material.dart';
import 'package:flutter_zartek_test/utils/app_color.dart';

class AppUtils {
  static void showSnackBar(BuildContext context, String message,
      {int duration = 1, SnackBarAction? action}) {
    final text = Text(message,
        style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
            color: AppColor.whiteColor));

    final snackBar = SnackBar(
        content: text,
        backgroundColor: AppColor.snackBarColor,
        duration: Duration(seconds: duration),
        action: action,
        margin: const EdgeInsets.only(left: 8, right: 8, bottom: 50),
        behavior: SnackBarBehavior.floating);

    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void showSnackBarWithKey(GlobalKey<ScaffoldState> key, String message,
      {int duration = 1, SnackBarAction? action}) {
    final text = Text(message,
        style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
            color: AppColor.whiteColor));

    final snackBar = SnackBar(
        content: text,
        backgroundColor: AppColor.snackBarColor,
        duration: Duration(seconds: duration),
        action: action,
        margin: const EdgeInsets.only(left: 8, right: 8, bottom: 50),
        behavior: SnackBarBehavior.floating);

    ScaffoldMessenger.of(key.currentContext!).removeCurrentSnackBar();
    ScaffoldMessenger.of(key.currentContext!).showSnackBar(snackBar);
  }
}
