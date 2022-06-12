import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_zartek_test/control/custom_icon_button.dart';
import 'package:flutter_zartek_test/core/view/login/phone/phone_input_dialog.dart';
import 'package:flutter_zartek_test/core/view_model/login/google_auth_store.dart';
import 'package:flutter_zartek_test/enums.dart';
import 'package:flutter_zartek_test/utils/app_color.dart';
import 'package:flutter_zartek_test/utils/app_constant.dart';
import 'package:flutter_zartek_test/utils/app_image.dart';
import 'package:flutter_zartek_test/utils/app_utils.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GoogleAuthStore? _googleAuthStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _googleAuthStore = Provider.of<GoogleAuthStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _googleAuthStore?.scaffoldKey,
      body: Column(
        children: [
          Expanded(
              flex: 8, child: Center(child: Image.asset(AppImage.imgFirebase))),
          Observer(
            builder: (_) => _googleAuthStore?.pageState != PageState.loading
                ? Expanded(
                    flex: 4,
                    child: Column(
                      children: [
                        CustomIconButton(
                          imgPath: AppImage.imgGoogle,
                          title: 'Google',
                          onTap: () async {
                            String? errorMessage =
                                await _googleAuthStore?.signInWithGoogle();
                            if (errorMessage?.isNotEmpty ?? false) {
                              if (mounted) {
                                AppUtils.showSnackBar(
                                    context,
                                    errorMessage ??
                                        'Google login failed. Please try again.');
                              }
                            } else {
                              if (mounted) {
                                Navigator.pushNamed(
                                    context, AppConstant.routeHomeScreen);
                              }
                            }
                          },
                          gradientStartColor: AppColor.googleGradientStartColor,
                          gradientEndColor: AppColor.googleGradientEndColor,
                        ),
                        const SizedBox(height: 12),
                        CustomIconButton(
                            imgPath: AppImage.imgPhone,
                            title: 'Phone',
                            onTap: () {
                              showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (BuildContext context) {
                                  return PhoneInputDialog(
                                      googleAuthStore: _googleAuthStore);
                                },
                              );
                            },
                            gradientStartColor:
                                AppColor.phoneGradientStartColor,
                            gradientEndColor: AppColor.phoneGradientEndColor),
                      ],
                    ),
                  )
                : const Center(child: CircularProgressIndicator()),
          ),
        ],
      ),
    );
  }
}
