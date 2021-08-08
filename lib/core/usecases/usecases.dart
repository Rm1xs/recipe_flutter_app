import 'package:recipe_flutter_app/domain/entities/hit.dart';
import 'package:recipe_flutter_app/domain/entities/recipe.dart';
import 'package:recipe_flutter_app/domain/entities/recipe_class.dart';
import 'package:recipe_flutter_app/features/recipe/domain/usecases/usecase_implementation.dart';

abstract class UseCase<String> {
  Future getRecipe(Params recipe);

  Future addRecipes(Recipe recipe);

  Future<List<RecipeClass>> getRecipesDb();

  //Future<List<Hit>> sortAsd(List sortList);

  //Future<List<Hit>> sortDcr(List sortList);
}
