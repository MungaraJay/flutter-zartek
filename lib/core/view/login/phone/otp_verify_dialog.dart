import 'package:flutter/material.dart';
import 'package:flutter_zartek_test/enums.dart';
import 'package:flutter_zartek_test/utils/app_color.dart';
import 'package:flutter_zartek_test/utils/app_utils.dart';

class OTPVerifyDialog extends StatefulWidget {
  const OTPVerifyDialog(
      {required this.code,
      required this.phoneNumber,
      required this.completeActionCallback,
      Key? key})
      : super(key: key);

  final String code;
  final String phoneNumber;
  final OtpVerificationCallback completeActionCallback;

  @override
  State<OTPVerifyDialog> createState() => _OTPVerifyDialogState();
}

class _OTPVerifyDialogState extends State<OTPVerifyDialog> {
  TextEditingController otpController = TextEditingController();

  @override
  void dispose() {
    otpController.dispose();
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
            Text('OTP sent to +${widget.code}${widget.phoneNumber}',
                style: TextStyle(
                    color: AppColor.darkTextColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w500)),
            const SizedBox(height: 16),
            TextFormField(
                controller: otpController,
                keyboardType: const TextInputType.numberWithOptions(
                    signed: false, decimal: false),
                maxLength: 6,
                decoration: const InputDecoration(
                    counterText: " ",
                    hintText: "Enter 6 digit verification code")),
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
                      if (otpController.text.trim().length != 6) {
                        AppUtils.showSnackBar(
                            context, 'Please enter valid otp code.');
                      } else {
                        Navigator.pop(context);

                        widget
                            .completeActionCallback(otpController.text.trim());
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
