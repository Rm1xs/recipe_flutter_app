import 'package:recipe_flutter_app/core/data/models/recipe_model.dart';

abstract class RecipeState {}

class Empty extends RecipeState {}

class Loading extends RecipeState {}

class Loaded extends RecipeState {
  Loaded({required this.list});

  final RecipeModel list;
}

class Saved extends RecipeState {
  Saved({required this.data});

  final RecipeModel data;
}

class Error extends RecipeState {
  Error({required this.message});

  final String message;
}
