import 'package:recipe_flutter_app/domain/entities/recipe.dart';
import 'package:recipe_flutter_app/domain/entities/recipe_class.dart';

abstract class RecipeRepository {
  Future<Recipe> getRecipe(String recipe);

  Future addRecipe(Recipe recipe);

  Future<List<RecipeClass>> getRecipesDb();
}
