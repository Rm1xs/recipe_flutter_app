abstract class RegisterEvent {}

class RegisterEmailChanged extends RegisterEvent {
  RegisterEmailChanged({required this.email});

  final String email;
}

class RegisterPasswordChanged extends RegisterEvent {
  RegisterPasswordChanged({required this.password});

  final String password;
}

class RegisterSubmitted extends RegisterEvent {
  RegisterSubmitted({required this.email, required this.password});

  final String email;
  final String password;
}
