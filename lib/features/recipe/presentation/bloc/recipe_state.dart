import 'package:recipe_flutter_app/domain/entities/recipe.dart';

abstract class RecipeState {}

class Empty extends RecipeState {}

class Loading extends RecipeState {}

class Loaded extends RecipeState {
  final Recipe list;

  Loaded({required this.list});
}


class Saved extends RecipeState {
  final Recipe data;

  Saved({required this.data});
}


class Error extends RecipeState {
  final String message;

  Error({required this.message});
}