import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_flutter_app/core/utils/validators.dart';
import 'package:recipe_flutter_app/features/authorization/domain/usecases/auth_usecase_implementation.dart';
import 'package:recipe_flutter_app/features/authorization/presentation/bloc/register_bloc/register_event.dart';
import 'package:recipe_flutter_app/features/authorization/presentation/bloc/register_bloc/register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final AuthUseCaseImplementation _userRepository;

  RegisterBloc({required AuthUseCaseImplementation userRepository})
      : _userRepository = userRepository,
        super(RegisterState.initial());

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if (event is RegisterEmailChanged) {
      yield* _mapRegisterEmailChangeToState(event.email);
    } else if (event is RegisterPasswordChanged) {
      yield* _mapRegisterPasswordChangeToState(event.password);
    } else if (event is RegisterSubmitted) {
      yield* _mapRegisterSubmittedToState(
          email: event.email, password: event.password);
    }
  }

  Stream<RegisterState> _mapRegisterEmailChangeToState(String email) async* {
    yield state.updateEmail(isEmailValid: Validators.isValidEmail(email));
  }

  Stream<RegisterState> _mapRegisterPasswordChangeToState(
      String password) async* {
    yield state.updatePassword(
        isPasswordValid: Validators.isValidPassword(password));
  }

  Stream<RegisterState> _mapRegisterSubmittedToState(
      {required String email, required String password}) async* {
    yield RegisterState.loading();
    try {
      await _userRepository.signUp(email, password);
      yield RegisterState.success();
    } catch (error) {
      print(error);
      yield RegisterState.failure();
    }
  }
}
