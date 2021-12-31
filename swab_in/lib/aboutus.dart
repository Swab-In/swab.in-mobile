import 'dart:io';

import 'package:flutter/material.dart';
import 'package:swab_in/contactus.dart';
import 'package:swab_in/style.dart';
import 'package:swab_in/widgets.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AboutUsPage(),
    );
  }
}

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 32.0, top: 8.0),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(text: "Swab.in", style: AppTheme.display1),
                      TextSpan(text: "\n"),
                      TextSpan(text: "About Us", style: AppTheme.display2),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: DetailWidget(),
              ),
              Text("Ada yang ingin disampaikan?"),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => FormScreen()));
                },
                child: new Text("Contact Us"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
