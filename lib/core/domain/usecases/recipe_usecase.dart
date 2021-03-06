import 'package:recipe_flutter_app/core/data/models/recipe_class_model.dart';
import 'package:recipe_flutter_app/core/data/models/recipe_model.dart';
import 'package:recipe_flutter_app/core/domain/entities/hit.dart';
import 'package:recipe_flutter_app/features/recipe/domain/usecases/usecase_implementation.dart';

abstract class UseCase<String> {
  Future<RecipeModel> getRecipe(Params recipe);

  Future<void> addRecipes(RecipeModel recipe);

  Future<List<RecipeClassModel>> getRecipesDb();

  Future<List<Hit>> sort(List sortList);

}
