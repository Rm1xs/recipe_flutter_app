class LoginState {
  LoginState(
      {required this.isEmailValid,
      required this.isPasswordValid,
      required this.isSubmitting,
      required this.isSuccess,
      required this.isFailure});

  factory LoginState.initial() {
    return LoginState(
      isEmailValid: false,
      isPasswordValid: false,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory LoginState.loading() {
    return LoginState(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory LoginState.failure() {
    return LoginState(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
    );
  }

  factory LoginState.userNeedsToVerifyEmail() {
    return LoginState(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
    );
  }

  factory LoginState.success() {
    return LoginState(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
    );
  }

  LoginState updateEmail({
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

  LoginState updatePassword({
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

  LoginState copyWith({
    required bool isEmailValid,
    required bool isPasswordValid,
    required bool isSubmitting,
    required bool isSuccess,
    required bool isFailure,
  }) {
    return LoginState(
      isEmailValid: isEmailValid ? isEmailValid : this.isEmailValid,
      isPasswordValid: isPasswordValid ? isPasswordValid : this.isPasswordValid,
      isSubmitting: isSubmitting ? isSubmitting : this.isSubmitting,
      isSuccess: isSuccess ? this.isSuccess : this.isSuccess,
      isFailure: isFailure ? this.isFailure : this.isFailure,
    );
  }

  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  bool get isFormValid => isEmailValid && isPasswordValid;
}
