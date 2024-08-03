import 'package:blog_app/core/exception/failuer.dart';
import 'package:blog_app/core/exception/server_exceptions.dart';
import 'package:blog_app/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:blog_app/features/auth/domain/entities/user.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repo.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepoImpl({required this.authRemoteDataSource});

  @override
  Future<Either<Failuer, User>> signin(
      {required String email, required String password}) async {
    try {
      final response = await authRemoteDataSource.signin(
        email: email,
        password: password,
      );
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
  Future<Either<Failuer, User>> signup(
      {required String name,
      required String email,
      required String password}) async {
    try {
      final response = await authRemoteDataSource.signup(
        name: name,
        email: email,
        password: password,
      );
      return right(response);
    } on ServerExceptions catch (e) {
      return left(
        Failuer(
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
