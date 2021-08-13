
import 'package:recipe_flutter_app/core/data/models/recipe_class_,model.dart';

abstract class RecipeHistoryState {}

class HistoryEmpty extends RecipeHistoryState {}

class HistoryLoading extends RecipeHistoryState {}

class HistoryLoaded extends RecipeHistoryState {
  List<RecipeClassModel> recipes;

  HistoryLoaded({required this.recipes});
}

class HistoryError extends RecipeHistoryState {}
