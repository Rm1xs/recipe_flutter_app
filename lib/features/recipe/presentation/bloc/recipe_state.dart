import 'package:recipe_flutter_app/core/data/models/recipe_model.dart';
import 'package:recipe_flutter_app/core/domain/entities/recipe.dart';

abstract class RecipeState {}

class Empty extends RecipeState {}

class Loading extends RecipeState {}

class Loaded extends RecipeState {
  final RecipeModel list;

  Loaded({required this.list});
}

class Saved extends RecipeState {
  final RecipeModel data;

  Saved({required this.data});
}

class Error extends RecipeState {
  final String message;

  Error({required this.message});
}