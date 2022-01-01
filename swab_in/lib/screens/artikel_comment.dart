// import 'dart:convert';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// // import "string_extension.dart";

// class CommentState extends StatefulWidget {
//   const CommentState({Key? key, required this.title}) : super(key: key);

//   final String title;

//   @override
//   State<CommentState> createState() => CommentScreen();
// }

// class Comment {
//   final String comment;
//   final String userId;

//   Comment({required this.comment, required this.userId});

//   factory Comment.fromJson(Map<String, dynamic> json) {
//     return Comment(comment: json['komen'], userId: json['user_id']);
//   }
// }

// List<Comment> parseComment(String responseBody) {
//   final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

//   return parsed.map<Comment>((json) => Comment.fromJson(json)).toList();
// }

// Future<List<Comment>> fetchComment() async {
//   final response =
//       await http.get(Uri.parse('http://127.0.0.1:8000/artikel/get_comment'));

//   if (response.statusCode == 200) {
//     // If the server did return a 200 OK response,
//     // then parse the JSON.
//     return compute(parseComment, response.body);
//   } else {
//     // If the server did not return a 200 OK response,
//     // then throw an exception.
//     throw Exception('Failed to load Comment');
//   }
// }

// class Artikel {
//   String text;
//   String foto;
//   String author;
//   String isi;

//   Artikel({
//     required this.text,
//     required this.foto,
//     required this.author,
//     required this.isi,
//   });

//   factory Artikel.fromJson(Map<String, dynamic> json) {
//     return Artikel(
//         text: json['judul'],
//         foto: json['foto'],
//         author: json['author'],
//         isi: json['isi']);
//   }
// }

// List<Artikel> parseArtikel(String responseBody) {
//   final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

//   return parsed.map<Artikel>((json) => Artikel.fromJson(json)).toList();
// }

// Future<List<Artikel>> fetchArtikel() async {
//   final response =
//       await http.get(Uri.parse('http://127.0.0.1:8000/artikel/get_artikel'));

//   if (response.statusCode == 200) {
//     // If the server did return a 200 OK response,
//     // then parse the JSON.
//     return compute(parseArtikel, response.body);
//   } else {
//     // If the server did not return a 200 OK response,
//     // then throw an exception.
//     throw Exception('Failed to load Artikel');
//   }
// }

// // class CommentScreen extends State<CommentState> {
// //   final _formKey = GlobalKey<FormState>();
// //   List<Widget> listW = [];
// //   late Future<List<Artikel>> futureArtikel;
// //   late Future<List<Comment>> futureComment;
// //   var list = <Widget>[];
// //   bool firstfetch = true;

// //   TextEditingController CommentController = TextEditingController();

// //   @override
// //   void initState() {
// //     super.initState();
// //     futureArtikel = fetchArtikel();
// //     futureComment = fetchComment();
// //   }



// // import 'dart:convert';
// // import 'package:flutter/foundation4.dart';
// // import 'package:flutter/material.dart';
// // import 'package:http/http.dart' as http;
// // import 'package:swab_in/screens/main_screen.dart';
// // import "string_extension.dart";
// // import '../models/komentar.dart';
// // import '../models/forum.dart';

// // class KomentarScreen extends StatefulWidget {
// //   const KomentarScreen({Key? key, required this.title, required this.pk})
// //       : super(key: key);

// //   final String title;
// //   final String pk;
// //   static const routeName = '/komentar-thread';

// //   @override
// //   KomentarState createState() => KomentarState();
// // }

// // class KomentarArguments {
// //   final String pk;
// //   final String title;

// //   KomentarArguments({required this.pk, required this.title});
// // }

// // List<Komentar> parseKomentar(String responseBody) {
// //   final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

// //   return parsed.map<Komentar>((json) => Komentar.fromJson(json)).toList();
// // }

// // Future<List<Komentar>> fetchKomentar(dynamic pk) async {
// //   final response = await http.get(
// //       Uri.parse('http://10.0.2.2:8000/forum/get_komentar'),
// //       headers: {'pk': pk.toString()});

// //   if (response.statusCode == 200) {
// //     // If the server did return a 200 OK response,
// //     // then parse the JSON.
// //     return compute(parseKomentar, response.body);
// //   } else {
// //     // If the server did not return a 200 OK response,
// //     // then throw an exception.
// //     throw Exception('Failed to load Komentar');
// //   }
// // }

// // List<Forum> parseForum(String responseBody) {
// //   final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

