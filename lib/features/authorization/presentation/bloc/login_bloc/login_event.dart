abstract class LoginEvent {}

class LoginEmailChange extends LoginEvent {
  LoginEmailChange({required this.email});

  final String email;
}

class LoginPasswordChanged extends LoginEvent {
  LoginPasswordChanged({required this.password});

  final String password;
}

class LoginWithCredentialsPressed extends LoginEvent {
  LoginWithCredentialsPressed({required this.email, required this.password});

  final String email;
  final String password;
}
