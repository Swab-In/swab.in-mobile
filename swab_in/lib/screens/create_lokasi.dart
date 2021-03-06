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

class _CreateLokasiState extends State<CreateLokasi> {
  final _formKey = GlobalKey<FormState>();
  late Post _post;

  TextEditingController authorController = TextEditingController();
  TextEditingController lokasiController = TextEditingController();
  TextEditingController detailController = TextEditingController();

  Future<void> createLokasi() async {
    int no;
    var response = await http.get(
      Uri.parse("http://swab-in.herokuapp.com/lokasi/json"),
      headers: {
        "Access-Control-Allow-Origin": "*",
        "Content-Type": "application/json",
      },
    );
    var data = jsonDecode(utf8.decode(response.bodyBytes));
    for (var d in data) {
      no = d["pk"];
      try {
        print("debug TRY");
        var url = "http://swab-in.herokuapp.com/lokasi/add_post";
        var response = await http.post(Uri.parse(url),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'author': authorController.text,
              'lokasi': lokasiController.text,
              'detail': detailController.text,
              'date_posted': DateFormat.yMMMEd().format(DateTime.now()),
              'lokasi_pic': '',
            }));
      } catch (error) {
        print(error);
      }
    }
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
            ]),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              CreateLokasi();
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