// //   return parsed.map<Forum>((json) => Forum.fromJson(json)).toList();
// // }

// // Future<List<Forum>> fetchForum(dynamic pk) async {
// //   final response = await http.get(
// //       Uri.parse('http://10.0.2.2:8000/forum/forum_content'),
// //       headers: {'pk': pk.toString()});

// //   if (response.statusCode == 200) {
// //     // If the server did return a 200 OK response,
// //     // then parse the JSON.
// //     return compute(parseForum, response.body);
// //   } else {
// //     // If the server did not return a 200 OK response,
// //     // then throw an exception.
// //     throw Exception('Failed to load Forum');
// //   }
// // }

// // class KomentarState extends State<KomentarScreen> {
// //   final _formKey = GlobalKey<FormState>();
// //   List<Widget> listW = [];
// //   late Future<List<Forum>> futureForum;
// //   late Future<List<Komentar>> futureKomentar;
// //   var list = <Widget>[];
// //   bool firstfetch = true;

// //   TextEditingController komentarController = TextEditingController();

// //   @override
// //   void initState() {
// //     super.initState();
// //     futureForum = fetchForum(widget.pk);
// //     futureKomentar = fetchKomentar(widget.pk);
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //         resizeToAvoidBottomInset: false,
// //         appBar: AppBar(
// //           title: Text(widget.title),
// //           leading: IconButton(
// //             icon: Icon(Icons.arrow_back, color: Colors.black),
// //             onPressed: () => Navigator.of(context)
// //                 .pushReplacementNamed(MainScreen.routeName),
// //           ),
// //         ),
// //         body: Container(
// //             margin: const EdgeInsets.only(left: 20, right: 20),
// //             padding: const EdgeInsets.only(top: 10),
// //             child: ListView(
// //               children: <Widget>[
// //                 ClipRRect(
// //                   borderRadius: BorderRadius.circular(8.0),
// //                   child: FutureBuilder<List<Forum>>(
// //                     future: futureForum,
// //                     builder: (context, snapshot) {
// //                       if (snapshot.hasData) {
// //                         return Image.network(snapshot.data![0].imageUrl);
// //                       } else if (snapshot.hasError) {
// //                         return Text('${snapshot.error}');
// //                       } else {
// //                         return const CircularProgressIndicator();
// //                       }

// //                       // By default, show a loading spinner.
// //                     },
// //                   ),
// //                 ),
// //                 Container(
// //                   decoration: BoxDecoration(color: Color(0xff7c94b6)),
// //                   margin: const EdgeInsets.only(top: 25, bottom: 5),
// //                   child: const Text("Review Swab",
// //                       style:
// //                           TextStyle(fontSize: 30, fontWeight: FontWeight.w700)),
// //                 ),
// //                 Container(
// //                   padding: const EdgeInsets.only(bottom: 20),
// //                   child: Column(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: <Widget>[
// //                       FutureBuilder<List<Forum>>(
// //                         future: futureForum,
// //                         builder: (context, snapshot) {
// //                           if (snapshot.hasData) {
// //                             return Text(snapshot.data![0].content);
// //                           } else if (snapshot.hasError) {
// //                             return Text('${snapshot.error}');
// //                           } else {
// //                             return const CircularProgressIndicator();
// //                           }

// //                           // By default, show a loading spinner.
// //                         },
// //                       ),
// //                       const SizedBox(height: 10),
// //                       FutureBuilder<List<Forum>>(
// //                         future: futureForum,
// //                         builder: (context, snapshot) {
// //                           if (snapshot.hasData) {
// //                             String writer =
// //                                 snapshot.data![0].writer.capitalize();
// //                             return Text("Ditulis oleh: $writer",
// //                                 style: const TextStyle(
// //                                     fontSize: 16, fontWeight: FontWeight.w600));
// //                           } else if (snapshot.hasError) {
// //                             return Text('${snapshot.error}');
// //                           } else {
// //                             return const CircularProgressIndicator();
// //                           }

