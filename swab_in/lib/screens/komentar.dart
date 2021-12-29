import 'package:flutter/material.dart';

class KomentarState extends StatefulWidget {
  const KomentarState({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<KomentarState> createState() => KomentarScreen();
}

class KomentarScreen extends State<KomentarState> {

  final _formKey = GlobalKey<FormState>();

  TextEditingController komentarController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            padding: EdgeInsets.only(top: 10),
            child: ListView(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset('assets/images/folklore.jpg'),
                ),
                Container(
                  margin: EdgeInsets.only(top: 25, bottom: 5),
                  child: Text("Review Swab",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w700)),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text("Ditulis oleh: ejet",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600)),
                      SizedBox(height: 10),
                      const Text(
                          "Awalnya waktu saya mau memilih tempat swab, saya pilih tes swab di Yos Sudarso karena dekat dari rumah. Ternyata pelayanannya bagus dan hasil swabnya juga cepat keluar"),
                    ],
                  ),
                ),
                Form(
                    key: _formKey,
                    child: Container(
                        child: Column(
                      children: [
                        TextFormField(
                            controller: komentarController,
                            decoration: new InputDecoration(
                                hintText: "Masukkan komentar anda")),
                        Container(
                            alignment: Alignment.bottomRight,
                            margin: EdgeInsets.only(top: 10, bottom: 10),
                            child: ElevatedButton(
                                onPressed: () {
                                  print(komentarController.text);

                                },
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(5, 7, 5, 7),
                                  child: const Text(
                                    "Reply",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ))),
                      ],
                    ))),
                const Text(
                  "Replies :",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Container(
                  width: double.infinity,
                  color: Color.fromRGBO(237, 253, 255, 1),
                  margin: EdgeInsets.all(15),
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Swabdev",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500)),
                            Text("Bener banget"),
                          ]),
                      SizedBox(height: 15),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Swabdev",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500)),
                            Text("Bener banget 2"),
                          ]),
                      SizedBox(height: 15),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Swabdev",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500)),
                            Text("Bener banget 3"),
                          ]),
                    ],
                  ),
                ),
              ],
            )));
  }
}
