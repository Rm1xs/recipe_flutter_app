import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_flutter_app/core/data/models/recipe_model.dart';
import 'package:recipe_flutter_app/features/recipe/domain/usecases/usecase_implementation.dart';
import 'package:recipe_flutter_app/features/recipe/presentation/recipe/bloc/recipe_event.dart';
import 'package:recipe_flutter_app/features/recipe/presentation/recipe/bloc/recipe_state.dart';


class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  RecipeBloc({
    required UseCaseImplementation concrete,
  })  : useCaseImplementation = concrete,
        super(Empty());
  final UseCaseImplementation useCaseImplementation;

  RecipeState get initialState => Empty();

  @override
  Stream<RecipeState> mapEventToState(
    RecipeEvent event,
  ) async* {
    if (event is GetRecipe) {
      yield Loading();
      try {
        final RecipeModel _loaded = await useCaseImplementation
            .getRecipe(Params(query: event.inputString));
        yield Loaded(list: _loaded);
      } catch (_e) {
        yield Error(message: _e.toString());
      }
    } else if (event is SaveRecipes) {
      await useCaseImplementation.addRecipes(event.list);
    }
  }
}
