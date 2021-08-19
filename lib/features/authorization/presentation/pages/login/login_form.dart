import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_flutter_app/features/authorization/presentation/controller/auth_controller.dart';
import 'package:recipe_flutter_app/features/authorization/presentation/pages/register/register_page.dart';

class LoginForm extends StatelessWidget {
  LoginForm({Key? key}) : super(key: key);

  final AuthController _controller = Get.find();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  double deviceHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              icon: Icon(Icons.email),
              labelText: 'Email',
            ),
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
            autocorrect: false,
          ),
          const SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.only(
              left: deviceWidth(context) * 0.25,
            ),
            child: Row(
              children: <Widget>[
                ElevatedButton(
                    onPressed: () {
                      _controller.logIn(
                          _emailController.text, _passwordController.text);
                    },
                    child: const Text('Log In')),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (_) {
                            return const RegisterPage();
                          },
                        ),
                      );
                    },
                    child: const Text('Register'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
