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