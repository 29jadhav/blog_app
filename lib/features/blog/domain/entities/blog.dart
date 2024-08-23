// ignore_for_file: public_member_api_docs, sort_constructors_first

class Blog {
  final String id;
  final DateTime updatedTime;
  final String title;
  final String content;
  final String imageUrl;
  final List<String> topics;
  final String profileId;

  Blog({
    required this.id,
    required this.updatedTime,
    required this.title,
    required this.content,
    required this.imageUrl,
    required this.topics,
    required this.profileId,
  });
}
