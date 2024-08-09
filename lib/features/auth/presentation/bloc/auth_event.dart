part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class AuthSignup extends AuthEvent {
  final String name;
  final String email;
  final String password;

  AuthSignup({
    required this.name,
    required this.email,
    required this.password,
  });
}

class AuthSignin extends AuthEvent {
  final String email;
  final String password;

  AuthSignin({
    required this.email,
    required this.password,
  });
}

class AuthIsUserLoggedIn extends AuthEvent {}
