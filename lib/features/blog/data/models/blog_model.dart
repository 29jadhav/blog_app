import 'dart:convert';

import 'package:blog_app/features/blog/domain/entities/blog.dart';

class BlogModel extends Blog {
  BlogModel({
    required super.id,
    required super.updatedTime,
    required super.title,
    required super.content,
    required super.imageUrl,
    required super.topics,
    required super.profileId,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'updated_at': updatedTime.toIso8601String(),
      'title': title,
      'content': content,
      'image_url': imageUrl,
      'topics': topics,
      'profile_id': profileId,
    };
  }

  factory BlogModel.fromJson(Map<String, dynamic> map) {
    return BlogModel(
      id: map['id'] as String,
      updatedTime: map['updated_at'] == null
          ? DateTime.now()
          : DateTime.parse(map['updated_at']),
      title: map['title'] as String,
      content: map['content'] as String,
      imageUrl: map['image_url'] as String,
      topics: List<String>.from(map['topics'] ?? []),
      profileId: map['profile_id'] as String,
    );
  }

  BlogModel copyWith({
    String? id,
    DateTime? updatedTime,
    String? title,
    String? content,
    String? imageUrl,
    List<String>? topics,
    String? profileId,
  }) {
    return BlogModel(
      id: id ?? this.id,
      updatedTime: updatedTime ?? this.updatedTime,
      title: title ?? this.title,
      content: content ?? this.content,
      imageUrl: imageUrl ?? this.imageUrl,
      topics: topics ?? this.topics,
      profileId: profileId ?? this.profileId,
    );
  }
}
