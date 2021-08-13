import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_flutter_app/features/authorization/presentation/bloc/register_bloc/register_bloc.dart';
import 'package:recipe_flutter_app/features/authorization/presentation/bloc/register_bloc/register_event.dart';
import 'package:recipe_flutter_app/features/authorization/presentation/bloc/register_bloc/register_state.dart';
import 'package:recipe_flutter_app/features/authorization/presentation/pages/login/login_page.dart';

class RegisterForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<RegisterForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isButtonEnabled(RegisterState state) {
    return state.isFormValid && isPopulated;
  }

  late RegisterBloc _registerBloc;

  @override
  void initState() {
    super.initState();
    _registerBloc = BlocProvider.of<RegisterBloc>(context);
    _emailController.addListener(_onEmailChange);
    _passwordController.addListener(_onPasswordChange);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (BuildContext context, RegisterState state) {
        if (state.isFailure) {
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text('Register Failure'),
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
                    const Text('Registering...'),
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
                    const Text('Successfully registered'),
                    const Icon(
                      Icons.check_circle,
                    )
                  ],
                ),
                backgroundColor: const Color(0xffffae88),
              ),
            );
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute<void>(builder: (BuildContext context) => const LoginPage()),
            (Route<dynamic> route) => false,
          );

          //BlocProvider.of<AuthenticationBloc>(context).add(
          //AuthenticationLoggedIn(),
          //);
          //Navigator.pop(context);
        }
      },
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (BuildContext context, RegisterState state) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction, controller: _emailController,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.email),
                      labelText: 'Email',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    validator: (_) {
                      return !state.isEmailValid ? 'Invalid Email' : null;
                    },
                  ),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction, controller: _passwordController,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.lock),
                      labelText: 'Password',
                    ),
                    obscureText: true,
                    autocorrect: true,
                    validator: (_) {
                      return !state.isPasswordValid ? 'Invalid Password' : null;
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (isButtonEnabled(state)) {
                        _onFormSubmitted();
                      }
                    },
                    child: const Text('Register'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _onEmailChange() {
    _registerBloc.add(RegisterEmailChanged(email: _emailController.text));
  }

  void _onPasswordChange() {
    _registerBloc
        .add(RegisterPasswordChanged(password: _passwordController.text));
  }

  void _onFormSubmitted() {
    _registerBloc.add(RegisterSubmitted(
        email: _emailController.text, password: _passwordController.text));
  }
}
