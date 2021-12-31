import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';

class MainScreen extends StatelessWidget {
  static const routeName = '/home';

  MainScreen();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Swab.In'),
      ),
      drawer: MainDrawer(),
      body: SingleChildScrollView(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "SELAMAT DATANG DI SWAB.IN!",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Montserrat-Regular",
                    color: Color(0xFF111111)),
              ),
              RichText(
                text: TextSpan(
                  text: "Tempat Informasi Swab dan Vaksin Kesayanganmu",
                  style: TextStyle(fontSize: 15, color: Color(0xFF8591B0),
                ),
                ),
              ),  
              SizedBox(
                height: 32,
              ),
              Center(
                child: Image.network("assets/logo.png", scale: 0.75),
              ),
              SizedBox(
                height: 30,
              )
            ],
          ),
        ))
      )
    );
  }
}