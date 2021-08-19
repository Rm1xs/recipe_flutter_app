import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_flutter_app/core/presentation/animation/scale_route.dart';
import 'package:recipe_flutter_app/features/authorization/presentation/controller/auth_controller.dart';
import 'package:recipe_flutter_app/features/authorization/presentation/pages/login/login_page.dart';

class SignOutForm extends StatelessWidget {
  SignOutForm({Key? key}) : super(key: key);

  final AuthController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
      child: Container(
        width: 120,
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(primary: Colors.brown[400]),
          onPressed: () {
            _controller.signOut();
            _onFormSubmitted(context);
          },
          icon: const Icon(
            Icons.exit_to_app,
            color: Colors.white,
          ),
          label: const Text('Exit'),
        ),
      ),
    );
  }

  void _onFormSubmitted(BuildContext context) {
    Navigator.pushAndRemoveUntil<void>(
      context,
      ScaleRoute(
        page: const LoginPage(),
      ),
      (Route<dynamic> route) => false,
    );
  }
}
