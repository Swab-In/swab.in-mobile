import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swab_in/screens/komentar_screen.dart';
import 'package:swab_in/screens/login_screen.dart';
import 'package:swab_in/screens/main_screen.dart';
import "../screens/string_extension.dart";

import '../screens/info_swab_screen.dart';

class MainDrawer extends StatefulWidget {
  static const routeName = '/home';

  MainDrawer();

  @override
  State<MainDrawer> createState() => MainDrawerState();
}

class MainDrawerState extends State<MainDrawer> {
  String? user = '';
  Widget buildListTile(String title, IconData icon, VoidCallback handler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'RobotoCondensed',
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: handler,
    );
  }

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

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: 120,
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: const Color.fromRGBO(79, 133, 235, 1),
            child: const Text(
              'Swab.In',
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 30,
                  color: Colors.white),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          buildListTile('Home', Icons.home, () {
            Navigator.of(context).pushReplacementNamed(MainScreen.routeName);
          }),
          buildListTile('Informasi', Icons.menu_book, () {
            Navigator.of(context)
                .pushReplacementNamed(InfoSwabScreen.routeName);
          }),
          buildListTile('Tentang', Icons.info, () {
            Navigator.of(context).pushReplacementNamed('/');
          }),
          buildListTile('Lokasi', Icons.place, () {
            Navigator.of(context).pushReplacementNamed('/');
          }),
          buildListTile('Artikel', Icons.article, () {
            Navigator.of(context).pushReplacementNamed('/');
          }),
          buildListTile('Komentar', Icons.comment, () {
            Navigator.of(context)
                .pushReplacementNamed(KomentarScreen.routeName);
          }),
          user == ''
              ? buildListTile('Login', Icons.login, () {
                  Navigator.of(context)
                      .pushReplacementNamed(LoginScreen.routeName);
                })
              : ElevatedButton(
                  onPressed: () async {}, child: const Text('Logout'))
        ],
      ),
    );
  }
}
