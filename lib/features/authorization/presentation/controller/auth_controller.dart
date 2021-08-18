import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:recipe_flutter_app/features/authorization/data/repositories/auth_repository_implementation.dart';

class AuthController extends GetxController {
  final AuthRepositoryImplementation _userRepository =
      Get.put(AuthRepositoryImplementation());
  RxBool isLoadingWidget = false.obs;

  @override
  void onInit() {
    checkAuth();
    super.onInit();
  }

  Future<void> logIn(String email, String password) async {
    _userRepository.logIn(email, password);
  }

  Future<UserCredential> signUp(String email, String password) {
    isLoadingWidget.value = true;
    final Future<UserCredential> data = _userRepository.signUp(email, password).whenComplete(() => isLoadingWidget.value = false);
    return data;
  }

  Future<User?> checkAuth() {
    return _userRepository.checkAuth();
  }
}
