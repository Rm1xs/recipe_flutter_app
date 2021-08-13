import 'package:recipe_flutter_app/core/data/models/recipe_class_,model.dart';
import 'package:recipe_flutter_app/core/data/models/recipe_model.dart';
import 'package:recipe_flutter_app/core/domain/entities/hit.dart';
import 'package:recipe_flutter_app/core/domain/usecases/recipe_usecase.dart';
import 'package:recipe_flutter_app/features/recipe/domain/repositories/recipe_repository.dart';

class UseCaseImplementation implements UseCase<String> {
  final RecipeRepository repository;

  UseCaseImplementation(this.repository);

  @override
  Future getRecipe(Params recipe) async {
    return await repository.getRecipe(recipe.query);
  }

  @override
  Future addRecipes(RecipeModel recipe) async {
    return await repository.addRecipe(recipe);
  }

  @override
  Future<List<RecipeClassModel>> getRecipesDb() async {
    return await repository.getRecipesDb();
  }

  @override
  Future<List<Hit>> sort(List<dynamic> sortList) {
    // TODO: implement sort
    throw UnimplementedError();
  }
}

class Params {
  final String query;

  Params({required this.query});
}
