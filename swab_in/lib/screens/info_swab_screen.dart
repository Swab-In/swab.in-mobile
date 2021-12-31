// ignore_for_file: prefer_const_constructors, deprecated_member_use
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:swab_in/models/experience.dart';
import '../models/swab.dart';
import '../widgets/main_drawer.dart';
import '../screens/detail_swab_screen.dart';

class InfoSwabScreen extends StatefulWidget {
  static const routeName = '/informasi-swab';
  const InfoSwabScreen({Key? key}) : super(key: key);

  @override
  _InfoSwabState createState() => _InfoSwabState();
}

class _InfoSwabState extends State<InfoSwabScreen> {
  late Future futurePost;

  @override
  void initState() {
    super.initState();
    futurePost = fetchInfoSwab();
  }

  void selectCategory(BuildContext ctx, int pk) {
    Navigator.of(ctx).pushNamed(
      DetailSwabScreen.routeName,
      arguments: pk,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color.fromRGBO(79, 133, 235, 1),
          title: Text("Informasi Swab")),
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
                      // var price = snapshot.data[index].price ?? " ";
                      // var akurasi = snapshot.data[index].akurasi ?? " ";
                      // var prosedur = snapshot.data[index].prosedur ?? " ";
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
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Row(
                                      children: const <Widget>[
                                        Icon(
                                          Icons.schedule,
                                        ),
                                        SizedBox(
                                          width: 6,
                                        ),
                                        //Text(akurasi),
                                      ],
                                    ),
                                    Row(
                                      children: const <Widget>[
                                        Icon(
                                          Icons.work,
                                        ),
                                        SizedBox(
                                          width: 6,
                                        ),
                                        //Text(snapshot.data[index].prosedur),
                                      ],
                                    ),
                                    Row(
                                      children: const <Widget>[
                                        Icon(
                                          Icons.attach_money,
                                        ),
                                        SizedBox(
                                          width: 6,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 16),
                                          //Text(snapshot.data[index].price.toString()),
                                        )
                                      ],
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

Future<List<Swab>> fetchInfoSwab() async {
  var url = Uri.parse("http://127.0.0.1:8000/swab-vaksin/json-info-swab");
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

  return result;
}
