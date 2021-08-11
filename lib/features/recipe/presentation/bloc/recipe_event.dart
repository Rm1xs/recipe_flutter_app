import 'package:recipe_flutter_app/core/data/models/recipe_model.dart';

abstract class RecipeEvent {

  RecipeEvent([List props = const <dynamic>[]]);
}

class GetRecipe extends RecipeEvent {
  final String inputString;

  GetRecipe(this.inputString);

}
class SaveRecipes extends RecipeEvent {
  final RecipeModel list;

  SaveRecipes({required this.list});
}

