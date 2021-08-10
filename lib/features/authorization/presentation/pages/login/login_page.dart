import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_flutter_app/features/authorization/presentation/bloc/login_bloc/login_bloc.dart';
import 'package:recipe_flutter_app/features/authorization/presentation/pages/login/login_form.dart';

import '../../../../../injection_container.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Container(
        child: buildBody(context),
      ),
    );
  }

  BlocProvider<LoginBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<LoginBloc>(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              SizedBox(height: 10),
              Container(child: LoginForm())
            ],
          ),
        ),
      ),
    );
  }
}
