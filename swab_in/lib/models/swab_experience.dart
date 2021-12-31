import 'dart:convert';

class SwabExperience {
    final int swabId;
    final String penulis;
    final String pengalamanSwab;
    final int pk;

  SwabExperience({
    required this.swabId,
    required this.penulis,
    required this.pengalamanSwab,
    required this.pk
  });

  factory SwabExperience.fromJson(Map<String, dynamic> json) => SwabExperience(
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