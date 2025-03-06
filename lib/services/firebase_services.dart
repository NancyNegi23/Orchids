import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class FirebaseService {
  User? user = FirebaseAuth.instance.currentUser;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference orders = FirebaseFirestore.instance.collection('orders');

  Future<void> updateDocs(
      {CollectionReference? reference,
      Map<String, dynamic>? data,
      String? docName}) {
    return reference!.doc(docName).update(data!);
  }

  Future updateUser(
    Map<String, dynamic> data,
  ) {
    return users
        .doc(user!.uid)
        .update(data)
        .then(
          (value) {},
        )
        .catchError((error) {
      print(error.toString());
    });
  }

  Future updateUserLocation(Map<String, dynamic> data, context) {
    return users.doc(user!.uid).update(data).then(
      (value) {
        Navigator.pop(context);
      },
    ).catchError((error) {
      print(error);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Fail to update Address')));
    });
  }

  Future<void> deleteAddress(
    docId,
  ) {
    return FirebaseFirestore.instance
        .collection("customers")
        .doc(user!.uid)
        .collection("userAddress")
        .doc(docId)
        .delete();
    //     .catchError((e) {
    //   print(e.toString());
    // });
  }

  Future<String?> getAddress(double latitude, double longitude) async {
    var placemark = await placemarkFromCoordinates(latitude, longitude);
  }

  Future<DocumentSnapshot> getCustomerCredentials(id) {
    var result =
        FirebaseFirestore.instance.collection('customers').doc(id).get();
    return result;
  }
}
