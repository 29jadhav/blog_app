import 'dart:io';

import 'package:blog_app/core/exception/failuer.dart';
import 'package:blog_app/core/exception/server_exceptions.dart';
import 'package:blog_app/features/blog/data/models/blog_model.dart';
import 'package:blog_app/features/blog/datasource/blog_remote_data_source.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/domain/repository/blog_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogRemoteDateSoruce blogRemoteDataSource;

  BlogRepositoryImpl(this.blogRemoteDataSource);
  @override
  Future<Either<Failuer, Blog>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String profileId,
    required List<String> topics,
  }) async {
    try {
      BlogModel blogModel = BlogModel(
        id: const Uuid().v1(),
        updatedTime: DateTime.now(),
        title: title,
        content: content,
        imageUrl: "",
        topics: topics,
        profileId: profileId,
      );
      final imageUrl = await blogRemoteDataSource.uploadBlogImage(
          image: image, blogModel: blogModel);

      blogModel = blogModel.copyWith(imageUrl: imageUrl);
      final uploadedBlog = await blogRemoteDataSource.uploadBlog(blogModel);
      return Right(uploadedBlog);
    } on ServerExceptions catch (e) {
      return left(Failuer(errorMessage: e.errorMessage));
    }
  }

  @override
  Future<Either<Failuer, List<Blog>>> getAllBlgos() async {
    try {
      final blogList = await blogRemoteDataSource.getAllBlogs();
      //print("blogList=${blogList.length}");
      return right(blogList);
    } on ServerExceptions catch (e) {
      return left(Failuer(errorMessage: e.errorMessage));
    }
  }
}
