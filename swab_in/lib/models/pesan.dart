import 'package:flutter/material.dart';

class Pesan {
  final String first;
  final String last;
  final String email;
  final String no_hp;
  final String message;

  Pesan(
      {required this.first,
      required this.last,
      required this.email,
      required this.no_hp,
      required this.message});

  factory Pesan.fromJson(Map<String, dynamic> json) {
    return Pesan(
        first: json['first'],
        last: json['last'],
        email: json['email'],
        no_hp: json['no_hp'],
        message: json['message']);
  }
}
