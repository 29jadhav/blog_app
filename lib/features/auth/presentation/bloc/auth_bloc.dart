import 'package:blog_app/features/auth/domain/entities/user.dart';
import 'package:blog_app/features/auth/domain/usecases/user_signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignup _userSignup;

  AuthBloc({required UserSignup userSignup})
      : _userSignup = userSignup,
        super(AuthInitial()) {
    on<AuthSignup>((event, emit) async {
      emit(AuthLoading());
      final response = await _userSignup(
        UserSignupParam(
          email: event.email,
          password: event.password,
          name: event.name,
        ),
      );

      response.fold(
        (failuer) => emit(AuthFailuer(failuer.errorMessage)),
        (user) => emit(
          AuthSuccess(user),
        ),
      );
    });
  }
}
