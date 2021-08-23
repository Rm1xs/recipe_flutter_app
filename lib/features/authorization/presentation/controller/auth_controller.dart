import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:recipe_flutter_app/features/authorization/data/repositories/auth_repository_implementation.dart';
import 'package:recipe_flutter_app/features/authorization/presentation/pages/login/login_page.dart';
import 'package:recipe_flutter_app/features/recipe/presentation/recipe/pages/recipe_page.dart';

class AuthController extends GetxController {
  final AuthRepositoryImplementation _userRepository =
  Get.put(AuthRepositoryImplementation());

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> logIn(String email, String password) async {
    _userRepository.logIn(email, password).whenComplete(() {}).then((
        UserCredential value) {
      if (value.user!.emailVerified == true) {
        Get.rawSnackbar(
            message: 'Login success', backgroundColor: Colors.green);
        Get.offAll<RecipePage>(RecipePage());
      } else {
        Get.rawSnackbar(
            message: 'Mail not confirmed!', backgroundColor: Colors.redAccent);
        signOut();
      }
    }).onError((Object? error, StackTrace stackTrace) {
      Get.rawSnackbar(message: error.toString());
    });
  }

  Future<void> signUp(String email, String password) async {
    Get.rawSnackbar(
        message: 'Register loading',
        showProgressIndicator: true,
        duration: const Duration(days: 1));
    try {
      _userRepository.signUp(email, password).whenComplete(() {
        Get.back<void>();
        Get.back<void>();
      });
    } catch(e){
      Get.rawSnackbar(message: e.toString(), backgroundColor: Colors.redAccent);
      signOut();
    }
  }

  Future<void> checkAuth() async {
    _userRepository
        .checkAuth()
        .whenComplete(() => Get.off<RecipePage>(RecipePage()))
        .onError((Object? error, StackTrace stackTrace) =>
        Get.off(const LoginPage()));
  }

  Future<void> signOut() {
    return _userRepository.signOut();
  }
}
