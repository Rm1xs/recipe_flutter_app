import 'package:recipe_flutter_app/core/data/models/recipe_class_model.dart';

abstract class RecipeHistoryState {}

class HistoryEmpty extends RecipeHistoryState {}

class HistoryLoading extends RecipeHistoryState {}

class HistoryLoaded extends RecipeHistoryState {
  HistoryLoaded({required this.recipes});

  List<RecipeClassModel> recipes;
}

class HistoryError extends RecipeHistoryState {}
