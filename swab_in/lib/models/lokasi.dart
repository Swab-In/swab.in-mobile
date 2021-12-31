
import 'dart:convert';

Post PostFromJson(String str) => Post.fromJson(json.decode(str));

String PostToJson(Post data) => json.encode(data.toJson());

class Post {
    final String lokasi;
    final String detail;
    final String date_posted;
    final String lokasi_pic;
    final int pk;

  Post({
    required this.lokasi,
    required this.detail,
    required this.date_posted,
    required this.lokasi_pic,
    required this.pk
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
      lokasi: json["fields"]["lokasi"],
      detail: json["fields"]["detail"],
      date_posted: json["fields"]["date_posted"],
      lokasi_pic: json["fields"]["lokasi_pic"],
      pk: json["pk"]
  );

  Map<String, dynamic> toJson() => {
    "lokasi": lokasi,
    "detail": detail,
    "date_posted": date_posted,
    "lokasi_pic": lokasi_pic,
    "pk":pk
  };
}