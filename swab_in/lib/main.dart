// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:swab_in/screens/artikel_list.dart';
import 'package:swab_in/screens/detail_swab_screen.dart';
import 'package:swab_in/screens/aboutus.dart';
import 'package:swab_in/screens/contactus.dart';
import 'package:swab_in/screens/detail_swab_screen.dart';
import 'package:swab_in/screens/login_screen.dart';

import './screens/komentar_screen.dart';
import './screens/login_screen.dart';
import './screens/main_screen.dart';
import './screens/detail_swab_screen.dart';
import './screens/detail_vaksin_screen.dart';
import './screens/info_swab_screen.dart';
import './screens/add_experience_swab_screen.dart';
import './screens/info_vaksin_screen.dart';
import './screens/add_experience_vaksin_screen.dart';
import 'screens/artikel_detail.dart';

import 'package:swab_in/screens/add_forum.dart';
import 'package:swab_in/screens/list_forum.dart';
import 'screens/lokasi_screen.dart';

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
        ArtikelScreen.routeName: (context) => const ArtikelScreen(),
        InfoVaksinScreen.routeName: (context) => const InfoVaksinScreen(),
        DetailSwabScreen.routeName: (context) => const DetailSwabScreen(),
        AboutUsPage.routeName: (context) => const AboutUsPage(),
        FormScreen.routeName: (context) => const FormScreen(),
        DetailVaksinScreen.routeName: (context) => const DetailVaksinScreen(),
        AddExperienceSwabScreen.routeName: (context) =>
            const AddExperienceSwabScreen(),
        AddExperienceVaksinScreen.routeName: (context) =>
            const AddExperienceVaksinScreen(),
        LoginScreen.routeName: (context) => const LoginScreen(),
        ArtikelDetailScreen.routeName: (context) =>
            const ArtikelDetailScreen(pk: 'pk', title: 'title'),
        ListForumHomePageState.routeName: (context) =>
            const ListForumHomePage(),
        AddForumState.routeName: (context) => const AddForum(),
        LokasiHomePage.routeName: (context) => const LokasiHomePage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == KomentarScreen.routeName) {
          final args = settings.arguments as KomentarArguments;

          return MaterialPageRoute(
            builder: (context) {
              return KomentarScreen(title: args.title, pk: args.pk);
            },
          );
        }
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (ctx) => MainScreen(),
        );
      },
    );
  }
}
