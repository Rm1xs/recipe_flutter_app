import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_flutter_app/features/authorization/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:recipe_flutter_app/features/authorization/presentation/pages/controls/sign_out_form.dart';

import '../../../../../injection_container.dart';

Widget signOutWidget(BuildContext context) {
  return BlocProvider<AuthBloc>(
    create: (_) => sl<AuthBloc>(),
    child: Container(
      child: const SignOutForm(),
    ),
  );
}
