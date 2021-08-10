import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRemoteDataSource {
  Future checkAuth();

  Future logIn(String email, String password);

  Future signUp(String email, String password);

  Future saveToken();

  Future<User?> getUser();

  Future signOut();
}

class AuthRemoteDataSourceImplementation implements AuthRemoteDataSource {
  final FirebaseAuth _firebaseAuth;
  //final storage = new FlutterSecureStorage();

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
  Future saveToken() async {

    final idToken = await _firebaseAuth.currentUser!.getIdToken();
    var t = idToken;
    //await storage.write(key: 'authToken', value: idToken);
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
    return await _firebaseAuth.currentUser;
  }

  @override
  Future signOut() {
    return Future.wait([_firebaseAuth.signOut()]);
  }
}