import 'package:flutter/material.dart';
import 'package:recipe_flutter_app/features/authorization/presentation/pages/login/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Login'),
          backgroundColor: Colors.brown[400],
          centerTitle: true),
      body: Container(
        child: buildBody(context),
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: <Widget>[
          const SizedBox(height: 20),
          Container(child: LoginForm())
        ],
      ),
    );
  }
}
