import 'dart:convert';

class Vaksin {
  final String nama;
  final String produsen;
  final String frekuensi;
  final String efikasi;
  final String deskripsi;
  final String gambar;
  final int pk;

  Vaksin({
    required this.nama,
    required this.produsen,
    required this.frekuensi,
    required this.efikasi,
    required this.deskripsi,
    required this.gambar,
    required this.pk,
  });

  factory Vaksin.fromJson(Map<String, dynamic> json) => Vaksin(
        nama: json["fields"]["nama"],
        produsen: json["fields"]["produsen"],
        frekuensi: json["fields"]["frekuensi"],
        efikasi: json["fields"]["efikasi"],
        deskripsi: json["fields"]["deskripsi"],
        gambar: json["fields"]["gambar"],
        pk: json["pk"]
      );

  Map<String, dynamic> toJson() => {
        "nama": nama,
        "produsen": produsen,
        "frekuensi": frekuensi,
        "efikasi": efikasi,
        "deskripsi": deskripsi,
        "gambar": gambar,
      };
}
