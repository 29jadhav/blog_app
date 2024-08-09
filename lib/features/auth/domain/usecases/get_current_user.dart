import 'package:blog_app/core/exception/failuer.dart';
import 'package:blog_app/core/usercase/usercase.dart';
import 'package:blog_app/core/common/entities/user.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repo.dart';
import 'package:fpdart/fpdart.dart';

class GetCurrentUser implements UseCase<User, NoParam> {
  final AuthRepo authRepo;

  GetCurrentUser({required this.authRepo});

  @override
  Future<Either<Failuer, User>> call(param) async {
    return await authRepo.getCurrentUser();
  }
}
