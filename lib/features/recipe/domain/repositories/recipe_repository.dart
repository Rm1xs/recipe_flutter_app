import 'package:recipe_flutter_app/core/data/models/recipe_class_,model.dart';
import 'package:recipe_flutter_app/core/data/models/recipe_model.dart';

abstract class RecipeRepository {
  Future<RecipeModel> getRecipe(String recipe);

  Future addRecipe(RecipeModel recipe);

  Future<List<RecipeClassModel>> getRecipesDb();
}
