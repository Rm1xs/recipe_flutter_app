import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_flutter_app/features/authorization/domain/usecases/auth_usecase_implementation.dart';
import 'package:recipe_flutter_app/features/authorization/presentation/bloc/auth_bloc/auth_event.dart';
import 'package:recipe_flutter_app/features/authorization/presentation/bloc/auth_bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required AuthUseCaseImplementation userRepository,
  })  : _userRepository = userRepository,
        super(AuthenticationInitial());
  final AuthUseCaseImplementation _userRepository;

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
    final User? isSignedIn = await _userRepository.checkAuth();
    if (isSignedIn != null) {
      //final User? firebaseUser = await _userRepository.getUser();
      yield UserLogged(isSignedIn);
    }
    else {
      //final firebaseUserStorage = await _userRepository.;
      yield UserNeedsToLogIn();
    }
  }
}
