import 'package:blog_app/core/exception/failuer.dart';
import 'package:blog_app/core/usercase/usercase.dart';
import 'package:blog_app/features/auth/domain/entities/user.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repo.dart';
import 'package:fpdart/fpdart.dart';

class UserSignin implements UseCase<User, UserSigninParam> {
  final AuthRepo authRepo;
  const UserSignin({required this.authRepo});

  @override
  Future<Either<Failuer, User>> call(UserSigninParam param) async {
    return await authRepo.signin(
      email: param.email,
      password: param.password,
    );
  }
}

class UserSigninParam {
  final String email;
  final String password;
  UserSigninParam({
    required this.email,
    required this.password,
  });
}
