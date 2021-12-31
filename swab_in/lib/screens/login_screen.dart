import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swab_in/screens/main_screen.dart';
import 'package:swab_in/screens/register_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  static const routeName = '/login';
  const LoginScreen({Key? key}) : super(key: key);
  _LoginScreenState createState() => _LoginScreenState();
  // TODO: implement createState

}

class _LoginScreenState extends State<LoginScreen> {
  bool isRememberMe = false;

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Widget buildUname() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Username',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Container(
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26,
                        blurRadius: 6,
                        offset: Offset(0, 2))
                  ]),
              height: 60,
              child: TextField(
                controller: usernameController,
                keyboardType: TextInputType.name,
                style: TextStyle(color: Colors.black87),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(top: 14),
                    prefixIcon: Icon(Icons.people_alt_rounded,
                        color: Color(0xff00acfa)),
                    hintText: 'Username',
                    hintStyle: TextStyle(color: Colors.black38)),
              ))
        ]);
  }

  Widget buildPassword() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Password',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Container(
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26,
                        blurRadius: 6,
                        offset: Offset(0, 2))
                  ]),
              height: 60,
              child: TextField(
                controller: passwordController,
                obscureText: true,
                style: TextStyle(color: Colors.black87),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(top: 14),
                    prefixIcon: Icon(Icons.password, color: Color(0xff00acfa)),
                    hintText: 'Password',
                    hintStyle: TextStyle(color: Colors.black38)),
              ))
        ]);
  }

  Widget buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5,
        onPressed: () async {
          final response =
              await http.post(Uri.parse("http://10.0.2.2:8000/login/"),
                  headers: <String, String>{
                    'Content-Type': 'application/json;charset=UTF-8',
                  },
                  body: jsonEncode(<String, dynamic>{
                    'username': usernameController.text,
                    'password': passwordController.text,
                  }));
          var res = jsonDecode(response.body);
          if (res['success']) {
            final prefs = await SharedPreferences.getInstance();

            prefs.setString("userName", usernameController.text);
            prefs.setInt("user_id", res['user_id']);

            (Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MainScreen()),
            ));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  backgroundColor: Colors.red,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24)),
                  content: const Text('Login Gagal!')),
            );
          }
        },
        padding: EdgeInsets.all(15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Colors.white,
        child: Text(
          'LOGIN',
          style: TextStyle(
              color: Color(0xff00acfa),
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget buildRemember() {
    return Container(
      height: 20,
      child: Row(children: <Widget>[
        Theme(
          data: ThemeData(unselectedWidgetColor: Colors.white),
          child: Checkbox(
            value: isRememberMe,
            checkColor: Colors.green,
            activeColor: Colors.white,
            onChanged: (value) {
              setState(() {
                isRememberMe = value!;
              });
            },
          ),
        ),
        Text(
          'Remember Me',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        )
      ]),
    );
  }

  Widget buildSignUpBtn() {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RegisterScreen()),
          );
        },
        child: RichText(
            text: TextSpan(children: [
          TextSpan(
              text: 'Belum punya akun? ',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500)),
          TextSpan(
              text: 'Register',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold))
        ])));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: GestureDetector(
              child: Stack(children: <Widget>[
            Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                      Color(0xff00acfa),
                      Color(0xff00acfa),
                      Color(0xff00acfa),
                      Color(0xff00acfa),
                    ])),
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 120,
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Swab.In',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 50),
                        buildUname(),
                        SizedBox(height: 20),
                        buildPassword(),
                        SizedBox(height: 25),
                        buildRemember(),
                        SizedBox(height: 5),
                        buildLoginBtn(),
                        buildSignUpBtn(),
                      ]),
                ))
          ]))),
    );
  }
}
