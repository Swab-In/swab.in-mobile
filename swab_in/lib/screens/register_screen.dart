import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swab_in/screens/login_screen.dart';
import 'package:http/http.dart' as http;
import 'package:swab_in/screens/main_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
  // TODO: implement createState

}

class _RegisterScreenState extends State<RegisterScreen> {
  final firstnameController = TextEditingController();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final pekerjaanController = TextEditingController();
  final umurController = TextEditingController();
  final userpicController = TextEditingController();
  final password1Controller = TextEditingController();
  final password2Controller = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    usernameController.dispose();
    password1Controller.dispose();
    password2Controller.dispose();
    super.dispose();
  }

  Widget buildName() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Nama',
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
                controller: firstnameController,
                keyboardType: TextInputType.name,
                style: TextStyle(color: Colors.black87),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(top: 14),
                    prefixIcon: Icon(Icons.people, color: Color(0xff00acfa)),
                    hintText: 'Nama',
                    hintStyle: TextStyle(color: Colors.black38)),
              ))
        ]);
  }

  Widget buildEmail() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Email',
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
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(color: Colors.black87),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(top: 14),
                    prefixIcon: Icon(Icons.email, color: Color(0xff00acfa)),
                    hintText: 'Email',
                    hintStyle: TextStyle(color: Colors.black38)),
              ))
        ]);
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

  Widget buildPekerjaan() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Pekerjaan',
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
                controller: pekerjaanController,
                keyboardType: TextInputType.name,
                style: TextStyle(color: Colors.black87),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(top: 14),
                    prefixIcon: Icon(Icons.people, color: Color(0xff00acfa)),
                    hintText: 'Pekerjaan',
                    hintStyle: TextStyle(color: Colors.black38)),
              ))
        ]);
  }

  Widget buildUmur() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Umur',
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
                controller: umurController,
                keyboardType: TextInputType.name,
                style: TextStyle(color: Colors.black87),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(top: 14),
                    prefixIcon:
                        Icon(Icons.people_sharp, color: Color(0xff00acfa)),
                    hintText: 'Umur',
                    hintStyle: TextStyle(color: Colors.black38)),
              ))
        ]);
  }

  Widget buildUserPic() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('User Pic',
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
                controller: userpicController,
                keyboardType: TextInputType.name,
                style: TextStyle(color: Colors.black87),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(top: 14),
                    prefixIcon:
                        Icon(Icons.people_sharp, color: Color(0xff00acfa)),
                    hintText: 'User Pic',
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
                controller: password1Controller,
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

  Widget buildRePassword() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Re Password',
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
                controller: password2Controller,
                obscureText: true,
                style: TextStyle(color: Colors.black87),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(top: 14),
                    prefixIcon: Icon(Icons.password, color: Color(0xff00acfa)),
                    hintText: 'Re Password',
                    hintStyle: TextStyle(color: Colors.black38)),
              ))
        ]);
  }

  Widget buildRegisterBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5,
        onPressed: () async {
          final response =
              // print(usernameController);
              // print(usernameController);
              await http.post(Uri.parse("http://10.0.2.2:8000/register/"),
                  headers: <String, String>{
                    'Content-Type': 'application/json;charset=UTF-8',
                  },
                  body: jsonEncode(<String, dynamic>{
                    'first_name': firstnameController.text,
                    'username': usernameController.text,
                    'email': emailController.text,
                    'pekerjaan': pekerjaanController.text,
                    'umur': umurController.text,
                    'userpic': userpicController.text,
                    'password1': password1Controller.text,
                    'password2': password2Controller.text,
                  }));
          // ignore: avoid_print
          var res = jsonDecode(response.body);
          if (res['success']) {
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
                  content: const Text('Registrasi Gagal!')),
            );
          }
        },
        padding: EdgeInsets.all(15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Colors.white,
        child: Text(
          'REGISTER',
          style: TextStyle(
              color: Color(0xff00acfa),
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget buildLoginBtn() {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
        },
        child: RichText(
            text: TextSpan(children: [
          TextSpan(
              text: 'Sudah punya akun? ',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500)),
          TextSpan(
              text: 'Login',
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
                        buildName(),
                        buildUname(),
                        buildEmail(),
                        buildPekerjaan(),
                        buildUmur(),
                        buildUserPic(),
                        SizedBox(height: 20),
                        buildPassword(),
                        buildRePassword(),
                        SizedBox(height: 5),
                        buildRegisterBtn(),
                        buildLoginBtn(),
                      ]),
                ))
          ]))),
    );
  }
}
