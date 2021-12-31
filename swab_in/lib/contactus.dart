import 'package:flutter/material.dart';

class FormScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FormScreenState();
  }
}

class FormScreenState extends State<FormScreen> {
  String? _name;
  String? _email;
  String? _phoneNumber;
  String? _message;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildName() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Nama'),
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Mohon masukkan nama';
        }
      },
      onSaved: (String? value) {
        _name = value;
      },
    );
  }

  Widget _buildEmail() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Email'),
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Mohon masukkan email';
        }
      },
      onSaved: (String? value) {
        _email = value;
      },
    );
  }

  Widget _buildPhoneNumber() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'No Handphone'),
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Mohon masukkan nomor hp';
        }
      },
      onSaved: (String? value) {
        _phoneNumber = value;
      },
    );
  }

  Widget _buildMessage() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Message'),
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Mohon masukkan pesan';
        }
      },
      onSaved: (String? value) {
        _message = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Contact Us")),
        body: Container(
            margin: EdgeInsets.all(24),
            child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _buildName(),
                    _buildEmail(),
                    _buildPhoneNumber(),
                    _buildMessage(),
                    SizedBox(height: 100),
                    ElevatedButton(
                        onPressed: () => {},
                        child: Text('Submit',
                            style:
                                TextStyle(color: Colors.white, fontSize: 16)))
                  ],
                ))));
  }
}
