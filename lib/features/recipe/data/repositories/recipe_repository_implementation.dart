import 'package:recipe_flutter_app/core/data/datasources/recipe_remote_datasource.dart';
import 'package:recipe_flutter_app/core/data/models/recipe_class_,model.dart';
import 'package:recipe_flutter_app/core/data/models/recipe_model.dart';
import 'package:recipe_flutter_app/features/recipe/domain/repositories/recipe_repository.dart';

class RecipeRepositoryImplementation implements RecipeRepository {
  final RecipeRemoteDataSource recipeRemoteDataSource;

  RecipeRepositoryImplementation(this.recipeRemoteDataSource);

  @override
  Future<RecipeModel> getRecipe(String recipe) async {
    return await recipeRemoteDataSource.getRecipe(recipe);
  }

  @override
  Future addRecipe(RecipeModel recipe) async {
    return await recipeRemoteDataSource.addRecipe(recipe);
  }

  @override
  Future<List<RecipeClassModel>> getRecipesDb() async {
    return await recipeRemoteDataSource.getRecipesDb();
  }
}
