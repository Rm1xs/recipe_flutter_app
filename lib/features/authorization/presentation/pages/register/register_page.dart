import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_flutter_app/features/authorization/presentation/bloc/register_bloc/register_bloc.dart';
import 'package:recipe_flutter_app/features/authorization/presentation/pages/register/register_form.dart';

import '../../../../../injection_container.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration'),
        backgroundColor: Colors.brown[400],
        centerTitle: true,
      ),
      body: Container(
        child: buildBody(context),
      ),
    );
  }

  BlocProvider<RegisterBloc> buildBody(BuildContext context) {
    return BlocProvider<RegisterBloc>(
      create: (_) => sl<RegisterBloc>(),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 20),
            Container(child: RegisterForm())
          ],
        ),
      ),
    );
  }
}
