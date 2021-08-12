import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:recipe_flutter_app/features/authorization/domain/repositories/auth_repository.dart';

class AuthRepositoryImplementation implements AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final storage = new FlutterSecureStorage();

  AuthRepositoryImplementation() : _firebaseAuth = FirebaseAuth.instance;

  @override
  Future checkAuth() async {
    final currentUser = _firebaseAuth.currentUser;
    await storage.read(key: 'authToken');

    return currentUser != null;
  }

  @override
  Future<UserCredential> logIn(String email, String password) {
    return _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  @override
  Future saveToken() async {
    await storage.deleteAll();
    final idToken = await _firebaseAuth.currentUser!.getIdToken();
    await storage.write(key: 'authToken', value: idToken);
  }

  @override
  Future<UserCredential> signUp(String email, String password) async {
    final UserCredential userCredential =
        await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (userCredential.user!= null && !userCredential.user!.emailVerified) {
      await userCredential.user!.sendEmailVerification();
    }
    final token = await userCredential.user!.getIdToken();
    storage.write(key: 'authToken', value: token);
    return userCredential;
  }

  @override
  Future<User?> getUser() async {
    return await _firebaseAuth.currentUser;
  }

  @override
  Future signOut() async {
    return Future.wait([_firebaseAuth.signOut()]);
  }
}
