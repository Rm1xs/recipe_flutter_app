import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_flutter_app/features/recipe/presentation/bloc/bloc.dart';

class RecipeControls extends StatefulWidget {
  const RecipeControls({
    Key? key,
  }) : super(key: key);

  @override
  _RecipeControlsState createState() => _RecipeControlsState();
}

class _RecipeControlsState extends State<RecipeControls> {
  final controller = TextEditingController();
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
                borderRadius: new BorderRadius.circular(25.0),
              ),
              labelText: 'Recipe'),
          onChanged: (value) {
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
        SizedBox(height: 10),
      ],
    );
  }

  void dispatchConcrete() {
    controller.clear();
    BlocProvider.of<RecipeBloc>(context).add(GetRecipe(inputStr!));
  }
}
