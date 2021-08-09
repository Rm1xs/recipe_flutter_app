import 'package:firebase_auth/firebase_auth.dart';
import 'package:recipe_flutter_app/core/datasources/auth_remote_datasource.dart';
import 'package:recipe_flutter_app/features/authorization/domain/repositories/auth_repository.dart';

class AuthRepositoryImplementation implements AuthRepository {

  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImplementation(this.authRemoteDataSource);
  @override
  Future checkAuth() async {
    return await authRemoteDataSource.checkAuth();
  }

  @override
  Future logIn(String email, String password) async {
    return await authRemoteDataSource.logIn(email, password);
  }

  @override
  Future saveToken(String token) async {
    return await authRemoteDataSource.saveToken(token);
  }

  @override
  Future signUp(String email, String password) async {
    return await authRemoteDataSource.signUp(email, password);
  }


  @override
  Future signOut() async {
    return await authRemoteDataSource.signOut();
  }

  @override
  Future<User?> getUser() async {
    return await authRemoteDataSource.getUser();
  }

}