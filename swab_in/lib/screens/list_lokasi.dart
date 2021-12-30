// ignore_for_file: prefer_const_constructors, deprecated_member_use
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/lokasi.dart';

class LokasiHomePage extends StatefulWidget {
  static const routeName = '/forum';
  const LokasiHomePage({Key? key}) : super(key: key);

  @override
  _LokasiHomePageState createState() => _LokasiHomePageState();
}

class _LokasiHomePageState extends State<LokasiHomePage> {
  late Future futurePost;
 
  @override
  void initState() {
    super.initState();
    futurePost = fetchPost();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color.fromRGBO(79, 133, 235, 1),
          title: Text("Lokasi")),
      body: Card(
        child: 
        FutureBuilder(
            future: futurePost,
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
                              top: 32, bottom: 16, left: 16, right: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                height: 180.0,
                                child: Ink.image(
                                  image: NetworkImage(snapshot.data[index].lokasi_pic),
                                  fit: BoxFit.cover,
                                ),
                              ),
                                Padding(padding: const EdgeInsets.only(top: 8.0),
                                child: Text(snapshot.data[index].lokasi,
                                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                                )),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                        snapshot.data[index].detail,
                                        style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ),
                              ButtonBar(
                                children: [
                                  TextButton(
                                    child: Text('READ MORE',
                                    style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black)),
                                     onPressed: () {
                                      Navigator.pushNamed(context, '/forum', arguments: 
                                        snapshot.data[index].pk,
                                      );
                                      },
                                    ),
                                  ],
                              )
                              ],
                            )
                          )
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

Future<List<Post>> fetchPost() async {
  var url = Uri.parse("http://127.0.0.1:8000/forum/json_lokasi");
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
       Post posts = Post(
          lokasi: d["fields"]["lokasi"],
          detail: d["fields"]["detail"],
          lokasi_pic: d["fields"]["lokasi_pic"],
          pk: d["pk"]);
      result.add(posts);
  }
  return result;
}