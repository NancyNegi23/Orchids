import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderServices {
  CollectionReference orders = FirebaseFirestore.instance.collection('orders');

  Future<DocumentReference> saveOrder(Map<String, dynamic> data) {
    var result = orders.add(data);
    return result;
  }

  Color? statusColor(DocumentSnapshot document) {
    if (document['orderStatus'] == 'Ordered') {
      return Colors.deepOrangeAccent;
    }
    if (document['orderStatus'] == 'Packed') {
      return Colors.cyan;
    }
    if (document['orderStatus'] == 'Shipped') {
      return Colors.blue;
    }

    if (document['orderStatus'] == 'Delivered') {
      return Colors.green;
    }
    return Colors.orange;
  }

  Icon statusIcon(DocumentSnapshot document) {
    if (document['orderStatus'] == 'Ordered') {
      return Icon(
        Icons.assignment_turned_in_outlined,
        color: statusColor(document),
      );
    }
    if (document['orderStatus'] == 'Packed') {
      return Icon(
        Icons.shopify,
        color: statusColor(document),
      );
    }
    if (document['orderStatus'] == 'Shipped') {
      return Icon(
        Icons.local_shipping_outlined,
        color: statusColor(document),
      );
    }

    if (document['orderStatus'] == 'Delivered') {
      return Icon(
        Icons.shopping_bag_outlined,
        color: statusColor(document),
      );
    }

    return Icon(
      Icons.assignment_turned_in_outlined,
      color: statusColor(document),
    );
  }
}
