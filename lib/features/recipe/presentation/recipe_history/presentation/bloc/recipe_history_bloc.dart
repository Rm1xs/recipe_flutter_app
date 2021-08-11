import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_flutter_app/core/data/models/recipe_class_,model.dart';
import 'package:recipe_flutter_app/features/recipe/domain/usecases/usecase_implementation.dart';
import 'package:recipe_flutter_app/features/recipe/presentation/recipe_history/presentation/bloc/recipe_history_event.dart';
import 'package:recipe_flutter_app/features/recipe/presentation/recipe_history/presentation/bloc/recipe_history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final UseCaseImplementation useCaseImplementation;

  HistoryBloc({required this.useCaseImplementation}) : super(HistoryEmpty()) {
    add(GetHistoryEvent());
  }

  @override
  HistoryState get initialState => HistoryEmpty();

  @override
  Stream<HistoryState> mapEventToState(HistoryEvent event) async* {
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
