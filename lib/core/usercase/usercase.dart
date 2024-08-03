import 'package:blog_app/core/exception/failuer.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class UseCase<SuccessType, Param> {
  Future<Either<Failuer, SuccessType>> call(Param param);
}
