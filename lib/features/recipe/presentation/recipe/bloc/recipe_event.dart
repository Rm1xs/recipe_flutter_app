import 'package:recipe_flutter_app/core/data/models/recipe_model.dart';

abstract class RecipeEvent {
  RecipeEvent([List props = const <dynamic>[]]);
}

class GetRecipe extends RecipeEvent {
  GetRecipe(this.inputString);

  final String inputString;
}

class SaveRecipes extends RecipeEvent {
  SaveRecipes({required this.list});

  final RecipeModel list;
}
