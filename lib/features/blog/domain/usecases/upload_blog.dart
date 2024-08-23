import 'dart:io';

import 'package:blog_app/core/exception/failuer.dart';
import 'package:blog_app/core/usercase/usercase.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/domain/repository/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class UploadBlog implements UseCase<Blog, UploadBlogParams> {
  final BlogRepository blogRepository;
  UploadBlog(this.blogRepository);

  @override
  Future<Either<Failuer, Blog>> call(UploadBlogParams param) async {
    return await blogRepository.uploadBlog(
        image: param.image,
        title: param.title,
        content: param.content,
        profileId: param.profileId,
        topics: param.topics);
  }
}

class UploadBlogParams {
  final String profileId;
  final String title;
  final String content;
  final File image;
  final List<String> topics;

  UploadBlogParams(
      {required this.profileId,
      required this.title,
      required this.content,
      required this.image,
      required this.topics});
}
