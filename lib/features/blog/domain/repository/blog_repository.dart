import 'dart:io';

import 'package:blog_app/core/exception/failuer.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class BlogRepository {
  Future<Either<Failuer, Blog>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String profileId,
    required List<String> topics,
  });

  Future<Either<Failuer, List<Blog>>> getAllBlgos();
}
