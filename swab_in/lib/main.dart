// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:swab_in/screens/forum/screens/add_forum.dart';
import 'package:swab_in/screens/forum/screens/list_forum.dart';
import 'screens/forum/screens/list_lokasi.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Swab.In',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //  home: const MyHomePage(title: 'Swab.In'),
      home: const LokasiHomePage(),
      routes: {
        ListForumHomePageState.routeName: (context) => ListForumHomePage(),
        AddForumState.routeName: (context) => AddForum(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Kelompok B10',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
                },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
