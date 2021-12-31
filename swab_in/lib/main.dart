import 'package:flutter/material.dart';
import 'package:swab_in/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Swab.In',
      theme: ThemeData.dark(),
      home: const LokasiHomePage(),
    );
  }
}
