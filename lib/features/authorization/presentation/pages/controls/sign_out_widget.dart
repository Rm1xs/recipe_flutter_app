import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_flutter_app/features/authorization/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:recipe_flutter_app/features/authorization/presentation/pages/controls/sign_out_form.dart';

import '../../../../../injection_container.dart';

Widget SignOutWidget(BuildContext context) {
  return BlocProvider(
    create: (_) => sl<AuthBloc>(),
    child: Container(
      child: SignOutForm(),
    ),
  );
}
