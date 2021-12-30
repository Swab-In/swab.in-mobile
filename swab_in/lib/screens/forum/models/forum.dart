// // ignore_for_file: non_constant_identifier_names
import 'dart:convert';

class Forum {
    final int writer;
    final String image;
    final String title;
    final String message;
    final int post_id;

  Forum({
    required this.writer,
    required this.image,
    required this.title,
    required this.message,
    required this.post_id,
  });

  factory Forum.fromJson(Map<String, dynamic> json) => Forum(
      writer: json["writer"],
      image: json["fields"]["image"],
      title: json["fields"]["title"],
      message: json["fields"]["message"],
      post_id: json["fields"]["post_id"],
  );

  Map<String, dynamic> toJson() => {
    "writer": writer,
    "title": title,
    "message": message,
    "image": image,
    "post_id": post_id,
  };
}

class Post {
    final String lokasi;
    final String detail;
    final String lokasi_pic;
    final int pk;

  Post({
    required this.lokasi,
    required this.detail,
    required this.lokasi_pic,
    required this.pk
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
      lokasi: json["fields"]["lokasi"],
      detail: json["fields"]["detail"],
      lokasi_pic: json["fields"]["lokasi_pic"],
      pk: json["pk"]
  );

  Map<String, dynamic> toJson() => {
    "lokasi": lokasi,
    "detail": detail,
    "lokasi_pic": lokasi_pic,
    "pk":pk
  };
}