import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthState {
  AuthState();
}

class AuthenticationInitial extends AuthState {}

class UserLogged implements AuthState {
  UserLogged(this.firebaseUser);

  final User firebaseUser;
}

class UserNeedsToLogIn implements AuthState {}

class Logout implements AuthState {}

class AuthenticationFailure extends AuthState {}
