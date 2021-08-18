import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthUseCase {
  Future<User?> checkAuth();

  Future<UserCredential> logIn(String email, String password);

  Future<UserCredential> signUp(String email, String password);

  bool checkEmail();

  Future<void> saveToken();

  Future<User?> getUser();

  Future<void> signOut();
}
