import 'package:blog_app/core/exception/failuer.dart';
import 'package:blog_app/core/usercase/usercase.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/domain/repository/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetAllBlogs implements UseCase<List<Blog>, NoParam> {
  final BlogRepository blogRepository;

  GetAllBlogs({required this.blogRepository});

  @override
  Future<Either<Failuer, List<Blog>>> call(NoParam param) async {
    return await blogRepository.getAllBlgos();
  }
}
