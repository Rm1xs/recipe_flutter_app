import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:recipe_flutter_app/core/datasources/recipe_remote_datasource.dart';
import 'package:recipe_flutter_app/features/recipe/data/repositories/recipe_repository_implementation.dart';
import 'package:recipe_flutter_app/features/recipe/domain/repositories/recipe_repository.dart';
import 'package:recipe_flutter_app/features/recipe/presentation/bloc/recipe_bloc.dart';
import 'package:recipe_flutter_app/features/recipe/presentation/recipe_history/presentation/bloc/recipe_history_bloc.dart';

import 'features/recipe/domain/usecases/usecase_implementation.dart';

final sl = GetIt.instance;
//final sl2 = GetIt.instance;
Future<void> init() async {
  sl.registerFactory(
    () => RecipeBloc(
      concrete: sl(),
    ),
  );
  sl.registerFactory(
        () => HistoryBloc(
       useCaseImplementation: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => UseCaseImplementation(sl()));

  // Repository
  sl.registerLazySingleton<RecipeRepository>(
    () => RecipeRepositoryImplementation(sl()),
  );

  // Data sources
  sl.registerLazySingleton<RecipeRemoteDataSource>(
    () => RecipeRemoteDataSourceImplementation(sl()),
  );

  //! External
  sl.registerLazySingleton(() => Client());
}
