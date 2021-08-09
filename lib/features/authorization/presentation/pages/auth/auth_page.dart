import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_flutter_app/features/authorization/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:recipe_flutter_app/features/authorization/presentation/bloc/auth_bloc/auth_state.dart';

import '../../../../../injection_container.dart';

class AuthMainPage extends StatefulWidget {
  const AuthMainPage({Key? key}) : super(key: key);

  @override
  _AuthMainPageState createState() => _AuthMainPageState();
}

class _AuthMainPageState extends State<AuthMainPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationBloc>(
      create: (_) => sl<AuthenticationBloc>(),
      child: Scaffold(
        appBar: AppBar(title: Text('Recipes')),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(child: BlocBuilder<AuthenticationBloc, AuthState>(
              builder: (context, state) {
                if (state is AuthenticationInitial) {
                  return Container(child: Text('Hi'),);
                }

                return Container(child: Text('Hi2'),);
              },
            ),),
          ],
        ),
      ),
    );
  }
}

