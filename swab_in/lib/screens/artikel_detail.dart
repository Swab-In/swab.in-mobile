import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swab_in/screens/main_screen.dart';
import "../models/comment.dart";

class ArtikelDetailScreen extends StatefulWidget {
  const ArtikelDetailScreen({Key? key, required this.title, required this.pk})
      : super(key: key);

  final String title;
  final String pk;
  static const routeName = '/comment-thread';

  @override
  CommentState createState() => CommentState();
}

class ArtikelArguments {
  final String pk;

  ArtikelArguments({required this.pk});
}

Future<List<Comment>> fetchComment(BuildContext context) async {
  var args = ModalRoute.of(context)!.settings.arguments as int;
  String url = "https://swab-in.herokuapp.com/artikel/get_comment";
  try {
    var response = await http.get(
      Uri.parse(url),
      headers: {
        "Access-Control-Allow-Origin": "*",
        "Content-Type": "application/json",
      },
    );
    var data = jsonDecode(utf8.decode(response.bodyBytes));
    List<Comment> result = [];
    for (var d in data) {
      if (d["post_id"] == args + 1) {
        Comment comments = Comment(
          komen: d["komen"],
          user_id: d["user_id"],
          post_id: d["post_id"],
        );
        result.add(comments);
      }
    }
    print(result);
    return result;
  } catch (error) {
    throw Exception("Fetch Failed");
  }
}

class Artikel {
  String judul;
  String isi;
  String author;
  String foto;

  Artikel(
      {required this.judul,
      required this.author,
      required this.foto,
      required this.isi});

  factory Artikel.fromJson(Map<String, dynamic> json) {
    return Artikel(
        judul: json['judul'],
        author: json['author'],
        foto: json['foto'],
        isi: json['isi']);
  }
}

List<Artikel> parseArtikel(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Artikel>((json) => Artikel.fromJson(json)).toList();
}

