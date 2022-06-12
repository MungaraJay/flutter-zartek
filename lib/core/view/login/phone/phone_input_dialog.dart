import 'package:flutter/material.dart';
import 'package:flutter_zartek_test/core/view_model/login/google_auth_store.dart';
import 'package:flutter_zartek_test/utils/app_color.dart';
import 'package:flutter_zartek_test/utils/app_utils.dart';

class PhoneInputDialog extends StatefulWidget {
  const PhoneInputDialog({this.googleAuthStore, Key? key}) : super(key: key);
  final GoogleAuthStore? googleAuthStore;

  @override
  State<PhoneInputDialog> createState() => _PhoneInputDialogState();
}

class _PhoneInputDialogState extends State<PhoneInputDialog> {
  TextEditingController codeController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  void dispose() {
    codeController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Phone Verification',
                style: TextStyle(
                    color: AppColor.darkTextColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w500)),
            const SizedBox(height: 16),
            Row(
              children: <Widget>[
                const Text("+"),
                const SizedBox(width: 5),
                Expanded(
                    flex: 2,
                    child: TextFormField(
                        maxLength: 2,
                        controller: codeController,
                        keyboardType: const TextInputType.numberWithOptions(
                            signed: false, decimal: false),
                        decoration: const InputDecoration(
                            hintText: '91', counterText: ''))),
                const SizedBox(width: 10),
                Expanded(
                    flex: 8,
                    child: TextFormField(
                        maxLength: 10,
                        controller: phoneController,
                        keyboardType: const TextInputType.numberWithOptions(
                            signed: false, decimal: false),
                        decoration: const InputDecoration(
                            hintText: '1234567890', counterText: ''))),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: AppColor.snackBarColor),
                        child: Text('Cancel',
                            style: TextStyle(
                                color: AppColor.whiteColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w500)))),
                const SizedBox(width: 16),
                GestureDetector(
                    onTap: () {
                      if (codeController.text.trim().length != 2) {
                        AppUtils.showSnackBar(
                            context, 'Please enter valid country code.');
                      } else if (phoneController.text.trim().length != 10) {
                        AppUtils.showSnackBar(
                            context, 'Please enter valid phone number.');
                      } else {
                        Navigator.pop(context);

                        widget.googleAuthStore?.signInWithPhoneNumber(
                            codeController.text.trim(),
                            phoneController.text.trim());
                      }
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
