class RegisterState {
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  bool get isFormValid => isEmailValid && isPasswordValid;

  RegisterState(
      {required this.isEmailValid,
      required this.isPasswordValid,
      required this.isSubmitting,
      required this.isSuccess,
      required this.isFailure});

  factory RegisterState.initial() {
    return RegisterState(
      isEmailValid: false,
      isPasswordValid: false,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory RegisterState.loading() {
    return RegisterState(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory RegisterState.failure() {
    return RegisterState(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
    );
  }

  factory RegisterState.success() {
    return RegisterState(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
    );
  }

  RegisterState updateEmail({
    required bool isEmailValid,
  }) {
    return copyWith(
      isEmailValid: isEmailValid,
      isPasswordValid: isPasswordValid,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  RegisterState updatePassword({
    required bool isPasswordValid,
  }) {
    return copyWith(
      isEmailValid: isEmailValid,
      isPasswordValid: isPasswordValid,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  RegisterState copyWith({
    required bool isEmailValid,
    required bool isPasswordValid,
    required bool isSubmitting,
    bool? isSuccess,
    bool? isFailure,
  }) {
    return RegisterState(
      isEmailValid: isEmailValid ? isEmailValid : this.isEmailValid,
      isPasswordValid:
          isPasswordValid ? isPasswordValid : this.isPasswordValid,
      isSubmitting: isSubmitting ? isSubmitting : this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }
}
