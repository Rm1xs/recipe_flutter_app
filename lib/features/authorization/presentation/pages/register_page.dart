import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_flutter_app/features/authorization/data/repositories/auth_repository_implementation.dart';
import 'package:recipe_flutter_app/features/authorization/domain/usecases/auth_usecase_implementation.dart';
import 'package:recipe_flutter_app/features/authorization/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:recipe_flutter_app/features/authorization/presentation/bloc/auth_bloc/auth_state.dart';
import 'package:recipe_flutter_app/features/authorization/presentation/bloc/register_bloc/register_bloc.dart';
import 'package:recipe_flutter_app/features/authorization/presentation/bloc/register_bloc/register_state.dart';
import 'package:recipe_flutter_app/features/authorization/presentation/pages/register_form.dart';

import '../../../../injection_container.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipes'),
      ),
      body: Container(
        child: buildBody(context),
      ),
    );
  }
}

BlocProvider<RegisterBloc> buildBody(BuildContext context) {
  return BlocProvider(
    create: (_) => sl<RegisterBloc>(),
    child: Center(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            SizedBox(height: 10),

            BlocBuilder<RegisterBloc, RegisterState>(
              builder: (context, state) {
                if (state is AuthenticationInitial) {
                  return Text(state.toString());
                }
                else{
                  return Text(state.toString());
                }
              },
            ),
          ],
        ),
      ),
    ),
  );
}
