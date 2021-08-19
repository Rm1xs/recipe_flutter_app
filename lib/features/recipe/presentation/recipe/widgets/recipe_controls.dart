import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_flutter_app/features/recipe/presentation/controller/recipe_controller.dart';

class RecipeControls extends StatefulWidget {
  const RecipeControls({
    Key? key,
  }) : super(key: key);

  @override
  _RecipeControlsState createState() => _RecipeControlsState();
}

class _RecipeControlsState extends State<RecipeControls> {
  final RecipeController _controller = Get.find();
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
              _controller.getRecipe(value);
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
}
