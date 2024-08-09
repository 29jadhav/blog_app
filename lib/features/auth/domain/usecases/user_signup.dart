import 'package:blog_app/core/exception/failuer.dart';
import 'package:blog_app/core/usercase/usercase.dart';
import 'package:blog_app/core/common/entities/user.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repo.dart';
import 'package:fpdart/fpdart.dart';

class UserSignup implements UseCase<User, UserSignupParam> {
  final AuthRepo authRepo;
  const UserSignup({required this.authRepo});

  @override
  Future<Either<Failuer, User>> call(UserSignupParam param) async {
    return await authRepo.signup(
      name: param.name,
      email: param.email,
      password: param.password,
    );
  }
}

class UserSignupParam {
  final String email;
  final String password;
  final String name;
  UserSignupParam({
    required this.email,
    required this.password,
    required this.name,
  });
}
