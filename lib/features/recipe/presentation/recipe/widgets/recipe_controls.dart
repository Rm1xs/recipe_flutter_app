import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_flutter_app/features/recipe/presentation/recipe/bloc/recipe_bloc.dart';
import 'package:recipe_flutter_app/features/recipe/presentation/recipe/bloc/recipe_event.dart';

class RecipeControls extends StatefulWidget {
  const RecipeControls({
    Key? key,
  }) : super(key: key);

  @override
  _RecipeControlsState createState() => _RecipeControlsState();
}

class _RecipeControlsState extends State<RecipeControls> {
  final TextEditingController controller = TextEditingController();
  String? inputStr;
  bool isSearchAllowed = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          autofocus: false,
          controller: controller,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              labelText: 'Recipe'),
          onChanged: (String value) {
            if (isSearchAllowed) {
              isSearchAllowed = false;
              BlocProvider.of<RecipeBloc>(context).add(GetRecipe(value));
              Future<void>.delayed(const Duration(milliseconds: 500),
                  () => isSearchAllowed = true);
            }
          },
          onSubmitted: (_) {
            //dispatchConcrete();
          },
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  void dispatchConcrete() {
    controller.clear();
    BlocProvider.of<RecipeBloc>(context).add(GetRecipe(inputStr!));
  }
}
