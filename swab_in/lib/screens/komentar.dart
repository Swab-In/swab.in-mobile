import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class KomentarState extends StatefulWidget {
  const KomentarState({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<KomentarState> createState() => KomentarScreen();
}

class Forum {
  final String title;
  final String imageUrl;

  Forum({required this.title, required this.imageUrl});

  factory Forum.fromJson(Map<String, dynamic> json) {
    return Forum(
      title: json['title'],
      imageUrl: json['image'],
    );
  }
}

List<Forum> parseForum(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Forum>((json) => Forum.fromJson(json)).toList();
}

Future<List<Forum>> fetchForum() async {
  final response =
      await http.get(Uri.parse('http://10.0.2.2:8000/forum/forum_content'));

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

class KomentarScreen extends State<KomentarState> {
  final _formKey = GlobalKey<FormState>();

  late Future<List<Forum>> futureForum;

  TextEditingController komentarController = TextEditingController();

  @override
  void initState() {
    super.initState();
    futureForum = fetchForum();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            padding: EdgeInsets.only(top: 10),
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
                  margin: EdgeInsets.only(top: 25, bottom: 5),
                  child: Text("Review Swab",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w700)),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text("Ditulis oleh: ejet",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600)),
                      SizedBox(height: 10),
                      const Text(
                          "Awalnya waktu saya mau memilih tempat swab, saya pilih tes swab di Yos Sudarso karena dekat dari rumah. Ternyata pelayanannya bagus dan hasil swabnya juga cepat keluar"),
                    ],
                  ),
                ),
                Form(
                    key: _formKey,
                    child: Container(
                        child: Column(
                      children: [
                        TextFormField(
                            controller: komentarController,
                            decoration: new InputDecoration(
                                hintText: "Masukkan komentar anda")),
                        Container(
                            alignment: Alignment.bottomRight,
                            margin: EdgeInsets.only(top: 10, bottom: 10),
                            child: ElevatedButton(
                                onPressed: () async {
                                  final response = await http.post(
                                    Uri.parse(
                                        'http://10.0.2.2:8000/forum/komentar_post'),
                                    headers: <String, String>{
                                      'Content-Type':
                                          'application/json; charset=UTF-8',
                                    },
                                    body: jsonEncode(<String, dynamic>{
                                      'komentar': komentarController.text,
                                      'forumId': 1,
                                      'userId': 1
                                    }),
                                  );
                                  print(response.body);
                                },
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(5, 7, 5, 7),
                                  child: const Text(
                                    "Reply",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ))),
                      ],
                    ))),
                const Text(
                  "Replies :",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Container(
                  width: double.infinity,
                  color: Color.fromRGBO(237, 253, 255, 1),
                  margin: EdgeInsets.all(15),
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Swabdev",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500)),
                            Text("Bener banget"),
                          ]),
                      SizedBox(height: 15),
                    ],
                  ),
                ),
              ],
            )));
  }
}
