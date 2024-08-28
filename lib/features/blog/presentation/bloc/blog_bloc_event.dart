part of 'blog_bloc.dart';

@immutable
sealed class BlogBlocEvent {}

class UploadBlogEvent extends BlogBlocEvent {
  final String title;
  final String content;
  final File image;
  final List<String> topics;
  final String profileId;

  UploadBlogEvent({
    required this.title,
    required this.content,
    required this.image,
    required this.topics,
    required this.profileId,
  });
}

class GetAllBlogEvent extends BlogBlocEvent {}
