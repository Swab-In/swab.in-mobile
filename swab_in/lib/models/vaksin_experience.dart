import 'dart:convert';

class VaksinExperience {
    final int vaksinId;
    final String? penulis;
    final String pengalamanVaksin;
    final int pk;

  VaksinExperience({
    required this.vaksinId,
    required this.penulis,
    required this.pengalamanVaksin,
    required this.pk
  });

  factory VaksinExperience.fromJson(Map<String, dynamic> json) => VaksinExperience(
      vaksinId: json["fields"]["swab_id"],
      penulis: json["fields"]["penulis"],
      pengalamanVaksin: json["fields"]["pengalamanSwab"],
      pk: json["pk"]
  );

  Map<String, dynamic> toJson() => {
    "swabId": vaksinId,
    "penulis": penulis,
    "pengalamanSwab": pengalamanVaksin,
  };
}