import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../models/lokasi.dart';

class CreateLokasi extends StatefulWidget {
  const CreateLokasi({Key? key}) : super(key: key);

  @override
  _CreateLokasiState createState() => _CreateLokasiState();
}

Future<Post?> createPost(String author, String lokasi, String detail) async {
  String date_posted = DateFormat.yMMMEd().format(DateTime.now());

  final String apiUrl = "http://127.0.0.1:8000/forum/json_lokasi";

  final response = await http.post(Uri.parse(apiUrl), body: {
    "author": author,
    "lokasi": lokasi,
    "detail": detail,
    "date_posted": date_posted,
    "lokasi_pic": "",
  });

  if (response.statusCode == 201) {
    final String responseString = response.body;
    print(responseString);
    return PostFromJson(responseString);
  } else {
    return null;
  }
}

class _CreateLokasiState extends State<CreateLokasi> {
  late Post _post;

  final TextEditingController authorController = TextEditingController();
  final TextEditingController lokasiController = TextEditingController();
  final TextEditingController detailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              Text(
                "Lokasi",
                style: TextStyle(fontSize: 22, color: Colors.white),
              )
            ]),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: <Widget>[
          GestureDetector(
            onTap: () async {
              final String author = authorController.text;
              final String lokasi = authorController.text;
              final String detail = authorController.text;

              final Post? post = await createPost(author, lokasi, detail);

              setState(() {
                _post = post!;
              });
              Navigator.pop(context);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.file_upload),
            ),
          )
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              height: 150,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(6)),
              width: MediaQuery.of(context).size.width,
              child: Icon(
                Icons.add_a_photo,
                color: Colors.black45,
              ),
            ),
            SizedBox(
              height: 45,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: authorController,
                    decoration: InputDecoration(hintText: "Nama Author"),
                  ),
                  TextField(
                    controller: lokasiController,
                    decoration: InputDecoration(hintText: "Lokasi"),
                  ),
                  TextField(
                    maxLines: 3,
                    controller: detailController,
                    decoration:
                        InputDecoration(hintText: "Deskripsi singkat/alamat"),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
