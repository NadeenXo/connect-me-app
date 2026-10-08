import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/post.dart';

class PostModel extends Post {
  const PostModel({
    required super.id,
    required super.authorId,
    required super.authorName,
    required super.content,
    required super.createdAt,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    final timestamp = json['createdAt'];

    return PostModel(
      id: json['id'] ?? '',
      authorId: json['authorId'] ?? '',
      authorName: json['authorName'] ?? '',
      content: json['content'] ?? '',
      createdAt: timestamp is Timestamp
          ? timestamp.toDate()
          : DateTime.tryParse(timestamp?.toString() ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'authorId': authorId,
      'authorName': authorName,
      'content': content,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
