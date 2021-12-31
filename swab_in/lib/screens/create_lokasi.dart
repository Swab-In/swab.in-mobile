import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CreateLokasi extends StatefulWidget {
  const CreateLokasi({Key? key}) : super(key: key);

  @override
  _CreateLokasiState createState() => _CreateLokasiState();
}

class _CreateLokasiState extends State<CreateLokasi> {
  late String author, lokasi, detail;

  upload() async {
    // final response = await http.post(Uri.parse("http://127.0.0.1:8000/lokasi/json"));
    // headers: <String, String>{
    //   'Content-Type': 'application/json; charset=UTF-8',
    // };
    // body: jsonEncode(<String, dynamic>{
    //   'lokasi': lokasi,
    //   'detail': detail,
    //   'date_posted' : '-',
    //   'lokasi_pic' : '-',
    //   'author' : '-',
    // });
    // print(response);
    // print(response.body);
    Navigator.pop(context);
  }

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
            ]
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              upload();
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
                    decoration: InputDecoration(hintText: "Nama Author"),
                    onChanged: (val) {
                      author = val;
                    },
                  ),
                  TextField(
                    decoration: InputDecoration(hintText: "Lokasi"),
                    onChanged: (val) {
                      lokasi = val;
                    },
                  ),
                  TextField(
                    decoration: InputDecoration(hintText: "Deskripsi singkat/alamat"),
                    onChanged: (val) {
                      detail = val;
                    },
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
