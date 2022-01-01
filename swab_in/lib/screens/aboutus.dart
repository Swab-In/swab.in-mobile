import 'package:flutter/material.dart';
import 'package:swab_in/screens/contactus.dart';
import 'package:swab_in/style-about.dart';
import 'package:swab_in/widgets/aboutwidget.dart';
import '../widgets/main_drawer.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),      
    );
  }
}

class AboutUsPage extends StatefulWidget {
  static const routeName = '/about-us';
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color.fromRGBO(79, 133, 235, 1),
          title: Text("About Us")),
      drawer: MainDrawer(),
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
                  Navigator.of(context)
                      .pushReplacementNamed(FormScreen.routeName);
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
