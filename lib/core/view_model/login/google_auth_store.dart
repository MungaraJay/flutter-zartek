import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zartek_test/core/view/login/phone/otp_verify_dialog.dart';
import 'package:flutter_zartek_test/enums.dart';
import 'package:flutter_zartek_test/helpers/google_helper.dart';
import 'package:flutter_zartek_test/utils/app_constant.dart';
import 'package:flutter_zartek_test/utils/app_utils.dart';
import 'package:mobx/mobx.dart';

part 'google_auth_store.g.dart';

class GoogleAuthStore = _GoogleAuthStore with _$GoogleAuthStore;

abstract class _GoogleAuthStore with Store {
  @observable
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @observable
  PageState pageState = PageState.initial;

  @action
  void updatePageState(PageState state, String message) {
    pageState = state;

    AppUtils.showSnackBarWithKey(scaffoldKey, message);
  }

  @observable
  User? firebaseUser;

  @action
  Future<String> signInWithGoogle() async {
    try {
      User? user = await GoogleHelper.signInWithGoogle();
      if (user != null) {
        firebaseUser = user;

        return '';
      } else {
        return 'Google login failed. Please try again.';
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        return 'Account already registered with other provider.';
      } else if (e.code == 'credential-already-in-use') {
        return 'Credentials are already in use.';
      } else if (e.code == 'email-already-in-use') {
        return 'Email already in use.';
      } else if (e.code == 'network-request-failed') {
        return 'Please check your internet connection and try again.';
      } else if (e.code == 'wrong-password') {
        return 'Please enter valid password.';
      } else {
        return 'Google login failed. Please try again.';
      }
    } catch (e) {
      return 'Google login failed. Please try again.';
    }
  }

  @observable
  String _verificationCode = '';

  @action
  Future<void> signInWithPhoneNumber(String code, String number) async {
    String phone = '+$code$number';
    pageState = PageState.loading;

    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: phone,
          verificationCompleted: (PhoneAuthCredential credential) async {
            await FirebaseAuth.instance
                .signInWithCredential(credential)
                .then((value) async {
              _verificationCode = '';
              updatePageState(
                  PageState.success, 'Phone verified successfully.');

              Navigator.pushNamedAndRemoveUntil(scaffoldKey.currentContext!,
                  AppConstant.routeHomeScreen, (route) => false);
            });
          },
          verificationFailed: (FirebaseAuthException e) {
            _verificationCode = '';
            if (e.code == 'invalid-phone-number') {
              updatePageState(
                  PageState.error, 'Provided phone number is not valid.');
            } else {
              updatePageState(PageState.error,
                  'Phone verification failed. Please try again.');
            }
          },
          codeSent: (String verificationId, int? forceResendingToken) {
            _verificationCode = verificationId;
            updatePageState(PageState.success, 'OTP sent successfully.');

            showDialog(
              barrierDismissible: false,
              context: scaffoldKey.currentContext!,
              builder: (BuildContext cont) {
                return OTPVerifyDialog(
                    code: code,
                    phoneNumber: number,
                    completeActionCallback: (String code) {
                      verifyOTP(code);
                    });
              },
            );
          },
          codeAutoRetrievalTimeout: (String verificationID) {
            _verificationCode = verificationID;
          },
          timeout: const Duration(seconds: 60));
    } catch (e) {
      _verificationCode = '';

      updatePageState(
          PageState.error, 'Phone verification failed. Please try again.');
    }
  }

  @action
  Future<void> verifyOTP(String otp) async {
    pageState = PageState.loading;
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
          verificationId: _verificationCode, smsCode: otp);
      final User? user = await FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((authResult) => authResult.user);

      if (user != null) {
        firebaseUser = user;

        _verificationCode = '';
        updatePageState(PageState.success, 'Phone verified successfully.');
        Navigator.pushNamedAndRemoveUntil(scaffoldKey.currentContext!,
            AppConstant.routeHomeScreen, (route) => false);
      } else {
        _verificationCode = '';

        updatePageState(
            PageState.error, 'Phone verification failed. Please try again.');
      }
    } on FirebaseAuthException catch (error) {
      _verificationCode = '';

      updatePageState(PageState.error,
          error.message ?? 'Phone verification failed. Please try again.');
    } catch (error) {
      _verificationCode = '';

      updatePageState(
          PageState.error, 'Phone verification failed. Please try again.');
    }
  }
}
