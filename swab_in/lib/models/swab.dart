import 'dart:convert';

class Swab {
  final String nama;
  final String price;
  final String akurasi;
  final String prosedur;
  final String deskripsi;
  final String gambar;
  final int pk;

  Swab({
    required this.nama,
    required this.price,
    required this.akurasi,
    required this.prosedur,
    required this.deskripsi,
    required this.gambar,
    required this.pk,
  });

  factory Swab.fromJson(Map<String, dynamic> json) => Swab(
        nama: json["fields"]["nama"],
        price: json["fields"]["price"],
        akurasi: json["fields"]["akurasi"],
        prosedur: json["fields"]["prosedur"],
        deskripsi: json["fields"]["deskripsi"],
        gambar: json["fields"]["gambar"],
        pk: json["pk"]
      );

  Map<String, dynamic> toJson() => {
        "nama": nama,
        "price": price,
        "akurasi": akurasi,
        "prosedur": prosedur,
        "deskripsi": deskripsi,
        "gambar": gambar,
      };
}
