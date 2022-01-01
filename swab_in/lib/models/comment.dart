class Comment {
  final String komen;
  final String user_id;
  final String post_id;

  Comment({required this.komen, required this.user_id, required this.post_id});

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
      komen: json["fields"]['komen'],
      user_id: json["fields"]['user_id'],
      post_id: json["fields"]['post_id']);

  Map<String, dynamic> toJson() => {
        "komen": komen,
        "user_id": user_id,
        "post_id": post_id,
      };
}
