import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:recipe_flutter_app/features/authorization/presentation/controller/auth_controller.dart';

class RegPage extends StatelessWidget {
  final AuthController _controller = Get.put(AuthController());
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();

  bool get isReadyToReg => _email.text.isNotEmpty && _pass.text.isNotEmpty;

  RegPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      appBar: AppBar(
        title: const Text('Registration'),
        backgroundColor: Colors.brown[400],
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 20),
            Container(child: _buildBody(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Builder(
      builder: (BuildContext context) => SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: _email,
              decoration: const InputDecoration(
                icon: Icon(Icons.email),
                labelText: 'Email',
              ),
              keyboardType: TextInputType.emailAddress,
              autocorrect: false,
            ),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: _pass,
              decoration: const InputDecoration(
                icon: Icon(Icons.lock),
                labelText: 'Password',
                hintText: 'Enter your password',
              ),
              obscureText: true,
              autocorrect: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => {
                if (isReadyToReg)
                  {
                    _register(context),
                  }
              },
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }

  void _register(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    _controller.signUp(_email.text, _pass.text);
  }

  final snackBar = SnackBar(
    content: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const <Widget>[
        Text('Register'),
        Icon(Icons.error),
      ],
    ),
    backgroundColor: const Color(0xffffae88),
  );
}
