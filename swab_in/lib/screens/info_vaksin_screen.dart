// ignore_for_file: prefer_const_constructors, deprecated_member_use
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/vaksin.dart';
import '../widgets/main_drawer.dart';
import '../screens/detail_vaksin_screen.dart';

class InfoVaksinScreen extends StatefulWidget {
  static const routeName = '/informasi-vaksin';
  const InfoVaksinScreen({Key? key}) : super(key: key);

  @override
  _InfoVaksinState createState() => _InfoVaksinState();
}

class _InfoVaksinState extends State<InfoVaksinScreen> {
  late Future futurePost;

  @override
  void initState() {
    super.initState();
    futurePost = fetchInfoVaksin();
  }

  void selectCategory(BuildContext ctx, int pk) {
    Navigator.of(ctx).pushNamed(
      DetailVaksinScreen.routeName,
      arguments: pk,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color.fromRGBO(79, 133, 235, 1),
          title: Text("Informasi Vaksin")),
      drawer: MainDrawer(),
      body: Card(
        child: FutureBuilder(
            future: futurePost,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () =>
                            selectCategory(context, snapshot.data[index].pk),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 4,
                          margin: EdgeInsets.all(10),
                          child: Column(
                            children: <Widget>[
                              Stack(
                                children: <Widget>[
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15),
                                    ),
                                    child: Image.network(
                                      'http://c.files.bbci.co.uk/D505/production/_115033545_gettyimages-1226314512.jpg',
                                      height: 250,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 20,
                                    right: 10,
                                    child: Container(
                                      width: 300,
                                      color: Colors.black54,
                                      padding: EdgeInsets.symmetric(
                                        vertical: 5,
                                        horizontal: 20,
                                      ),
                                      child: Text(
                                        snapshot.data[index].nama,
                                        style: TextStyle(
                                          fontSize: 26,
                                          color: Colors.white,
                                        ),
                                        softWrap: true,
                                        overflow: TextOverflow.fade,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.all(20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Row(
                                      children: const <Widget>[
                                        Icon(Icons.schedule_rounded),
                                        SizedBox(
                                          width: 6,
                                        ),
                                      ],
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(right: 10),
                                      padding: EdgeInsets.symmetric(
                                        vertical: 3,
                                        horizontal: 3,
                                      ),
                                      child:
                                          Text(snapshot.data[index].frekuensi),
                                    ),
                                    Row(
                                      children: const <Widget>[
                                        Icon(
                                          Icons.thumb_up,
                                        ),
                                        SizedBox(
                                          width: 6,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 16),
                                        )
                                      ],
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(right: 10),
                                      padding: EdgeInsets.symmetric(
                                        vertical: 3,
                                        horizontal: 3,
                                      ),
                                      child: Text(snapshot.data[index].efikasi),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              } else {
                return Center(
                  child: Text(
                    "Loading...",
                  ),
                );
              }
            }),
      ),
    );
  }
}

Future<List<Vaksin>> fetchInfoVaksin() async {
  var url =
      Uri.parse("http://swab-in.herokuapp.com/swab-vaksin/json-info-vaksin");
  var response = await http.get(
    url,
    headers: {
      "Access-Control-Allow-Origin": "*",
      "Content-Type": "application/json",
    },
  );

  var data = jsonDecode(utf8.decode(response.bodyBytes));
  List<Vaksin> result = [];
  for (var d in data) {
    Vaksin informations = Vaksin(
        nama: d["fields"]["nama"],
        produsen: d["fields"]["produsen"],
        frekuensi: d["fields"]["frekuensi"],
        efikasi: d["fields"]["efikasi"],
        deskripsi: d["fields"]["deskripsi"],
        gambar: d["fields"]["gambar"],
        pk: d["pk"]);
    result.add(informations);
  }

  return result;
}
