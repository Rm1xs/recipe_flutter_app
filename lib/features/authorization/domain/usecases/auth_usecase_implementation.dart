import 'package:firebase_auth/firebase_auth.dart';
import 'package:recipe_flutter_app/core/usecases/auth_usecase.dart';
import 'package:recipe_flutter_app/features/authorization/domain/repositories/auth_repository.dart';

class AuthUseCaseImplementation implements AuthUseCase {
  final AuthRepository repository;

  AuthUseCaseImplementation(this.repository);
  @override
  Future checkAuth() async {
    return await repository.checkAuth();
  }

  @override
  Future logIn(String email, String password) async {
    return await repository.logIn(email, password);
  }

  @override
  Future saveToken(String token) async {
    return await repository.saveToken(token);
  }

  @override
  Future signUp(String email, String password) async {
    return await repository.signUp(email, password);
  }

  @override
  Future<User?> getUser() async {
    return await repository.getUser();
  }

  @override
  Future signOut() async {
    return await repository.signOut();
  }

}