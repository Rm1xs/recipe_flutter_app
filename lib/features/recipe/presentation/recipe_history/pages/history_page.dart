import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_flutter_app/features/recipe/presentation/recipe_history/bloc/recipe_history_bloc.dart';
import 'package:recipe_flutter_app/features/recipe/presentation/recipe_history/widgets/history_widget.dart';

import '../../../../../../injection_container.dart';

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<RecipeHistoryBloc>(
      create: (_) => sl<RecipeHistoryBloc>(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Recipes')),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(child: HistoryWidget()),
          ],
        ),
      ),
    );
  }
}
