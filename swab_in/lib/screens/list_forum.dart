// ignore_for_file: prefer_const_constructors, deprecated_member_use, prefer_typing_uninitialized_variables
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swab_in/screens/komentar_screen.dart';
import 'package:swab_in/screens/login_screen.dart';
import 'package:swab_in/widgets/main_drawer.dart';
import '../models/lokasi.dart';
import '../models/forum.dart';

class ListForumHomePage extends StatefulWidget {
  const ListForumHomePage({Key? key, arguments}) : super(key: key);

  @override
  ListForumHomePageState createState() => ListForumHomePageState();
}

class ListForumHomePageState extends State<ListForumHomePage> {
  static const routeName = '/forum';
  var args;
  String? user;

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

  Future<List<Forum>> fetchForum() async {
    args = ModalRoute.of(context)!.settings.arguments;
    String url = "http://127.0.0.1:8000/forum/json_forum";
    try {
      var response = await http.get(
        Uri.parse(url),
        headers: {
          "Access-Control-Allow-Origin": "*",
          "Content-Type": "application/json",
        },
      );
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      List<Forum> result = [];
      for (var d in data) {
        if (d["fields"]["post_id"] == args) {
          Forum forums = Forum(
              writer: d["fields"]["writer"],
              image: d["fields"]["image"],
              title: d["fields"]["title"],
              post_id: d["fields"]["post_id"],
              message: d["fields"]["message"],
              pk: d["pk"]);
          result.add(forums);
          print(forums);
        }
      }
      print(result);
      return result;
    } catch (error) {
      print("B");
      print(error);
      throw Exception("Gagal difetch");
    }
  }

  Future<List<Post>> fetchDetailLokasi() async {
    args = ModalRoute.of(context)!.settings.arguments;
    var url = Uri.parse("https://swab-in.herokuapp.com/forum/json_lokasi");
    try {
      var response = await http.get(
        url,
        headers: {
          "Access-Control-Allow-Origin": "*",
          "Content-Type": "application/json",
        },
      );
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      List<Post> result = [];
      for (var d in data) {
        if (d["pk"] == args) {
          Post posts = Post(
              lokasi: d["fields"]["lokasi"],
              detail: d["fields"]["detail"],
              date_posted:
                  DateFormat('kk:mm:ss \n EEE d MMM').format(DateTime.now()),
              lokasi_pic: d["fields"]["lokasi_pic"],
              pk: d["pk"]);
          result.add(posts);
        }
      }
      return result;
    } catch (error) {
      print(error);
      throw Exception("Gagal difetch");
    }
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
                  future: fetchDetailLokasi(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                                elevation: 2.0,
                                child: Padding(
                                    padding: EdgeInsets.only(
                                        top: 32,
                                        bottom: 16,
                                        left: 16,
                                        right: 16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        SizedBox(
                                          height: 180.0,
                                          child: Ink.image(
                                            image: NetworkImage(snapshot
                                                .data[index].lokasi_pic),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: Text(
                                              snapshot.data[index].lokasi,
                                              style: TextStyle(
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            snapshot.data[index].detail,
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
                        ),
                      );
                    }
                  }),
              Container(
                  margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Forum Diskusi',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                      ))),
              FutureBuilder(
                  future: fetchForum(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                                elevation: 2.0,
                                child: Padding(
                                    padding: EdgeInsets.only(
                                        top: 32,
                                        bottom: 16,
                                        left: 16,
                                        right: 16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        SizedBox(
                                          height: 180.0,
                                          child: Ink.image(
                                            image: NetworkImage(
                                                snapshot.data[index].image),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: Text(
                                              snapshot.data[index].title,
                                              style: TextStyle(
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        Text(
                                          'Ditulis oleh: ' +
                                              snapshot.data[index].writer,
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        Container(
                                          padding:
                                              const EdgeInsets.only(top: 15.0),
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            snapshot.data[index].message,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                          ),
                                        ),
                                        ButtonBar(
                                          children: [
                                            TextButton(
                                              child: Text('READ MORE',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.black)),
                                              onPressed: () {
                                                if (user == null) {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            LoginScreen()),
                                                  );
                                                } else {
                                                  Navigator.pushNamed(context,
                                                      KomentarScreen.routeName,
                                                      arguments:
                                                          KomentarArguments(
                                                              pk: snapshot
                                                                  .data[index]
                                                                  .pk
                                                                  .toString(),
                                                              title: snapshot
                                                                  .data[index]
                                                                  .title));
                                                }
                                              },
                                            ),
                                          ],
                                        )
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
                Navigator.pushNamed(context, '/add-forum', arguments: args);
              })
          : SizedBox(height: 15),
    );
  }
}
