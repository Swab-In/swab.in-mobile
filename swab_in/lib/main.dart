// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:swab_in/screens/add_forum.dart';
import 'package:swab_in/screens/list_forum.dart';
import 'screens/list_lokasi.dart';
import 'package:swab_in/screens/detail_swab_screen.dart';
import '../widgets/main_drawer.dart';
import './screens/main_screen.dart';
import './screens/info_swab_screen.dart';
import './screens/add_experience_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Swab.In',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/', // default is '/'
      routes: {
        '/': (ctx) => MainScreen(),
        InfoSwabScreen.routeName: (context) => const InfoSwabScreen(),
        DetailSwabScreen.routeName: (context) => const DetailSwabScreen(),  
        AddExperienceScreen.routeName: (context) => const AddExperienceScreen(),      
        ListForumHomePageState.routeName: (context) => ListForumHomePage(),
        AddForumState.routeName: (context) => AddForum(),       
        LokasiHomePage.routeName: (context) => LokasiHomePage(),   
      },
      onGenerateRoute: (settings) {
        print(settings.arguments);
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (ctx) => MainScreen(),
        );
      },
    );
  }
}
