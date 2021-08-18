import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:recipe_flutter_app/core/data/datasources/secure_storage.dart';
import 'package:recipe_flutter_app/features/authorization/domain/repositories/auth_repository.dart';

class AuthRepositoryImplementation implements AuthRepository {
  AuthRepositoryImplementation() : _firebaseAuth = FirebaseAuth.instance;
  final FirebaseAuth _firebaseAuth;

  //final FlutterSecureStorage storage = const FlutterSecureStorage();
  @override
  Future<User?> checkAuth() async {
    try {
      final User? currentUser = _firebaseAuth.currentUser;
      final Box<String> box = await Hive.openBox<String>('keyStorage');
      if (box.get('key') != null) {
        return currentUser;
      } else {
        signOut();
        return currentUser;
      }
      //await storage.read(key: 'authToken');
    } on Exception {
      throw Error();
    }
  }

  @override
  Future<UserCredential> logIn(String email, String password) async {
    try {
      final Future<UserCredential> user = _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return user;
    } on Exception {
      throw Error();
    }
  }

  @override
  Future<void> saveToken() async {
    final String idToken = await _firebaseAuth.currentUser!.getIdToken();
    final Box<String> box = await Hive.openBox<String>('keyStorage');
    box.put('key', idToken);
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
      return userCredential;
    }
  }

  @override
  Future<User?> getUser() async {
    return _firebaseAuth.currentUser;
  }

  @override
  Future<void> signOut() async {
    final Box<String> box = await Hive.openBox<String>('keyStorage');
    box.clear();
    return _firebaseAuth.signOut();
  }

  @override
  bool checkEmail() {
    if (_firebaseAuth.currentUser!.emailVerified) {
      return true;
    } else {
      signOut();
      return false;
    }
  }
}
