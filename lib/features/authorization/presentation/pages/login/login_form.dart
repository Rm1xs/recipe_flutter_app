import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_flutter_app/features/authorization/presentation/bloc/login_bloc/login_bloc.dart';
import 'package:recipe_flutter_app/features/authorization/presentation/bloc/login_bloc/login_event.dart';
import 'package:recipe_flutter_app/features/authorization/presentation/bloc/login_bloc/login_state.dart';
import 'package:recipe_flutter_app/features/authorization/presentation/pages/register/register_page.dart';
import 'package:recipe_flutter_app/features/recipe/presentation/recipe/pages/recipe_page.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isButtonEnabled(LoginState state) {
    return state.isFormValid && isPopulated;
  }

  late LoginBloc _loginBloc;

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _emailController.addListener(_onEmailChange);
    _passwordController.addListener(_onPasswordChange);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (BuildContext context, LoginState state) {
        if (state.isFailure) {
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text('Login Failure'),
                    const Icon(Icons.error),
                  ],
                ),
                backgroundColor: const Color(0xffffae88),
              ),
            );
        }

        if (state.isSubmitting) {
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text('Logging In...'),
                    const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                  ],
                ),
                backgroundColor: const Color(0xffffae88),
              ),
            );
        }

        if (state.isSuccess) {
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text('Successes logIn'),
                    const Icon(Icons.check_circle),
                  ],
                ),
                backgroundColor: const Color(0xffffae88),
              ),
            );
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute<void>(
                builder: (BuildContext context) => const RecipePage()),
            (Route<dynamic> route) => false,
          );
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (BuildContext context, LoginState state) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
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
                    validator: (_) {
                      return !state.isEmailValid ? 'Invalid Email' : null;
                    },
                  ),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.lock),
                      labelText: 'Password',
                    ),
                    obscureText: true,
                    autocorrect: false,
                    validator: (_) {
                      return !state.isPasswordValid ? 'Invalid Password' : null;
                    },
                  ),
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (isButtonEnabled(state)) {
                            _onFormSubmitted();
                          }
                        },
                        child: const Text('LogIn'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute<void>(builder: (_) {
                            return const RegisterPage();
                          }));
                        },
                        child: const Text('Register'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onEmailChange() {
    _loginBloc.add(LoginEmailChange(email: _emailController.text));
  }

  void _onPasswordChange() {
    _loginBloc.add(LoginPasswordChanged(password: _passwordController.text));
  }

  void _onFormSubmitted() {
    _loginBloc.add(LoginWithCredentialsPressed(
        email: _emailController.text, password: _passwordController.text));
  }
}
