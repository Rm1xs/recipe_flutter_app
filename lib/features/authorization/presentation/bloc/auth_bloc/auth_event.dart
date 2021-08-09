abstract class AuthEvent{}

class AuthenticationStarted extends AuthEvent {}

class AuthenticationLoggedIn extends AuthEvent {}

class AuthenticationLoggedOut extends AuthEvent {}