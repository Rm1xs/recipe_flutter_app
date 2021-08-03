import 'package:recipe_flutter_app/domain/entities/recipe.dart';

abstract class RecipeState {}

class Empty extends RecipeState {}

class Loading extends RecipeState {}

class Loaded extends RecipeState {
  final Recipe list;

  Loaded({required this.list});
}

class Error extends RecipeState {
  final String message;

  Error({required this.message});
}