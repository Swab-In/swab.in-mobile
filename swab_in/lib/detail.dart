import 'package:flutter/material.dart';
import 'package:swab_in/aboutus.dart';
import 'package:swab_in/deskripsi.dart';
import 'package:swab_in/style.dart';

class DetailScreen extends StatefulWidget {
  final About isi;

  const DetailScreen({Key? key, required this.isi}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Hero(
            tag: "background-${isicard[0].name}",
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: widget.isi.colors,
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 16),
                  child: IconButton(
                    iconSize: 40,
                    icon: Icon(Icons.close),
                    color: Colors.white.withOpacity(0.9),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Hero(
                      tag: "image-{$isicard[0].name}",
                      child: Image.asset(widget.isi.image,
                          height: screenHeight * 0.45)),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32.0, vertical: 8),
                  child: Hero(
                      tag: "name-${isicard[0].name}",
                      child: Material(
                          color: Colors.transparent,
                          child:
                              Text(widget.isi.name, style: AppTheme.heading))),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(32, 0, 8, 32),
                  child:
                      Text(widget.isi.description, style: AppTheme.subHeading),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
