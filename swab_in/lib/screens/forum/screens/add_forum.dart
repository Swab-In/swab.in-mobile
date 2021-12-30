// ignore_for_file: prefer_const_constructors, unused_field
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:swab_in/screens/forum/models/forum.dart';

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

  Future<void> createForum() async {
    int no;
    var response = await http.get(
      Uri.parse("http://127.0.0.1:8000/forum/json_lokasi"),
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
          var url = "http://127.0.0.1:8000/forum/add_forum";
          var response = await http.post(Uri.parse(url),
            headers: {'Content-Type': 'application/json'},
              body: jsonEncode({
              'writer': 1, // ini gimana ngambil usernya 
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
  }

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(79, 133, 235, 1),
        title: Text("Tambah Forum"
        ),
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
                      onChanged: (String? value) {
                      setState(() {
                        value!;
                      });
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: TextButton(
                    child: const Text(
                      "Submit",
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.white),
                    ),
                    onPressed: () {
                    if (messageContoller.text == '' ||
                        titleContoller.text == '' ||
                        imageContoller.text == '') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Data tidak lengkap, mohon lengkapi data',
                          ),
                        ),
                      );
                    } else {
                      createForum();
                    }
                    }
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
    // List<Forum> extractedData = [];
    // try {
    //   for (var data in jsonForums) {
    //     Fields field = Fields(
    //       //writer: data["fields"]["writer"],
    //       image: data["fields"]["image"],
    //       title: data["fields"]["title"],
    //       message: data["fields"]["message"],
    //       post_id: data["fields"]["post_id"]);

    //     Forum forums =
    //       Forum(model: data["model"], pk: data["pk"], fields: field, );
        
    //   extractedData.add(forums);
    //   }
   

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         backgroundColor: Theme.of(context).primaryColor,
// //         title: Text("Tambah Forum",
// //         style: Theme.of(context).textTheme.headline1,
// //         ),
// //       ),
// //       body: Form(
// //         key: _formKey,
// //         child: SingleChildScrollView(
// //           child: Container(
// //             padding: const EdgeInsets.all(25.0),
// //             child: Column(
// //               children: [
// //                 Padding(
// //                   padding: const EdgeInsets.all(8.0),
// //                   child: TextFormField(
// //                     controller: titleController,
// //                     decoration: InputDecoration(
// //                       labelText: "Judul",
// //                       icon: const Icon(Icons.title),
// //                       border: OutlineInputBorder(
// //                           borderRadius: BorderRadius.circular(5.0)),
// //                     ),
// //                     validator: (value) {
// //                       if (value!.isEmpty) {
// //                         return 'Judul forum tidak boleh kosong';
// //                       }
// //                       return null;
// //                     },
// //                   ),
// //                 ),
// //                 Padding(
// //                   padding: const EdgeInsets.all(8.0),
// //                   child: TextFormField(
// //                     decoration: InputDecoration(
// //                       hintText: "Tuliskan diskusi disini",
// //                       icon: const Icon(Icons.forum),
// //                       border: OutlineInputBorder(
// //                           borderRadius: BorderRadius.circular(5.0)),
// //                     ),
// //                     minLines: 5,
// //                     maxLines: 8,
// //                     validator: (value) {
// //                       if (value!.isEmpty) {
// //                         return 'Isi forum tidak boleh kosong';
// //                       }
// //                       return null;
// //                     },
// //                   ),
// //                 ),
// //                 Padding(
// //                   padding: const EdgeInsets.all(8.0),
// //                   child: TextFormField(
// //                     decoration: InputDecoration(
// //                       labelText: "URL thumbnail",
// //                       icon: const Icon(Icons.image),
// //                       border: OutlineInputBorder(
// //                           borderRadius: BorderRadius.circular(5.0)),
// //                     ),
// //                   ),
// //                 ),
// //                 TextButton(
// //                   child: const Text(
// //                     "Submit",
// //                     style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)
// //                   ),
// //                    style: ButtonStyle(
// //                     backgroundColor: MaterialStateProperty.all(Colors.white),
// //                   ),
// //                   onPressed: () {
// //                     if (_formKey.currentState!.validate()) {
// //                       showDialog(
// //                       context: context,
// //                       builder: (context) {
// //                         return AlertDialog(
// //                           // Retrieve the text the that user has entered by using the
// //                           // TextEditingController.
// //                           content: Text("Forum ${titleController.text} berhasil ditambahkan"),
// //                         );
// //                       },
// //                       );
// //                     }
// //                   },
// //                 ),
// //               ],
// //             ),
// //           ),
// // //         ),
// //       ),
// //     );
//   }
// }