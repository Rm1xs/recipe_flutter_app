abstract class AuthUseCase<String> {
  Future checkAuth();

  Future logIn();

  Future signUp();

  Future saveToken();
}
