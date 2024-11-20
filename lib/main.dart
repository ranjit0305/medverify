import 'package:flutter/material.dart';
import 'screens/manufacturer_login.dart';
import 'screens/manufacturer_SignUpPage.dart';
import 'screens/user_login.dart';
import 'screens/user_signup.dart';
import 'screens/distributor_login.dart';
import 'screens/distributor_signup.dart';

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
        '/user-login': (context) => UserLoginPage(),
        '/user-signup': (context) => UserSignUpPage(),
        '/distributor-login': (context) => DistributorLoginPage(),
        '/distributor-signup': (context) => DistributorSignUpPage(),
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
                // Navigate to user login
                Navigator.pushNamed(context, '/user-login');
              },
              child: Text('User Login'),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigate to distributor login
                Navigator.pushNamed(context, '/distributor-login');
              },
              child: Text('Distributor Login'),
            ),
          ],
        ),
      ),
    );
  }
}
