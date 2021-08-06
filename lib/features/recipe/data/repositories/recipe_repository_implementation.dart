import 'package:recipe_flutter_app/core/datasources/recipe_remote_datasource.dart';
import 'package:recipe_flutter_app/domain/entities/recipe.dart';
import 'package:recipe_flutter_app/domain/entities/recipe_class.dart';
import 'package:recipe_flutter_app/features/recipe/domain/repositories/recipe_repository.dart';

class RecipeRepositoryImplementation implements RecipeRepository {
  final RecipeRemoteDataSource recipeRemoteDataSource;

  RecipeRepositoryImplementation(this.recipeRemoteDataSource);

  @override
  Future<Recipe> getRecipe(String recipe) async {
    return await recipeRemoteDataSource.getRecipe(recipe);
  }

  @override
  Future addRecipe(Recipe recipe) async {
    return await recipeRemoteDataSource.addRecipe(recipe);
  }

  @override
  Future<List<RecipeClass>> getRecipesDb() async {
    return await recipeRemoteDataSource.getRecipesDb();
  }
}
