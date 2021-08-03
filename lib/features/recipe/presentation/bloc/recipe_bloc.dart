import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_flutter_app/domain/entities/recipe.dart';
import 'package:recipe_flutter_app/features/recipe/domain/usecases/usecase_implementation.dart';
import 'package:recipe_flutter_app/features/recipe/presentation/bloc/recipe_event.dart';
import 'package:recipe_flutter_app/features/recipe/presentation/bloc/recipe_state.dart';

class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  final UseCaseImplementation useCaseImplementation;

  RecipeBloc({
    required UseCaseImplementation concrete,
  })  : useCaseImplementation = concrete,
        super(Empty());

  RecipeState get initialState => Empty();

  @override
  Stream<RecipeState> mapEventToState(
      RecipeEvent event,
      ) async* {
    if (event is GetRecipe) {
      yield Loading();
      try {
        final Recipe _loaded = await useCaseImplementation.getRecipe(Params(query: event.inputString));
        yield Loaded(list: _loaded);
      } catch (_e) {
        yield Error(message: _e.toString());
      }
    }
  }
}