import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:recipe_flutter_app/features/authorization/domain/repositories/auth_repository.dart';

class AuthRepositoryImplementation implements AuthRepository {
  AuthRepositoryImplementation() : _firebaseAuth = FirebaseAuth.instance;
  final FirebaseAuth _firebaseAuth;

  //final FlutterSecureStorage storage = const FlutterSecureStorage();

  @override
  Future<User?> checkAuth() async {
    try {
      final User? currentUser = _firebaseAuth.currentUser;
      //await storage.read(key: 'authToken');
      if(currentUser!.emailVerified == true) {
        return currentUser;
      }
    } on Exception {
      throw Error();
    }
  }

  @override
  Future<UserCredential> logIn(String email, String password) {
    try {
      final Future<UserCredential> user = _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      if(_firebaseAuth.currentUser!.emailVerified == true) {
        return user;
      }
      else{
        throw Error();
      }
    } on Exception {
      throw Error();
    }
  }

  @override
  Future<void> saveToken() async {
    //await storage.deleteAll();
    final String idToken = await _firebaseAuth.currentUser!.getIdToken();
    //await storage.write(key: 'authToken', value: idToken);
  }

  @override
  Future<UserCredential> signUp(String email, String password) async {
    final UserCredential userCredential =
        await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (userCredential.user != null && !userCredential.user!.emailVerified) {
      await userCredential.user!.sendEmailVerification();
      signOut();
      return userCredential;
    } else {
      final String token = await userCredential.user!.getIdToken();
      //storage.write(key: 'authToken', value: token);
      return userCredential;
    }
  }

  @override
  Future<User?> getUser() async {
    return _firebaseAuth.currentUser;
  }

  @override
  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }
}
