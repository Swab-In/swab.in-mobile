// import 'package:flutter/material.dart';
// import 'package:swab_in/models/pesan.dart';
// import 'package:swab_in/widgets/main_drawer.dart';

// class ListPesan extends StatelessWidget {
//   const ListPesan({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const ListPesanScreen(),
//     );
//   }
// }

// // Create a Form widget.
// class ListPesanScreen extends StatefulWidget {
//   static const routeName = '/contact-us';
//   const ListPesanScreen({Key? key}) : super(key: key);

//   @override
//   ListPesanScreenState createState() => ListPesanScreenState();
// }

// class ListPesanScreenState extends State<ListPesanScreen> {
//   late Future<List<Pesan>> futurePesan;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       drawer: MainDrawer(),
//       appBar: AppBar(title: Text("List Pesan")),
//       body: 
//       Container(
//         width: double.infinity,
//         color: const Color.fromRGBO(237, 253, 255, 1),
//         margin: const EdgeInsets.all(15),
//         padding: const EdgeInsets.all(10),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             FutureBuilder<List<Pesan>>(
//               future: futurePesan,
//               builder: (context, snapshot) {
//                 if (snapshot.hasData) {
//                   if (firstfetch) {
//                     for (int i = 0; i < snapshot.data!.length; i++) {
//                       list.add(Container(
//                         child: Column(
//                           crossAxisAlignment:
//                             CrossAxisAlignment.start,
//                           children: <Widget>[
//                             Text(
//                               snapshot.data![i].userId.capitalize(),
//                               style: const TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                             const SizedBox(height: 10),
//                             Text(snapshot.data![i].komentar),
//                           ],
//                         ),
//                         padding:
//                           const EdgeInsets.fromLTRB(0, 10, 0, 10),
//                       ));
//                     }
//                   }
//                   return Column(
//                     children: list,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                   );
//                 } else if (snapshot.hasError) {
//                   return Text('${snapshot.error}');
//                 } else {
//                   return const CircularProgressIndicator();
//                 }
//             // By default, show a loading spinner.
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }