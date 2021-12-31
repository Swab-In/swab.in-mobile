class Forum {
  final String title;
  final String imageUrl;
  final String writer;
  final String content;

  Forum(
      {required this.title,
      required this.imageUrl,
      required this.content,
      required this.writer});

  factory Forum.fromJson(Map<String, dynamic> json) {
    return Forum(
        title: json['title'],
        imageUrl: json['image'],
        content: json['content'],
        writer: json['writer']);
  }
}