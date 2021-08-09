import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_flutter_app/features/authorization/domain/usecases/auth_usecase_implementation.dart';
import 'package:recipe_flutter_app/features/authorization/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:recipe_flutter_app/features/authorization/presentation/bloc/auth_bloc/auth_state.dart';
import 'package:recipe_flutter_app/features/authorization/presentation/bloc/register_bloc/register_bloc.dart';
import 'package:recipe_flutter_app/features/authorization/presentation/pages/register_form.dart';

import '../../../../injection_container.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Container(child: Text('dg'));
  }
}
