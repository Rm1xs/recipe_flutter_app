import 'package:recipe_flutter_app/features/recipe/domain/usecases/usecase_implementation.dart';

abstract class UseCase<String> {
  Future getRecipe(Params recipe);
}
