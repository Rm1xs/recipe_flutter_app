import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_flutter_app/core/utils/validators.dart';
import 'package:recipe_flutter_app/features/authorization/domain/usecases/auth_usecase_implementation.dart';
import 'package:recipe_flutter_app/features/authorization/presentation/bloc/login_bloc/login_event.dart';
import 'package:recipe_flutter_app/features/authorization/presentation/bloc/login_bloc/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required AuthUseCaseImplementation userRepository})
      : _userRepository = userRepository,
        super(LoginState.initial());

  final AuthUseCaseImplementation _userRepository;

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginEmailChange) {
      yield* _mapLoginEmailChangeToState(event.email);
    } else if (event is LoginPasswordChanged) {
      yield* _mapLoginPasswordChangeToState(event.password);
    } else if (event is LoginWithCredentialsPressed) {
      yield* _mapLoginWithCredentialsPressedToState(
          email: event.email, password: event.password);
    }
  }

  Stream<LoginState> _mapLoginEmailChangeToState(String email) async* {
    yield state.updateEmail(isEmailValid: Validators.isValidEmail(email));
  }

  Stream<LoginState> _mapLoginPasswordChangeToState(String password) async* {
    yield state.updatePassword(
        isPasswordValid: Validators.isValidPassword(password));
  }

  Stream<LoginState> _mapLoginWithCredentialsPressedToState(
      {required String email, required String password}) async* {
    yield LoginState.loading();
    try {
      await _userRepository.logIn(email, password);
      await _userRepository.saveToken();
      yield LoginState.success();
    } catch (_) {
      yield LoginState.failure();
    }
  }
}
