part of 'blog_bloc.dart';

@immutable
sealed class BlogBlocState {}

final class BlogBlocInitial extends BlogBlocState {}

final class BlogBlocLoading extends BlogBlocState {}

final class BlogBlocSuccess extends BlogBlocState {}

final class BlogBlocFailuer extends BlogBlocState {
  final String errorMessage;

  BlogBlocFailuer({required this.errorMessage});
}
