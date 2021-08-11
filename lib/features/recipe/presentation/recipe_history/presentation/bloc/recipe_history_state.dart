
import 'package:recipe_flutter_app/core/data/models/recipe_class_,model.dart';

abstract class HistoryState {}

class HistoryEmpty extends HistoryState {}

class HistoryLoading extends HistoryState {}

class HistoryLoaded extends HistoryState {
  List<RecipeClassModel> recipes;

  HistoryLoaded({required this.recipes});
}

class HistoryError extends HistoryState {}
