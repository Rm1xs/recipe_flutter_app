import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:recipe_flutter_app/features/authorization/domain/repositories/auth_repository.dart';

class AuthRepositoryImplementation implements AuthRepository {
  AuthRepositoryImplementation() : _firebaseAuth = FirebaseAuth.instance;
  final FirebaseAuth _firebaseAuth;
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  @override
  Future<User?> checkAuth() async {
    final User? currentUser = _firebaseAuth.currentUser;
    await storage.read(key: 'authToken');

    return currentUser;
  }

  @override
  Future<UserCredential> logIn(String email, String password) {
    Future<UserCredential> user = _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);

    return user;
  }

  @override
  Future<void> saveToken() async {
    await storage.deleteAll();
    final String idToken = await _firebaseAuth.currentUser!.getIdToken();
    await storage.write(key: 'authToken', value: idToken);
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
      storage.write(key: 'authToken', value: token);
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
