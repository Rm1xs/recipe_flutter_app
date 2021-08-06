import 'package:recipe_flutter_app/domain/entities/recipe_class.dart';

abstract class HistoryState {}

class HistoryEmpty extends HistoryState {}

class HistoryLoading extends HistoryState {}

class HistoryLoaded extends HistoryState {
  List<RecipeClass> recipes;

  HistoryLoaded({required this.recipes});
}

class HistoryError extends HistoryState {}
