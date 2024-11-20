import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserLoginPage extends StatefulWidget {
  @override
  _UserLoginPageState createState() => _UserLoginPageState();
}

class _UserLoginPageState extends State<UserLoginPage> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';

  // Function to handle login
  Future<void> login() async {
    var response = await http.post(
      Uri.parse('http://127.0.0.1:5000/login'), // Replace with your backend URL
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login Successful!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid email or password.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Login')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                onChanged: (value) {
                  setState(() {
                    email = value;
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
                    login();
                  }
                },
                child: Text('Login'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/user-signup');
                },
                child: Text('Don\'t have an account? Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