// //                           // By default, show a loading spinner.
// //                         },
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //                 Form(
// //                     key: _formKey,
// //                     child: Column(
// //                       children: [
// //                         TextFormField(
// //                             controller: komentarController,
// //                             decoration: const InputDecoration(
// //                                 hintText: "Masukkan komentar anda")),
// //                         Container(
// //                             alignment: Alignment.bottomRight,
// //                             margin: const EdgeInsets.only(top: 10, bottom: 10),
// //                             child: ElevatedButton(
// //                                 onPressed: () async {
// //                                   if (komentarController.text.isNotEmpty) {
// //                                     await http
// //                                         .post(
// //                                           Uri.parse(
// //                                               'http://10.0.2.2:8000/forum/komentar_post'),
// //                                           headers: <String, String>{
// //                                             'Content-Type':
// //                                                 'application/json; charset=UTF-8',
// //                                           },
// //                                           body: jsonEncode(<String, dynamic>{
// //                                             'komentar': komentarController.text,
// //                                             'forumId': widget.pk,
// //                                             'userId': 1
// //                                           }),
// //                                         )
// //                                         .then((value) => {
// //                                               setState(() {
// //                                                 komentarController.clear();
// //                                                 List<Komentar> lst =
// //                                                     parseKomentar(value.body);
// //                                                 firstfetch = false;
// //                                                 list.add(Container(
// //                                                   child: Column(
// //                                                     crossAxisAlignment:
// //                                                         CrossAxisAlignment
// //                                                             .start,
// //                                                     children: <Widget>[
// //                                                       Text(
// //                                                         lst[0]
// //                                                             .userId
// //                                                             .capitalize(),
// //                                                         style: const TextStyle(
// //                                                           fontSize: 18,
// //                                                           fontWeight:
// //                                                               FontWeight.w600,
// //                                                         ),
// //                                                       ),
// //                                                       const SizedBox(
// //                                                           height: 10),
// //                                                       Text(lst[0].komentar),
// //                                                     ],
// //                                                   ),
// //                                                   padding:
// //                                                       const EdgeInsets.fromLTRB(
// //                                                           0, 10, 0, 10),
// //                                                 ));
// //                                               }),
// //                                               ScaffoldMessenger.of(context)
// //                                                   .showSnackBar(
// //                                                 SnackBar(
// //                                                     behavior: SnackBarBehavior
// //                                                         .floating,
// //                                                     shape:
// //                                                         RoundedRectangleBorder(
// //                                                             borderRadius:
// //                                                                 BorderRadius
// //                                                                     .circular(
// //                                                                         24)),
// //                                                     content: const Text(
// //                                                         'Komentar berhasil ditambahkan')),
// //                                               )
// //                                             });
// //                                   }
// //                                 },
// //                                 child: Container(
// //                                   padding:
// //                                       const EdgeInsets.fromLTRB(5, 7, 5, 7),
// //                                   child: const Text(
// //                                     "Reply",
// //                                     style: TextStyle(
// //                                       fontSize: 20,
// //                                       fontWeight: FontWeight.w600,
// //                                     ),
// //                                   ),
// //                                 ))),
// //                       ],
// //                     )),
// //                 const Text(
// //                   "Replies :",
// //                   style: TextStyle(
// //                     fontSize: 25,
// //                     fontWeight: FontWeight.w600,
// //                   ),
// //                 ),
// //                 Container(
// //                   width: double.infinity,
// //                   color: const Color.fromRGBO(237, 253, 255, 1),
// //                   margin: const EdgeInsets.all(15),
// //                   padding: const EdgeInsets.all(10),
// //                   child: Column(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: <Widget>[
// //                       FutureBuilder<List<Komentar>>(
// //                         future: futureKomentar,
// //                         builder: (context, snapshot) {
// //                           if (snapshot.hasData) {
// //                             if (firstfetch) {
// //                               for (int i = 0; i < snapshot.data!.length; i++) {
// //                                 list.add(Container(
// //                                   child: Column(
// //                                     crossAxisAlignment:
// //                                         CrossAxisAlignment.start,
// //                                     children: <Widget>[
// //                                       Text(
// //                                         snapshot.data![i].userId.capitalize(),
// //                                         style: const TextStyle(
// //                                           fontSize: 18,
// //                                           fontWeight: FontWeight.w600,
// //                                         ),
// //                                       ),
// //                                       const SizedBox(height: 10),
// //                                       Text(snapshot.data![i].komentar),
// //                                     ],
// //                                   ),
// //                                   padding:
// //                                       const EdgeInsets.fromLTRB(0, 10, 0, 10),
// //                                 ));
// //                               }
// //                             }
// //                             return Column(
// //                               children: list,
// //                               crossAxisAlignment: CrossAxisAlignment.start,
// //                             );
// //                           } else if (snapshot.hasError) {
// //                             return Text('${snapshot.error}');
// //                           } else {
// //                             return const CircularProgressIndicator();
// //                           }

// //                           // By default, show a loading spinner.
// //                         },
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //               ],
// //             )));
// //   }
// // }