import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_flutter_app/features/authorization/domain/usecases/auth_usecase_implementation.dart';
import 'package:recipe_flutter_app/features/authorization/presentation/bloc/auth_bloc/auth_event.dart';
import 'package:recipe_flutter_app/features/authorization/presentation/bloc/auth_bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthUseCaseImplementation _userRepository;

  AuthBloc({
    required AuthUseCaseImplementation userRepository,
  })  : _userRepository = userRepository,
        super(AuthenticationInitial());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AuthenticationStarted) {
      yield* _mapAuthenticationStartedToState();
    } else if (event is AuthenticationLoggedOut) {
      yield* _mapAuthenticationLoggedOutInToState();
    } else if (event is AuthenticationLoggedChek) {
      yield* _mapAuthenticationStartedToState();
    }
  }

  //AuthenticationLoggedOut
  Stream<AuthState> _mapAuthenticationLoggedOutInToState() async* {
    yield Logout();
    _userRepository.signOut();
  }

  //AuthenticationLoggedIn
  //Stream<AuthState> _mapAuthenticationLoggedInToState() async* {
  //yield AuthenticationSuccess(await _userRepository.getUser());
  //}

  // AuthenticationStarted
  Stream<AuthState> _mapAuthenticationStartedToState() async* {
    final isSignedIn = await _userRepository.checkAuth();
    if (isSignedIn) {
      final firebaseUser = await _userRepository.getUser();
      yield UserLogged(firebaseUser!);
    } else {
      //final firebaseUserStorage = await _userRepository.;
      yield UserNeedsToLogIn();
    }
  }
}
