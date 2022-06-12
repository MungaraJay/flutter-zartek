import 'package:flutter/material.dart';
import 'package:flutter_zartek_test/localization/localization.dart';
import 'package:flutter_zartek_test/utils/app_color.dart';

class CustomRetryWidget extends StatelessWidget {
  const CustomRetryWidget({required this.onTap, Key? key}) : super(key: key);

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        Text(AppTranslations.of(context)!.strNoMenuFound),
        const SizedBox(height: 12),
        ElevatedButton(
            onPressed: onTap,
            child: Text(AppTranslations.of(context)!.strRetry,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColor.whiteColor)))
      ],
    ));
  }
}
