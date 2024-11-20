import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DistributorLoginPage extends StatefulWidget {
  @override
  _DistributorLoginPageState createState() => _DistributorLoginPageState();
}

class _DistributorLoginPageState extends State<DistributorLoginPage> {
  final _formKey = GlobalKey<FormState>();
  String username = '';
  String password = '';

  // Function to handle login
  Future<void> login() async {
    var response = await http.post(
      Uri.parse('http://127.0.0.1:5000/distributor/login'), // Replace with your backend URL
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login Successful!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid username or password.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Distributor Login')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
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
                    login();
                  }
                },
                child: Text('Login'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/distributor-signup');
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
