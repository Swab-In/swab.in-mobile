import 'dart:convert';

class Experience {
    final int swabId;
    final String penulis;
    final String pengalamanSwab;
    final int pk;

  Experience({
    required this.swabId,
    required this.penulis,
    required this.pengalamanSwab,
    required this.pk
  });

  factory Experience.fromJson(Map<String, dynamic> json) => Experience(
      swabId: json["fields"]["swab_id"],
      penulis: json["fields"]["penulis"],
      pengalamanSwab: json["fields"]["pengalamanSwab"],
      pk: json["pk"]
  );

  Map<String, dynamic> toJson() => {
    "swabId": swabId,
    "penulis": penulis,
    "pengalamanSwab": pengalamanSwab,
  };
}