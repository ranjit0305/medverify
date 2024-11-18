import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ManufacturerSignUpPage extends StatefulWidget {
  @override
  _ManufacturerSignUpPageState createState() => _ManufacturerSignUpPageState();
}

class _ManufacturerSignUpPageState extends State<ManufacturerSignUpPage> {
  final _formKey = GlobalKey<FormState>();
  String companyName = '';
  String manufacturerName = '';
  String username = '';
  String password = '';

  // Function to handle sign-up
  Future<void> signUp() async {
    var response = await http.post(
      Uri.parse('http://<your-backend-url>/signup'), // Replace with your backend URL
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'companyName': companyName,
        'manufacturerName': manufacturerName,
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sign-Up Successful!')),
      );
      Navigator.pop(context); // Navigate back to login
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sign-Up Failed. Try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Manufacturer Sign-Up')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Company Name'),
                onChanged: (value) {
                  setState(() {
                    companyName = value;
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Manufacturer Name'),
                onChanged: (value) {
                  setState(() {
                    manufacturerName = value;
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Username'),
                onChanged: (value) {
                  setState(() {
                    username = value;
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                onChanged: (value) {
                  setState(() {
                    password = value;
                  });
                },
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    signUp();
                  }
                },
                child: Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
