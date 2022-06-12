enum PageState {
  initial,
  loading,
  error,
  success,
}

typedef OtpVerificationCallback = void Function(String code);
