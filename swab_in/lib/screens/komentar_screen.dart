import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swab_in/screens/main_screen.dart';
import "string_extension.dart";
import '../models/komentar.dart';
import '../models/forum.dart';

class KomentarScreen extends StatefulWidget {
  const KomentarScreen({Key? key, required this.title, required this.pk})
      : super(key: key);

  final String title;
  final String pk;
  static const routeName = '/komentar-thread';

  @override
  KomentarState createState() => KomentarState();
}

class KomentarArguments {
  final String pk;
  final String title;

  KomentarArguments({required this.pk, required this.title});
}

List<Komentar> parseKomentar(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Komentar>((json) => Komentar.fromJson(json)).toList();
}

Future<List<Komentar>> fetchKomentar(dynamic pk) async {
  final response = await http.get(
      Uri.parse('http://localhost:8000/forum/get_komentar'),
      headers: {'pk': pk.toString()});

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return compute(parseKomentar, response.body);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Komentar');
  }
}

List<Forum> parseForum(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Forum>((json) => Forum.fromJson(json)).toList();
}

Future<List<Forum>> fetchForum(dynamic pk) async {
  final response = await http.get(
      Uri.parse('http://localhost:8000/forum/forum_content'),
      headers: {'pk': pk.toString()});

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return compute(parseForum, response.body);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Forum');
  }
}

class KomentarState extends State<KomentarScreen> {
  final _formKey = GlobalKey<FormState>();
  List<Widget> listW = [];
  late Future<List<Forum>> futureForum;
  late Future<List<Komentar>> futureKomentar;
  var list = <Widget>[];
  bool firstfetch = true;
  String? user;
  int? userId;

  _getState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.get('counter'));
  }

  TextEditingController komentarController = TextEditingController();

  void _loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      user = prefs.getString('userName');
      userId = prefs.getInt('user_id');
    });
    
  }

  @override
  void initState() {
    super.initState();
    futureForum = fetchForum(widget.pk);
    futureKomentar = fetchKomentar(widget.pk);
    _getState();
    _loadUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(widget.title),
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
                  child: FutureBuilder<List<Forum>>(
                    future: futureForum,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Image.network(snapshot.data![0].imageUrl);
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
                  child: const Text("Review Swab",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w700)),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      FutureBuilder<List<Forum>>(
                        future: futureForum,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(snapshot.data![0].content);
                          } else if (snapshot.hasError) {
                            return Text('${snapshot.error}');
                          } else {
                            return const CircularProgressIndicator();
                          }

                          // By default, show a loading spinner.
                        },
                      ),
                      const SizedBox(height: 10),
                      FutureBuilder<List<Forum>>(
                        future: futureForum,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            String writer =
                                snapshot.data![0].writer.capitalize();
                            return Text("Ditulis oleh: $writer",
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600));
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
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                            controller: komentarController,
                            decoration: const InputDecoration(
                                hintText: "Masukkan komentar anda")),
                        Container(
                            alignment: Alignment.bottomRight,
                            margin: const EdgeInsets.only(top: 10, bottom: 10),
                            child: ElevatedButton(
                                onPressed: () async {
                                  if (komentarController.text.isNotEmpty) {
                                    await http
                                        .post(
                                          Uri.parse(
                                              'http://localhost:8000/forum/komentar_post'),
                                          headers: <String, String>{
                                            'Content-Type':
                                                'application/json; charset=UTF-8',
                                          },
                                          body: jsonEncode(<String, dynamic>{
                                            'komentar': komentarController.text,
                                            'forumId': widget.pk,
                                            'userId': userId
                                          }),
                                        )
                                        .then((value) => {
                                              setState(() {
                                                komentarController.clear();
                                                List<Komentar> lst =
                                                    parseKomentar(value.body);
                                                firstfetch = false;
                                                list.add(Container(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Text(
                                                        lst[0]
                                                            .userId
                                                            .capitalize(),
                                                        style: const TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                          height: 10),
                                                      Text(lst[0].komentar),
                                                    ],
                                                  ),
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          0, 10, 0, 10),
                                                ));
                                              }),
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                    behavior: SnackBarBehavior
                                                        .floating,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        24)),
                                                    content: const Text(
                                                        'Komentar berhasil ditambahkan')),
                                              )
                                            });
                                  }
                                },
                                child: Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(5, 7, 5, 7),
                                  child: const Text(
                                    "Reply",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ))),
                      ],
                    )),
                const Text(
                  "Replies :",
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
                      FutureBuilder<List<Komentar>>(
                        future: futureKomentar,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            if (firstfetch) {
                              for (int i = 0; i < snapshot.data!.length; i++) {
                                list.add(Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        snapshot.data![i].userId.capitalize(),
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(snapshot.data![i].komentar),
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

                          // By default, show a loading spinner.
                        },
                      ),
                    ],
                  ),
                ),
              ],
            )));
  }
}
