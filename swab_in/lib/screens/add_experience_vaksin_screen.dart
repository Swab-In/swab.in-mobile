import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/vaksin_experience.dart';
import '../screens/info_vaksin_screen.dart';
import '../screens/detail_vaksin_screen.dart';

class AddExperienceVaksinScreen extends StatefulWidget {
  static const routeName = '/add-experience-vaksin';
  const AddExperienceVaksinScreen({Key? key}) : super(key: key);

  @override
  AddExperienceVaksinState createState() => AddExperienceVaksinState();
}

class AddExperienceVaksinState extends State<AddExperienceVaksinScreen> {
  final _formKey = GlobalKey<FormState>();
  late VaksinExperience _experience;
  var args;
  String? user;

  TextEditingController experieneContoller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  void _loadUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      user = prefs.getString('userName');
    });
  }

  Future<void> createVaksinExperience(BuildContext context) async {
    int no = 1;
    var response = await http.get(
      Uri.parse("http://10.0.2.2:8000/swab-vaksin/json-info-vaksin"),
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
          print(user);
          var url = "http://10.0.2.2:8000/swab-vaksin/add-experience-vaksin";
          var response = await http.post(Uri.parse(url),
              headers: {
                'Content-Type': 'application/json',
                'Access-Control-Allow-Origin': '*',
              },
              body: jsonEncode({
                'penulis': user,
                'pengalamanVaksin': experieneContoller.text,
                'vaksin_id': no,
              }));
        } catch (error) {
          print(error);
        }
      }
    }

    Navigator.of(context).pop(DetailVaksinScreen.routeName);
    Navigator.of(context).pop(InfoVaksinScreen.routeName);
    Navigator.of(context).pushNamed(
      DetailVaksinScreen.routeName,
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
                          createVaksinExperience(context);
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
