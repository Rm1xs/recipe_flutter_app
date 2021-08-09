import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthUseCase {
  Future checkAuth();

  Future logIn(String email, String password);

  Future signUp(String email, String password);

  Future saveToken(String token);

  Future<User?> getUser();

  Future signOut();
}
