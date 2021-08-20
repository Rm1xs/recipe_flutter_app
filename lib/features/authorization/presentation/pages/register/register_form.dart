import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_flutter_app/features/authorization/presentation/controller/auth_controller.dart';

class RegisterForm extends StatelessWidget {
  RegisterForm({Key? key}) : super(key: key);

  final AuthController _controller = Get.find();
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;


  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: _emailController,
          decoration: const InputDecoration(
            icon: Icon(Icons.email),
            labelText: 'Email',
          ),
          keyboardType: TextInputType.emailAddress,
          autocorrect: false,
        ),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: _passwordController,
          decoration: const InputDecoration(
            icon: Icon(Icons.lock),
            labelText: 'Password',
            hintText: 'Enter your password',
          ),
          obscureText: true,
          autocorrect: true,
        ),
        const SizedBox(
          height: 30,
        ),
        ElevatedButton(
          onPressed: () {
            _controller.signUp(_emailController.text, _passwordController.text);
          },
          child: const Text('Register'),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
