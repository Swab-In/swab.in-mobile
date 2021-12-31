class Komentar {
  final String komentar;
  final String userId;

  Komentar({required this.komentar, required this.userId});

  factory Komentar.fromJson(Map<String, dynamic> json) {
    return Komentar(komentar: json['komentar'], userId: json['user_id']);
  }
}