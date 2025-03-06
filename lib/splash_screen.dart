import 'dart:async';

import 'package:flutter/material.dart';

import 'auth/login_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = '/splash-screen';

  const SplashScreen({key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 3), () async {
      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 200.0,
              height: 200.0,
              child: Image.asset(
                'assets/images/logo.png',
                height: 200,
                width: 200,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
