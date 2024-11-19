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
    const backendUrl = 'http://192.168.1.114:5000/manufacturer/signup'; // Your backend URL

    try {
      var response = await http.post(
        Uri.parse(backendUrl),
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
        Navigator.pop(context); // Navigate back to login or another page
      } else {
        final errorMessage = json.decode(response.body)['message'] ?? 'Sign-Up Failed.';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Network Error: $e')),
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Company Name'),
                  onChanged: (value) {
                    setState(() {
                      companyName = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your company name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Manufacturer Name'),
                  onChanged: (value) {
                    setState(() {
                      manufacturerName = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the manufacturer name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Username'),
                  onChanged: (value) {
                    setState(() {
                      username = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your username';
                    }
                    return null;
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
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
      ),
    );
  }
}
