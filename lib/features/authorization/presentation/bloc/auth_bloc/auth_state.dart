import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthState{
  AuthState();
}

class AuthenticationInitial extends AuthState {}

class AuthenticationSuccess extends AuthState {
  final User firebaseUser;

  AuthenticationSuccess(this.firebaseUser);
}


class AuthenticationFailure extends AuthState {}