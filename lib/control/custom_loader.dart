import 'package:flutter/material.dart';
import 'package:flutter_zartek_test/utils/app_color.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColor.themeColor)));
  }
}
