import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  DocumentSnapshot? snapshot;

  Future<DocumentSnapshot> getUserDetails() async {
    DocumentSnapshot result = await FirebaseFirestore.instance
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .get();
    if (result.exists) {
      snapshot = result;
      notifyListeners();
    } else {
      snapshot = null;
      notifyListeners();
    }
    return result;
  }
}