Future<List<Artikel>> fetchArtikel(dynamic pk) async {
  final response = await http.get(
      Uri.parse('https://swab-in.herokuapp.com/artikel/artikel_cards'),
      headers: {'pk': pk});

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

class CommentState extends State<ArtikelDetailScreen> {
  final _formKey = GlobalKey<FormState>();
  List<Widget> listW = [];
  late Future<List<Artikel>> futureArtikel;
  late Future<List<Comment>> futureComment;
  var list = <Widget>[];
  bool firstfetch = true;

  _getState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.get('counter'));
  }

  TextEditingController commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    futureArtikel = fetchArtikel(widget.pk);
    _getState();
  }

  @override
  Widget build(BuildContext context) {
    final pk_artikel = ModalRoute.of(this.context)!.settings.arguments as int;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("Artikel Swab.In"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context)
                .pushReplacementNamed(MainScreen.routeName),
          ),
        ),
        body: Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            padding: const EdgeInsets.only(top: 10),
            child: ListView(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: FutureBuilder<List<Artikel>>(
                    future: futureArtikel,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Image.network(snapshot.data![pk_artikel].foto);
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      } else {
                        return const CircularProgressIndicator();
                      }

                      // By default, show a loading spinner.
                    },
                  ),
                ),
                Container(
                  decoration: BoxDecoration(color: Color(0xff7c94b6)),
                  margin: const EdgeInsets.only(top: 25, bottom: 5),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      FutureBuilder<List<Artikel>>(
                        future: futureArtikel,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(
                              snapshot.data![pk_artikel].judul,
                              style: const TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.w600),
                            );
                          } else if (snapshot.hasError) {
                            return Text('${snapshot.error}');
                          } else {
                            return const CircularProgressIndicator();
                          }

                          // By default, show a loading spinner.
                        },
                      ),
                      const SizedBox(height: 10),
                      FutureBuilder<List<Artikel>>(
                        future: futureArtikel,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            String author = snapshot.data![pk_artikel].author;
                            return Text("Ditulis oleh: $author",
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w400));
                          } else if (snapshot.hasError) {
                            return Text('${snapshot.error}');
                          } else {
                            return const CircularProgressIndicator();
                          }

                          // By default, show a loading spinner.
                        },
                      ),
                      const SizedBox(height: 10),
                      FutureBuilder<List<Artikel>>(
                        future: futureArtikel,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(
                              snapshot.data![pk_artikel].isi,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                              textAlign: TextAlign.left,
                            );
                          } else if (snapshot.hasError) {
                            return Text('${snapshot.error}');
                          } else {
                            return const CircularProgressIndicator();
                          }

                          // By default, show a loading spinner.
                        },
                      ),
                    ],
                  ),
                ),
                // Form(
                //     key: _formKey,
                //     child: Column(
                //       children: [
                //         TextFormField(
                //             controller: commentController,
                //             decoration: const InputDecoration(
                //                 hintText: "Masukkan comment anda")),
                //         Container(
                //             alignment: Alignment.bottomRight,
                //             margin: const EdgeInsets.only(top: 10, bottom: 10),
                //             child: ElevatedButton(
                //                 onPressed: () async {
                //                   if (commentController.text.isNotEmpty) {
                //                     await http
                //                         .post(
                //                           Uri.parse(
                //                               'http://localhost:8000/artikel/comment_post'),
                //                           headers: <String, String>{
                //                             'Content-Type':
                //                                 'application/json; charset=UTF-8',
                //                           },
                //                           body: jsonEncode(<String, dynamic>{
                //                             'comment': commentController.text,
                //                             'post_id': widget.pk,
                //                             'user_id': 1,
                //                           }),
                //                         )
                //                         .then((value) => {
                //                               setState(() {
                //                                 commentController.clear();
                //                                 // List<Comment> lst =
                //                                 // parseComment(value.body);
                //                                 firstfetch = false;
                //                                 list.add(Container(
                //                                   child: Column(
                //                                     crossAxisAlignment:
                //                                         CrossAxisAlignment
                //                                             .start,
                //                                     children: <Widget>[
                //                                       // Text(
                //                                       //   // lst[0].userId,
                //                                       //   style: const TextStyle(
                //                                       //     fontSize: 18,
                //                                       //     fontWeight:
                //                                       //         FontWeight.w600,
                //                                       //   ),
                //                                       // ),
                //                                       const SizedBox(
                //                                           height: 10),
                //                                       // Text(lst[0].comment),
                //                                     ],
                //                                   ),
                //                                   padding:
                //                                       const EdgeInsets.fromLTRB(
                //                                           0, 10, 0, 10),
                //                                 ));
                //                               }),
                //                               ScaffoldMessenger.of(context)
                //                                   .showSnackBar(
                //                                 SnackBar(
                //                                     behavior: SnackBarBehavior
                //                                         .floating,
                //                                     shape:
                //                                         RoundedRectangleBorder(
                //                                             borderRadius:
                //                                                 BorderRadius
                //                                                     .circular(
                //                                                         24)),
                //                                     content: const Text(
                //                                         'Komentar berhasil ditambahkan')),
                //                               )
                //                             });
                //                   }
                //                 },
                //                 child: Container(
                //                   padding:
                //                       const EdgeInsets.fromLTRB(5, 7, 5, 7),
                //                   child: const Text(
                //                     "Submit",
                //                     style: TextStyle(
                //                       fontSize: 20,
                //                       fontWeight: FontWeight.w600,
                //                     ),
                //                   ),
                //                 ))),
                //       ],
                //     )),
                const Text(
                  "Komentar :",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Container(
                  width: double.infinity,
                  color: const Color.fromRGBO(237, 253, 255, 1),
                  margin: const EdgeInsets.all(15),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      FutureBuilder(
                        future: fetchComment(context),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            if (firstfetch) {
                              for (int i = 0; i < snapshot.data!.length; i++) {
                                list.add(Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        snapshot.data![i].user_id,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(snapshot.data![i].komen),
                                    ],
                                  ),
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                ));
                              }
                            }
                            return Column(
                              children: list,
                              crossAxisAlignment: CrossAxisAlignment.start,
                            );
                          } else if (snapshot.hasError) {
                            return Text('${snapshot.error}');
                          } else {
                            return const CircularProgressIndicator();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            )));
  }
}
