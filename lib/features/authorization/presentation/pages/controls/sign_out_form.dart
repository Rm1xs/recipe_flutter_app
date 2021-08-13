import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_flutter_app/core/presentation/animation/scale_route.dart';
import 'package:recipe_flutter_app/features/authorization/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:recipe_flutter_app/features/authorization/presentation/bloc/auth_bloc/auth_event.dart';
import 'package:recipe_flutter_app/features/authorization/presentation/bloc/auth_bloc/auth_state.dart';
import 'package:recipe_flutter_app/features/authorization/presentation/pages/login/login_page.dart';

class SignOutForm extends StatefulWidget {
  const SignOutForm({Key? key}) : super(key: key);

  @override
  _SignOutFormState createState() => _SignOutFormState();
}

class _SignOutFormState extends State<SignOutForm> {
  late AuthBloc _authBloc;

  @override
  void initState() {
    super.initState();
    _authBloc = BlocProvider.of<AuthBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Logout) {}
      },
      child: IconButton(
        icon: Icon(
          Icons.exit_to_app,
          color: Colors.black,
        ),
        onPressed: () {
          _onFormSubmitted();
        },
      ),
    );
  }

  void _onFormSubmitted() {
    _authBloc.add(AuthenticationLoggedOut());
    Navigator.pushAndRemoveUntil(
      context,
      ScaleRoute(
        page: const LoginPage(),
      ),
      (Route route) => false,
    );
  }
}
