import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRemoteDataSource {
  Future checkAuth();

  Future logIn(String email, String password);

  Future signUp(String email, String password);

  Future saveToken(String token);

  Future<User?> getUser();

  Future signOut();
}

class AuthRemoteDataSourceImplementation implements AuthRemoteDataSource {
  final FirebaseAuth _firebaseAuth;

  AuthRemoteDataSourceImplementation()
      : _firebaseAuth = FirebaseAuth.instance;
  @override
  Future checkAuth() async {
    final currentUser = _firebaseAuth.currentUser;
    return currentUser != null;
  }

  @override
  Future logIn(String email, String password) {
    return _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  @override
  Future saveToken(String token) {
    // TODO: implement saveToken
    throw UnimplementedError();
  }

  @override
  Future signUp(String email, String password) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<User?> getUser() async {
    return _firebaseAuth.currentUser;
  }

  @override
  Future signOut() {
    return Future.wait([_firebaseAuth.signOut()]);
  }
}