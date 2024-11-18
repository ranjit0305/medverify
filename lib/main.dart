import 'package:flutter/material.dart';
import 'screens/manufacturer_login.dart';
import 'screens/manufacturer_SignUpPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MedVerify',
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/manufacturer-login': (context) => ManufacturerLoginPage(),
        '/manufacturer-signup': (context) => ManufacturerSignUpPage(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MedVerify Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navigate to manufacturer login
                Navigator.pushNamed(context, '/manufacturer-login');
              },
              child: Text('Manufacturer Login'),
            ),
            ElevatedButton(
              onPressed: () {
                // Placeholder for User Login functionality
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('User Login Coming Soon!')),
                );
              },
              child: Text('User Login'),
            ),
            ElevatedButton(
              onPressed: () {
                // Placeholder for Distributor Login functionality
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Distributor Login Coming Soon!')),
                );
              },
              child: Text('Distributor Login'),
            ),
          ],
        ),
      ),
    );
  }
}
