import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import "string_extension.dart";

class CommentState extends StatefulWidget {
  const CommentState({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  // State<CommentState> createState() => CommentScreen();
}

class Comment {
  final String comment;
  final String userId;

  Comment({required this.comment, required this.userId});

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(comment: json['komen'], userId: json['user_id']);
  }
}

List<Comment> parseComment(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Comment>((json) => Comment.fromJson(json)).toList();
}

Future<List<Comment>> fetchComment() async {
  final response =
      await http.get(Uri.parse('http://127.0.0.1:8000/artikel/get_comment'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return compute(parseComment, response.body);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Comment');
  }
}

class Artikel {
  String text;
  String foto;
  String author;
  String isi;

  Artikel({
    required this.text,
    required this.foto,
    required this.author,
    required this.isi,
  });

  factory Artikel.fromJson(Map<String, dynamic> json) {
    return Artikel(
        text: json['judul'],
        foto: json['foto'],
        author: json['author'],
        isi: json['isi']);
  }
}

List<Artikel> parseArtikel(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Artikel>((json) => Artikel.fromJson(json)).toList();
}

Future<List<Artikel>> fetchArtikel() async {
  final response =
      await http.get(Uri.parse('http://127.0.0.1:8000/artikel/get_artikel'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return compute(parseArtikel, response.body);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Artikel');
  }
}

// class CommentScreen extends State<CommentState> {
//   final _formKey = GlobalKey<FormState>();
//   List<Widget> listW = [];
//   late Future<List<Artikel>> futureArtikel;
//   late Future<List<Comment>> futureComment;
//   var list = <Widget>[];
//   bool firstfetch = true;

//   TextEditingController CommentController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     futureArtikel = fetchArtikel();
//     futureComment = fetchComment();
//   }