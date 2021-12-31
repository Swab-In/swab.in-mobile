import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../models/swab.dart';
import '../models/experience.dart';
import '../screens/info_swab_screen.dart';
import '../screens/detail_swab_screen.dart';

class AddExperienceScreen extends StatefulWidget {
  static const routeName = '/add-experience';
  const AddExperienceScreen({Key? key}) : super(key: key);

  @override
  AddForumState createState() => AddForumState();
}

class AddForumState extends State<AddExperienceScreen> {
  final _formKey = GlobalKey<FormState>();
  late Experience _experience;
  var args;

  TextEditingController experieneContoller = TextEditingController();

  Future<void> createExperience(BuildContext context) async {
    int no = 1;
    var response = await http.get(
      Uri.parse("http://127.0.0.1:8000/swab-vaksin/json-info-swab"),
      headers: {
        "Access-Control-Allow-Origin": "*",
        "Content-Type": "application/json",
      },
    );
    var data = jsonDecode(utf8.decode(response.bodyBytes));
    for (var d in data) {
      if (d["pk"] == args) {
        no = d["pk"];
        try {
          print(experieneContoller.text);
          var url = "http://127.0.0.1:8000/swab-vaksin/add-experience";
          var response = await http.post(Uri.parse(url),
              headers: {
                'Content-Type': 'application/json',
                'Access-Control-Allow-Origin': '*',
              },
              body: jsonEncode({
                'penulis': "fitri",
                'pengalamanSwab': experieneContoller.text,
                'swab_id': no,
              }));
        } catch (error) {
          print(error);
        }
      }
    }

    Navigator.of(context).pop(
      DetailSwabScreen.routeName    
    );
    Navigator.of(context).pop(
      InfoSwabScreen.routeName    
    );
    Navigator.of(context).pushNamed(
      DetailSwabScreen.routeName,
      arguments: no,
    );
  }

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(79, 133, 235, 1),
        title: Text("Tambah Experience"),
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
                    controller: experieneContoller,
                    decoration: InputDecoration(
                      hintText: "Tuliskan pengalaman anda disini",
                      icon: const Icon(Icons.chat_bubble),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                    ),
                    minLines: 5,
                    maxLines: 8,
                    validator: (String? value) {
                      return (value == null || value.isEmpty)
                          ? 'Pengalaman tidak boleh kosong.'
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
                        if (experieneContoller.text == '') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Pengalaman Anda belum diisi',
                              ),
                            ),
                          );
                        } else {
                          print("valid");
                          createExperience(context);
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
