abstract class AuthRemoteDataSource {
  Future checkAuth();

  Future logIn(String email, String password);

  Future signUp(String email, String password);

  Future saveToken(String token);
}

