// ignore_for_file: prefer_const_constructors, unused_field
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swab_in/screens/list_forum.dart';
import 'package:swab_in/screens/lokasi_screen.dart';
import '../models/forum.dart';

class AddForum extends StatefulWidget {
  const AddForum({Key? key}) : super(key: key);

  @override
  AddForumState createState() => AddForumState();
}

class AddForumState extends State<AddForum> {
  final _formKey = GlobalKey<FormState>();
  late Forum _forum;
  var args;
  static const routeName = '/add-forum';

  TextEditingController titleContoller = TextEditingController();
  TextEditingController messageContoller = TextEditingController();
  TextEditingController imageContoller = TextEditingController();
  String? user;
  int? userId;

  void _loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      user = prefs.getString('userName');
      userId = prefs.getInt('user_id');
    });
  }

  Future<void> createForum() async {
    int no;
    var response = await http.get(
      Uri.parse("https://swab-in.herokuapp.com/forum/json_lokasi"),
      headers: {
        "Access-Control-Allow-Origin": "*",
        "Content-Type": "application/json",
      },
    );
    var data = jsonDecode(utf8.decode(response.bodyBytes));
    for (var d in data) {
      if (d["pk"] == args) {
        no = d["pk"];
        print(d["pk"]);
        try {
          var url = "http://127.0.0.1:8000/forum/add_forum";
          var response = await http.post(Uri.parse(url),
              headers: {'Content-Type': 'application/json'},
              body: jsonEncode({
                'writer': userId,
                'title': titleContoller.text,
                'message': messageContoller.text,
                'image': imageContoller.text,
                'post_id': no,
              }));
        } catch (error) {
          print(error);
        }
      }
    }

    Navigator.of(context).pop(ListForumHomePageState.routeName);
    Navigator.of(context).pop(LokasiHomePage.routeName);
    Navigator.of(context).pushNamed(
      ListForumHomePageState.routeName,
      arguments: args,
    );
  }

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(79, 133, 235, 1),
        title: Text("Tambah Forum"),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: titleContoller,
                    decoration: InputDecoration(
                      icon: const Icon(Icons.title),
                      hintText: 'Tuliskan judul disini',
                      labelText: 'Judul',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                    ),
                    validator: (String? value) {
                      return (value == null || value.isEmpty)
                          ? 'Judul tidak boleh kosong.'
                          : null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: messageContoller,
                    decoration: InputDecoration(
                      hintText: "Tuliskan diskusi disini",
                      icon: const Icon(Icons.forum),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                    ),
                    minLines: 5,
                    maxLines: 8,
                    validator: (String? value) {
                      return (value == null || value.isEmpty)
                          ? 'Isi forum tidak boleh kosong.'
                          : null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: imageContoller,
                    decoration: InputDecoration(
                      labelText: "URL thumbnail",
                      icon: const Icon(Icons.image),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                    ),
                    validator: (String? value) {
                      return (value == null || value.isEmpty)
                          ? 'URL thumbnail tidak boleh kosong.'
                          : null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: TextButton(
                      child: const Text(
                        "Submit",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                      ),
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? true) {
                          createForum();
                          _loadUser();
                        }
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
