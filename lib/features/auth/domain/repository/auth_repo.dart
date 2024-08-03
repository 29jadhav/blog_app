import 'package:blog_app/core/exception/failuer.dart';
import 'package:blog_app/features/auth/domain/entities/user.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepo {
  Future<Either<Failuer, User>> signup({
    required String name,
    required String email,
    required String password,
  });

  Future<Either<Failuer, User>> signin({
    required String email,
    required String password,
  });
}
