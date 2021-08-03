import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_flutter_app/features/recipe/presentation/bloc/bloc.dart';
import 'package:recipe_flutter_app/features/recipe/presentation/widgets/loading_widget.dart';
import 'package:recipe_flutter_app/features/recipe/presentation/widgets/message_display.dart';
import 'package:recipe_flutter_app/features/recipe/presentation/widgets/recipe_controls.dart';
import 'package:recipe_flutter_app/features/recipe/presentation/widgets/recipe_display.dart';

import '../../../../injection_container.dart';

class RecipePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipes'),
        actions: <Widget>[
          PopupMenuButton<int>(
            onSelected: (item) => onSelected(context, item),
            itemBuilder: (context) => [
              PopupMenuItem(value: 0, child: Text('History')),
              PopupMenuItem(value: 1, child: Text('About')),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: buildBody(context),
      ),
    );
  }

  BlocProvider<RecipeBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<RecipeBloc>(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              SizedBox(height: 10),
              RecipeControls(),
              BlocBuilder<RecipeBloc, RecipeState>(
                builder: (context, state) {
                  if (state is Empty) {
                    return MessageDisplay(
                      message: 'Start searching',
                    );
                  } else if (state is Loading) {
                    return LoadingWidget();
                  } else if (state is Loaded) {
                    return RecipeDisplay(recipe: state.list,);
                  } else if (state is Error) {
                    return MessageDisplay(message: 'Error');
                  }
                  return MessageDisplay(message: 'Not found items');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
void onSelected(BuildContext context, int item) {
  switch (item) {
    case 0:
      print('hi');
      break;
    case 1:
      print('hi');
      break;
  }
}
