// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'google_auth_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$GoogleAuthStore on _GoogleAuthStore, Store {
  late final _$scaffoldKeyAtom =
      Atom(name: '_GoogleAuthStore.scaffoldKey', context: context);

  @override
  GlobalKey<ScaffoldState> get scaffoldKey {
    _$scaffoldKeyAtom.reportRead();
    return super.scaffoldKey;
  }

  @override
  set scaffoldKey(GlobalKey<ScaffoldState> value) {
    _$scaffoldKeyAtom.reportWrite(value, super.scaffoldKey, () {
      super.scaffoldKey = value;
    });
  }

  late final _$pageStateAtom =
      Atom(name: '_GoogleAuthStore.pageState', context: context);

  @override
  PageState get pageState {
    _$pageStateAtom.reportRead();
    return super.pageState;
  }

  @override
  set pageState(PageState value) {
    _$pageStateAtom.reportWrite(value, super.pageState, () {
      super.pageState = value;
    });
  }

  late final _$firebaseUserAtom =
      Atom(name: '_GoogleAuthStore.firebaseUser', context: context);

  @override
  User? get firebaseUser {
    _$firebaseUserAtom.reportRead();
    return super.firebaseUser;
  }

  @override
  set firebaseUser(User? value) {
    _$firebaseUserAtom.reportWrite(value, super.firebaseUser, () {
      super.firebaseUser = value;
    });
  }

  late final _$_verificationCodeAtom =
      Atom(name: '_GoogleAuthStore._verificationCode', context: context);

  @override
  String get _verificationCode {
    _$_verificationCodeAtom.reportRead();
    return super._verificationCode;
  }

  @override
  set _verificationCode(String value) {
    _$_verificationCodeAtom.reportWrite(value, super._verificationCode, () {
      super._verificationCode = value;
    });
  }

  late final _$signInWithGoogleAsyncAction =
      AsyncAction('_GoogleAuthStore.signInWithGoogle', context: context);

  @override
  Future<String> signInWithGoogle() {
    return _$signInWithGoogleAsyncAction.run(() => super.signInWithGoogle());
  }

  late final _$signInWithPhoneNumberAsyncAction =
      AsyncAction('_GoogleAuthStore.signInWithPhoneNumber', context: context);

  @override
  Future<void> signInWithPhoneNumber(String code, String number) {
    return _$signInWithPhoneNumberAsyncAction
        .run(() => super.signInWithPhoneNumber(code, number));
  }

  late final _$verifyOTPAsyncAction =
      AsyncAction('_GoogleAuthStore.verifyOTP', context: context);

  @override
  Future<void> verifyOTP(String otp) {
    return _$verifyOTPAsyncAction.run(() => super.verifyOTP(otp));
  }

  late final _$_GoogleAuthStoreActionController =
      ActionController(name: '_GoogleAuthStore', context: context);

  @override
  void updatePageState(PageState state, String message) {
    final _$actionInfo = _$_GoogleAuthStoreActionController.startAction(
        name: '_GoogleAuthStore.updatePageState');
    try {
      return super.updatePageState(state, message);
    } finally {
      _$_GoogleAuthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
scaffoldKey: ${scaffoldKey},
pageState: ${pageState},
firebaseUser: ${firebaseUser}
    ''';
  }
}
