import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DistributorSignUpPage extends StatefulWidget {
  @override
  _DistributorSignUpPageState createState() => _DistributorSignUpPageState();
}

class _DistributorSignUpPageState extends State<DistributorSignUpPage> {
  final _formKey = GlobalKey<FormState>();
  String companyName = '';
  String distributorName = '';
  String username = '';
  String password = '';

  // Function to handle sign-up
  Future<void> signUp() async {
    const backendUrl = 'http://127.0.0.1:5000/api/distributors/register'; // Match the backend route

    try {
      var response = await http.post(
        Uri.parse(backendUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'companyName': companyName,
          'distributorName': distributorName,
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
      appBar: AppBar(title: Text('Distributor Sign-Up')),
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
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Distributor Name'),
                  onChanged: (value) {
                    setState(() {
                      distributorName = value;
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
