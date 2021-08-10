import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:recipe_flutter_app/core/datasources/recipe_remote_datasource.dart';
import 'package:recipe_flutter_app/features/authorization/data/repositories/auth_repository_implementation.dart';
import 'package:recipe_flutter_app/features/authorization/presentation/bloc/login_bloc/login_bloc.dart';
import 'package:recipe_flutter_app/features/recipe/data/repositories/recipe_repository_implementation.dart';
import 'package:recipe_flutter_app/features/recipe/domain/repositories/recipe_repository.dart';
import 'package:recipe_flutter_app/features/recipe/presentation/bloc/recipe_bloc.dart';
import 'package:recipe_flutter_app/features/recipe/presentation/recipe_history/presentation/bloc/recipe_history_bloc.dart';

import 'core/datasources/auth_remote_datasource.dart';
import 'features/authorization/domain/repositories/auth_repository.dart';
import 'features/authorization/domain/usecases/auth_usecase_implementation.dart';
import 'features/authorization/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'features/authorization/presentation/bloc/register_bloc/register_bloc.dart';
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
  sl.registerFactory(
        () => AuthenticationBloc(
       userRepository: sl(),
    ),
  );
  sl.registerFactory(
        () => RegisterBloc(
      userRepository: sl(),
    ),
  );
  sl.registerFactory(
        () => LoginBloc(
      userRepository: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => UseCaseImplementation(sl()));
  sl.registerLazySingleton(() => AuthUseCaseImplementation(sl()));

  // Repository
  sl.registerLazySingleton<RecipeRepository>(
    () => RecipeRepositoryImplementation(sl()),
  );
  sl.registerLazySingleton<AuthRepository>(
        () => AuthRepositoryImplementation(sl()),
  );

  // Data sources
  sl.registerLazySingleton<RecipeRemoteDataSource>(
    () => RecipeRemoteDataSourceImplementation(sl()),
  );
  sl.registerLazySingleton<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImplementation(),
  );

  //! External
  sl.registerLazySingleton(() => Client());
}
