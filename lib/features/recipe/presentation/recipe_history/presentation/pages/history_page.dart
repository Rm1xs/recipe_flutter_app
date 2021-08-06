import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_flutter_app/features/recipe/presentation/recipe_history/presentation/bloc/recipe_history_bloc.dart';
import 'package:recipe_flutter_app/features/recipe/presentation/recipe_history/presentation/widgets/history_widget.dart';

import '../../../../../../injection_container.dart';

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<HistoryBloc>(
      create: (_) => sl<HistoryBloc>(),
      child: Scaffold(
        appBar: AppBar(title: Text('Recipes')),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(child: History()),
          ],
        ),
      ),
    );
  }
}
