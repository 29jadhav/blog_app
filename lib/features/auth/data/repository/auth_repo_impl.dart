import 'package:blog_app/core/exception/failuer.dart';
import 'package:blog_app/core/exception/server_exceptions.dart';
import 'package:blog_app/core/network/connection_checker.dart';
import 'package:blog_app/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:blog_app/core/common/entities/user.dart';
import 'package:blog_app/features/auth/data/models/user_model.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repo.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDataSource authRemoteDataSource;
  final ConnectionChecker connectionChecker;

  AuthRepoImpl(
      {required this.authRemoteDataSource, required this.connectionChecker});

  Future<Either<Failuer, User>> _getUser(Future<User> Function() fn) async {
    try {
      if (!await connectionChecker.isConnected) {
        final session = authRemoteDataSource.currentSession;
        if (session == null) {
          return left(Failuer(errorMessage: "User is not logged in!"));
        }

        return right(UserModel(
          id: session.user.id,
          email: session.user.email ?? '',
          name: '',
        ));
      }
      final response = await fn();
      return right(response);
    } on ServerExceptions catch (e) {
      return left(
        Failuer(
          errorMessage: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failuer, User>> signin(
      {required String email, required String password}) async {
    return _getUser(
      () async => await authRemoteDataSource.signin(
        email: email,
        password: password,
      ),
    );
  }

  @override
  Future<Either<Failuer, User>> signup(
      {required String name,
      required String email,
      required String password}) async {
    return _getUser(() async => await authRemoteDataSource.signup(
          name: name,
          email: email,
          password: password,
        ));
  }

  @override
  Future<Either<Failuer, User>> getCurrentUser() async {
    try {
      final response = await authRemoteDataSource.getCurrentUser();
      if (response == null) {
        return left(Failuer(errorMessage: "User is not logged in!"));
      }
      return right(response);
    } on ServerExceptions catch (e) {
      return left(Failuer(errorMessage: e.errorMessage));
    }
  }
}
