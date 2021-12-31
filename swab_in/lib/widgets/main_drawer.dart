import 'package:flutter/material.dart';
import 'package:swab_in/screens/aboutus.dart';
import 'package:swab_in/screens/main_screen.dart';

import '../screens/info_swab_screen.dart';

class MainDrawer extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: 120,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: Theme.of(context).accentColor,
            child: Text(
              'Swab.In',
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 30,
                  color: Theme.of(context).primaryColor),
            ),
          ),
          SizedBox(
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
            Navigator.of(context).pushReplacementNamed(AboutUsPage.routeName);
          }),
          buildListTile('Lokasi', Icons.place, () {
            Navigator.of(context).pushReplacementNamed('/');
          }),
          buildListTile('Artikel', Icons.article, () {
            Navigator.of(context).pushReplacementNamed('/');
          }),
        ],
      ),
    );
  }
}
