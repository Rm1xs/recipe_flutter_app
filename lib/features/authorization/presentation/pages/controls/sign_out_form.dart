import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_flutter_app/core/presentation/animation/scale_route.dart';
import 'package:recipe_flutter_app/features/authorization/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:recipe_flutter_app/features/authorization/presentation/bloc/auth_bloc/auth_event.dart';
import 'package:recipe_flutter_app/features/authorization/presentation/bloc/auth_bloc/auth_state.dart';
import 'package:recipe_flutter_app/features/authorization/presentation/pages/login/login_page.dart';

class SignOutForm extends StatelessWidget {
  const SignOutForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (BuildContext context, AuthState state) {
        if (state is Logout) {}
      },
      child: IconButton(
        icon: const Icon(
          Icons.exit_to_app,
          color: Colors.black,
        ),
        onPressed: () {
          _onFormSubmitted(context);
        },
      ),
    );
  }

  void _onFormSubmitted(BuildContext context) {
    final AuthBloc _authBloc = BlocProvider.of<AuthBloc>(context);
    _authBloc.add(AuthenticationLoggedOut());
    Navigator.pushAndRemoveUntil<void>(
      context,
      ScaleRoute(
        page: const LoginPage(),
      ),
      (Route<dynamic> route) => false,
    );
  }
}
