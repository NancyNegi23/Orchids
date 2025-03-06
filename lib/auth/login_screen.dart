import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:orchids/screens/homescreen/homescreen.dart';

import 'login_view.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = '/login-screen';

  const LoginScreen({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const LoginView();
          }
          return HomeScreen();
        });
  }
}
