import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:orchids/auth/registration_screen.dart';
import 'package:orchids/constants.dart';
import 'package:orchids/screens/homescreen/homescreen.dart';

import '../../../services/firebase_services.dart';
import '../modal/user.dart';
import 'login_view.dart';

class LandingScreen extends StatelessWidget {
  final String phone;

  LandingScreen(this.phone);

  final FirebaseService _services = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<DocumentSnapshot>(
            stream: _services.users.doc(_services.user!.uid).snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Center(child: Text('Something went wrong'));
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: CircularProgressIndicator(
                  color: Color(0xFF70B224),
                ));
              }
              if (!snapshot.data!.exists) {
                return RegistrationScreen(mobNumController.text);
              }
              Users users =
                  Users.fromJson(snapshot.data!.data() as Map<String, dynamic>);
              if (users.accVerified == true) {
                return HomeScreen();
              }
              return const CircularProgressIndicator(color: kPrimaryColor);
            }));
  }
}
