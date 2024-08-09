import 'dart:async';
import 'package:blog_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_app/core/usercase/usercase.dart';
import 'package:blog_app/core/common/entities/user.dart';
import 'package:blog_app/features/auth/domain/usecases/get_current_user.dart';
import 'package:blog_app/features/auth/domain/usecases/user_signin.dart';
import 'package:blog_app/features/auth/domain/usecases/user_signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignup _userSignup;
  final UserSignin _userSignin;
  final GetCurrentUser _getCurrentUser;
  final AppUserCubit _appUser;

  AuthBloc({
    required UserSignup userSignup,
    required UserSignin userSignin,
    required GetCurrentUser getCurrentUser,
    required AppUserCubit appUser,
  })  : _userSignup = userSignup,
        _userSignin = userSignin,
        _getCurrentUser = getCurrentUser,
        _appUser = appUser,
        super(AuthInitial()) {
    print("AuthBloc");
    on<AuthEvent>((_, emit) => emit(AuthLoading()));
    on<AuthSignup>(_signup);
    on<AuthSignin>(_signin);
    on<AuthIsUserLoggedIn>(_isUserLoggedIn);
  }

  void _signup(
    AuthSignup event,
    Emitter<AuthState> emit,
  ) async {
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
      (user) => _emitAuthSuccess(user, emit),
    );
  }

  void _signin(
    AuthSignin event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final response = await _userSignin(
      UserSigninParam(
        email: event.email,
        password: event.password,
      ),
    );

    response.fold(
      (failuer) => emit(AuthFailuer(failuer.errorMessage)),
      (user) => _emitAuthSuccess(user, emit),
    );
  }

  Future<void> _isUserLoggedIn(
    AuthIsUserLoggedIn event,
    Emitter<AuthState> emit,
  ) async {
    print("is user logged in..");
    final response = await _getCurrentUser(NoParam());

    response.fold((failuer) => emit(AuthFailuer(failuer.errorMessage)),
        (user) => _emitAuthSuccess(user, emit));
  }

  void _emitAuthSuccess(User user, Emitter<AuthState> emit) {
    print("_emitAuthSuccess....");
    _appUser.updateUser(user);
    emit(AuthSuccess(user));
  }
}
