import 'dart:async';
import 'dart:io';

import 'package:blog_app/features/blog/domain/usecases/upload_blog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_bloc_event.dart';
part 'blog_bloc_state.dart';

class BlogBloc extends Bloc<BlogBlocEvent, BlogBlocState> {
  final UploadBlog _uploadBlogUsecase;

  BlogBloc(this._uploadBlogUsecase) : super(BlogBlocInitial()) {
    on<UploadBlogEvent>(_uploadBlog);
  }

  FutureOr<void> _uploadBlog(
      UploadBlogEvent event, Emitter<BlogBlocState> emit) async {
    emit(BlogBlocLoading());
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
}
