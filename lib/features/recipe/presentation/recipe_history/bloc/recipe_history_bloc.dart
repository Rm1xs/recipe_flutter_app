import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_flutter_app/core/data/models/recipe_class_model.dart';
import 'package:recipe_flutter_app/features/recipe/domain/usecases/usecase_implementation.dart';
import 'package:recipe_flutter_app/features/recipe/presentation/recipe_history/bloc/recipe_history_event.dart';
import 'package:recipe_flutter_app/features/recipe/presentation/recipe_history/bloc/recipe_history_state.dart';


class RecipeHistoryBloc extends Bloc<RecipeHistoryEvent, RecipeHistoryState> {
  RecipeHistoryBloc({required this.useCaseImplementation})
      : super(HistoryEmpty()) {
    add(GetHistoryEvent());
  }

  final UseCaseImplementation useCaseImplementation;

  RecipeHistoryState get initialState => HistoryEmpty();

  @override
  Stream<RecipeHistoryState> mapEventToState(RecipeHistoryEvent event) async* {
    if (event is GetHistoryEvent) {
      yield HistoryLoading();
      try {
        final List<RecipeClassModel> _loadedList =
            await useCaseImplementation.getRecipesDb();
        yield HistoryLoaded(recipes: _loadedList);
      } catch (_) {
        yield HistoryError();
      }
    }
  }
}
