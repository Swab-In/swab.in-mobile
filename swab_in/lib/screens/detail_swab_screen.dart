// ignore_for_file: prefer_const_constructors, deprecated_member_use, prefer_typing_uninitialized_variables
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/swab.dart';
import '../models/swab_experience.dart';

class DetailSwabScreen extends StatefulWidget {
  static const routeName = '/detail-swab';

  const DetailSwabScreen({Key? key, arguments}) : super(key: key);

  @override
  DetailSwabState createState() => DetailSwabState();
}

class DetailSwabState extends State<DetailSwabScreen> {
  String? user;
  var args;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  void _loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      user = prefs.getString('userName');
    });
  }

  Future<List<SwabExperience>> fetchExperience() async {
    args = ModalRoute.of(context)!.settings.arguments;
    String url = "http://swab-in.herokuapp.com/swab-vaksin/json-swab";
    try {
      var response = await http.get(
        Uri.parse(url),
        headers: {
          "Access-Control-Allow-Origin": "*",
          "Content-Type": "application/json",
        },
      );
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      List<SwabExperience> result = [];
      for (var d in data) {
        if (d["fields"]["swab_id"] == args) {
          SwabExperience experiences = SwabExperience(
              penulis: d["fields"]["penulis"],
              pengalamanSwab: d["fields"]["pengalamanSwab"],
              swabId: d["fields"]["swab_id"],
              pk: d["pk"]);
          result.add(experiences);
        }
      }
      print(result);
      return result;
    } catch (error) {
      throw Exception("Fetch Failed");
    }
  }

  Future<List<Swab>> fetchInfoSwab() async {
    args = ModalRoute.of(context)!.settings.arguments;
    var url =
        Uri.parse("http://swab-in.herokuapp.com/swab-vaksin/json-info-swab");
    try {
      var response = await http.get(
        url,
        headers: {
          "Access-Control-Allow-Origin": "*",
          "Content-Type": "application/json",
        },
      );
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      List<Swab> result = [];
      for (var d in data) {
        if (d["pk"] == args) {
          Swab informations = Swab(
              nama: d["fields"]["nama"],
              price: d["fields"]["price"],
              akurasi: d["fields"]["akurasi"],
              prosedur: d["fields"]["prosedur"],
              deskripsi: d["fields"]["deskripsi"],
              gambar: d["fields"]["gambar"],
              pk: d["pk"]);
          result.add(informations);
        }
      }
      return result;
    } catch (error) {
      throw Exception("Gagal difetch");
    }
  }

  Widget buildSectionTitle(BuildContext context, String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  Widget buildContainer(Widget child) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      height: 150,
      width: 300,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color.fromRGBO(79, 133, 235, 1),
          title: Text("Forum")),
      body: Container(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              FutureBuilder(
                  future: fetchInfoSwab(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                                elevation: 2.0,
                                margin: EdgeInsets.all(10),
                                child: Padding(
                                    padding: EdgeInsets.all(16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: Text(
                                              snapshot.data[index].nama,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        Container(
                                          alignment: Alignment.topRight,
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8.0),
                                                  child: Text(
                                                    'Harga: ${snapshot.data[index].price}',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8.0),
                                                  child: Text(
                                                    'Akurasi: ${snapshot.data[index].akurasi}',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8.0),
                                                  child: Text(
                                                    'Prosedur: ${snapshot.data[index].prosedur}',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8.0),
                                                  child: Text(
                                                    snapshot
                                                        .data[index].deskripsi,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1,
                                                  ),
                                                ),
                                              ]),
                                        ),
                                      ],
                                    )));
                          });
                    } else {
                      return Center(
                        child: Text(
                          "Loading...",
                        ),
                      );
                    }
                  }),
              Container(
                  margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Pengalaman',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                      ))),
              FutureBuilder(
                  future: fetchExperience(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                                margin: EdgeInsets.all(10),
                                elevation: 2.0,
                                child: Padding(
                                    padding: EdgeInsets.all(20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            snapshot.data[index].pengalamanSwab,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.bottomRight,
                                          child: Text(
                                            snapshot.data[index].penulis,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                          ),
                                        ),
                                      ],
                                    )));
                          });
                    } else {
                      return Center(
                        child: Text(
                          "Loading...",
                          style: TextStyle(fontSize: 18),
                        ),
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
      floatingActionButton: user != null
          ? FloatingActionButton(
              backgroundColor: Color.fromRGBO(79, 133, 235, 1),
              child: Icon(
                Icons.add,
                size: 30,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/add-experience-swab',
                    arguments: args);
              })
          : SizedBox(height: 15),
    );
  }
}
