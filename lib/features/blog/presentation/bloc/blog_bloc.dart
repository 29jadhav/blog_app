import 'dart:async';
import 'dart:io';

import 'package:blog_app/core/exception/failuer.dart';
import 'package:blog_app/core/usercase/usercase.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/domain/usecases/get_all_blogs.dart';
import 'package:blog_app/features/blog/domain/usecases/upload_blog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_bloc_event.dart';
part 'blog_bloc_state.dart';

class BlogBloc extends Bloc<BlogBlocEvent, BlogBlocState> {
  final UploadBlog _uploadBlogUsecase;
  final GetAllBlogs _getAllBlogs;

  BlogBloc(
      {required UploadBlog uploadBlogUsecase, required GetAllBlogs getAllBlogs})
      : _uploadBlogUsecase = uploadBlogUsecase,
        _getAllBlogs = getAllBlogs,
        super(BlogBlocInitial()) {
    on<BlogBlocEvent>((_, emit) => emit(BlogBlocLoading()));
    on<UploadBlogEvent>(_uploadBlog);
    on<GetAllBlogEvent>(_downloadBlog);
  }

  FutureOr<void> _uploadBlog(
      UploadBlogEvent event, Emitter<BlogBlocState> emit) async {
    final response = await _uploadBlogUsecase(
      UploadBlogParams(
          profileId: event.profileId,
          title: event.title,
          content: event.content,
          image: event.image,
          topics: event.topics),
    );

    response.fold((failuer) {
      emit(BlogBlocFailuer(errorMessage: failuer.errorMessage));
    }, (success) => emit(BlogBlocSuccess()));
  }

  void _downloadBlog(GetAllBlogEvent event, Emitter<BlogBlocState> emit) async {
    final response = await _getAllBlogs(NoParam());

    response.fold(
        (failuer) => emit(BlogBlocFailuer(errorMessage: failuer.toString())),
        (blogs) {
      print("response=${blogs.length}");
      emit(DownloadBlogSuccess(blogs: blogs));
    });
    //(blogs) => emit(DownloadBlogSuccess(blogs: blogs)));
  }
}
