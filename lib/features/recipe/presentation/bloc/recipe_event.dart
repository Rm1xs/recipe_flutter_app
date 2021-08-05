import 'package:recipe_flutter_app/domain/entities/recipe.dart';

abstract class RecipeEvent {

  RecipeEvent([List props = const <dynamic>[]]);
}

class GetRecipe extends RecipeEvent {
  final String inputString;

  GetRecipe(this.inputString);

}
class SaveRecipes extends RecipeEvent {
  final Recipe list;

  SaveRecipes({required this.list});
}
