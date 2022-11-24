// ignore_for_file: public_member_api_docs, sort_constructors_first
// To parse this JSON data, do
//
//     final posts = postsFromJson(jsonString);

import 'dart:convert';

Posts postsFromJson(String str) => Posts.fromJson(json.decode(str));

class Posts {
  Posts({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  final num userId;
  final num? id;
  final String? title;
  final String? body;

  factory Posts.fromJson(Map<String, dynamic> json) => Posts(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        body: json["body"],
      );

  @override
  String toString() {
    return 'Posts(userId: $userId, id: $id, title: $title, body: $body)';
  }
}

enum Gender {
  male,
  female,
}

enum President {
  buhari,
  jonathan,
}
