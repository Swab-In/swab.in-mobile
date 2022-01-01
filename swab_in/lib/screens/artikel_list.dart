import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'artikel_detail.dart';

class Artikel {
  String text;
  String author;
  String foto;
  int pk;

  Artikel(
      {required this.text,
      required this.author,
      required this.foto,
      required this.pk});

  factory Artikel.fromJson(Map<String, dynamic> json) {
    return Artikel(
        text: json['judul'],
        author: json['author'],
        foto: json['foto'],
        pk: json['pk']);
  }
}

class ArtikelScreen extends StatefulWidget {
  static const routeName = '/list-artikel';
  const ArtikelScreen({Key? key}) : super(key: key);

  @override
  ArtikelState createState() => ArtikelState();
}

List<Artikel> parseArtikel(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Artikel>((json) => Artikel.fromJson(json)).toList();
}

Future<List<Artikel>> fetchArtikel() async {
  final response =
      await http.get(Uri.parse('https://swab-in.herokuapp.com/artikel/artikel_cards'));
  // print(response.body);
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

class ArtikelState extends State<ArtikelScreen> {
  List<Artikel> artikels = [];
  List<Widget> list = [];
  late Future<List<Artikel>> futureArtikel;

  @override
  void initState() {
    super.initState();
    futureArtikel = fetchArtikel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Artikel Swab.In'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView(
        children: [
          FutureBuilder<List<Artikel>>(
            future: futureArtikel,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                for (int i = 0; i < snapshot.data!.length; i++) {
                  list.add(Card(
                      margin: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Image.network(snapshot.data![i].foto),
                            Text(
                              snapshot.data![i].text,
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.grey[600],
                              ),
                            ),
                            SizedBox(height: 6.0),
                            Text(
                              snapshot.data![i].author,
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.grey[800],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                TextButton(
                                  child: const Text('Selengkapnya'),
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, ArtikelDetailScreen.routeName,
                                        arguments: i);
                                  },
                                ),
                                const SizedBox(width: 8),
                              ],
                            ),
                          ],
                        ),
                      )));
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
    );
  }
}
