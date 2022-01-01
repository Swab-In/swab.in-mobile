import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:swab_in/models/pesan.dart';

import '../widgets/main_drawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ContactForm extends StatelessWidget {
  const ContactForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const FormScreen(),
    );
  }
}

// Create a Form widget.
class FormScreen extends StatefulWidget {
  static const routeName = '/contact-us';
  const FormScreen({Key? key}) : super(key: key);

  @override
  FormScreenState createState() => FormScreenState();
}

List<Pesan> parsePesan(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Pesan>((json) => Pesan.fromJson(json)).toList();
}

Future<List<Pesan>> fetchPesan() async {
  final response =
      await http.get(Uri.parse('http://swab-in.herokuapp.com/about/get_pesan'));
  if (response.statusCode == 200) {
    return compute(parsePesan, response.body);
  } else {
    throw Exception("Failed to load Pesan");
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class FormScreenState extends State<FormScreen> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<FormScreenState>.
  final _formKey = GlobalKey<FormState>();
  late Future<List<Pesan>> futurePesan;
  TextEditingController namaDepanKontroler = TextEditingController();
  TextEditingController namaBelakangKontroler = TextEditingController();
  TextEditingController emailKontroler = TextEditingController();
  TextEditingController noHPKontroler = TextEditingController();
  TextEditingController pesanKontroler = TextEditingController();

  @override
  void initState() {
    super.initState();
    futurePesan = fetchPesan();
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(title: Text("Contact Us")),
      key: _formKey,
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: namaDepanKontroler,
              decoration: InputDecoration(labelText: 'First Name'),
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            TextFormField(
              controller: namaBelakangKontroler,
              decoration: InputDecoration(labelText: 'Last Name'),
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            TextFormField(
              controller: emailKontroler,
              decoration: InputDecoration(labelText: 'Email'),
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            TextFormField(
              controller: noHPKontroler,
              decoration: InputDecoration(labelText: 'No Handphone'),
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            TextFormField(
              controller: pesanKontroler,
              decoration: InputDecoration(labelText: 'Message'),
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () async => {
                  if (namaDepanKontroler.text.isNotEmpty &&
                      namaBelakangKontroler.text.isNotEmpty &&
                      emailKontroler.text.isNotEmpty &&
                      noHPKontroler.text.isNotEmpty &&
                      pesanKontroler.text.isNotEmpty)
                    {
                      // Validate returns true if the form is valid, or false otherwise.
                      await http.post(
                        Uri.parse('http://localhost:8000/about/pesan-post'),
                        headers: <String, String>{
                          'Content-Type': 'application/json; charset=UTF-8'
                        },
                        body: jsonEncode(<String, dynamic>{
                          'first': namaDepanKontroler.text,
                          'last': namaBelakangKontroler.text,
                          'email': emailKontroler.text,
                          'no_hp': noHPKontroler.text,
                          'message': pesanKontroler.text,
                        }),
                      ),
                      // If the form is valid, display a snackbar. In the real world,
                      // you'd often call a server or save the information in a database.
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Pesan berhasil dikirim')),
                      ),
                      namaDepanKontroler.clear(),
                      namaBelakangKontroler.clear(),
                      emailKontroler.clear(),
                      noHPKontroler.clear(),
                      pesanKontroler.clear(),
                      FutureBuilder<List<Pesan>>(
                          future: futurePesan,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Text(snapshot.data![0].first);
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            } else {
                              return const CircularProgressIndicator();
                            }
                          }),
                      FutureBuilder<List<Pesan>>(
                          future: futurePesan,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Text(snapshot.data![0].last);
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            } else {
                              return const CircularProgressIndicator();
                            }
                          }),
                      FutureBuilder<List<Pesan>>(
                          future: futurePesan,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Text(snapshot.data![0].email);
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            } else {
                              return const CircularProgressIndicator();
                            }
                          }),
                      FutureBuilder<List<Pesan>>(
                          future: futurePesan,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Text(snapshot.data![0].no_hp);
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            } else {
                              return const CircularProgressIndicator();
                            }
                          }),
                      FutureBuilder<List<Pesan>>(
                          future: futurePesan,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Text(snapshot.data![0].message);
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            } else {
                              return const CircularProgressIndicator();
                            }
                          }),
                    }
                },
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
