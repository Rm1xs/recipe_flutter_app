import 'package:recipe_flutter_app/domain/entities/recipe.dart';

abstract class RecipeRepository {
  Future<Recipe> getRecipe(String recipe);

  Future addRecipe(Recipe recipe);
}