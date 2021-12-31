
// // ignore_for_file: non_constant_identifier_names
import 'dart:convert';

class Forum {
    final String writer;
    final String image;
    final String title;
    final String message;
    final int post_id;
    final int pk;

  Forum({
    required this.writer,
    required this.image,
    required this.title,
    required this.message,
    required this.post_id,
    required this.pk
  });

  factory Forum.fromJson(Map<String, dynamic> json) => Forum(
      writer: json["writer"],
      image: json["fields"]["image"],
      title: json["fields"]["title"],
      message: json["fields"]["message"],
      post_id: json["fields"]["post_id"],
      pk : json["pk"]
  );

  Map<String, dynamic> toJson() => {
    "writer": writer,
    "title": title,
    "message": message,
    "image": image,
    "post_id": post_id,
  };
}

class Forums {
  final String title;
  final String imageUrl;
  final String writer;
  final String content;

  Forums (
      {required this.title,
      required this.imageUrl,
      required this.content,
      required this.writer});

  factory Forums.fromJson(Map<String, dynamic> json) {
    return Forums(
        title: json['title'],
        imageUrl: json['image'],
        content: json['content'],
        writer: json['writer']);
  }
}