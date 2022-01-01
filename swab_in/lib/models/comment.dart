import 'dart:convert';

class Comment {
  final String komen;
  final String user_id;
  final int post_id;

  Comment({
    required this.komen,
    required this.user_id, 
    required this.post_id,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
      komen: json['komen'],
      user_id: json['user_id'],
      post_id: json['post_id'],
);

  Map<String, dynamic> toJson() => {
        "komen": komen,
        "user_id": user_id,
        "post_id": post_id,
      };
}
