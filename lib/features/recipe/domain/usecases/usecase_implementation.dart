import 'package:recipe_flutter_app/core/usecases/usecases.dart';
import 'package:recipe_flutter_app/features/recipe/domain/repositories/recipe_repository.dart';

class UseCaseImplementation implements UseCase<String>{
  final RecipeRepository repository;

  UseCaseImplementation(this.repository);
  @override
  Future getRecipe(Params recipe) async {
    return await repository.getRecipe(recipe.query);
  }
}
class Params {
  final String query;

  Params({required this.query});
}
