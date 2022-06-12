import 'package:flutter/material.dart';
import 'package:flutter_zartek_test/utils/app_color.dart';

class OrderPlacedDialog extends StatelessWidget {
  const OrderPlacedDialog(
      {required this.title,
      required this.orderPlacedCompleteActionCallback,
      Key? key})
      : super(key: key);

  final String title;
  final VoidCallback orderPlacedCompleteActionCallback;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title,
                style: TextStyle(
                    color: AppColor.blackColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);

                    orderPlacedCompleteActionCallback();
                  },
                  child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: AppColor.snackBarColor),
                      child: Text('OK',
                          style: TextStyle(
                              color: AppColor.whiteColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500)))),
            )
          ],
        ),
      ),
    );
  }
}
