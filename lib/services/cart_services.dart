import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CartServices {
  CollectionReference cart = FirebaseFirestore.instance.collection('cart');

  User? user = FirebaseAuth.instance.currentUser;

  Future<void> addToCart(document, String size) {
    cart.doc(user!.uid).set({
      'user': user!.uid,
      'timeStamp': DateTime.now().toString(),
    });
    return cart.doc(user!.uid).collection('items').add({
      'itemId': document.data()['itemId'],
      'productName': document.data()['name'],
      'productImage': document.data()['images'][0],
      'price': document.data()['price'],
      'qty': 1,
      'total': document.data()['price'],
      'size': size
    });
  }

  Future<void> updateCartQty(docId, qty, total) async {
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection('cart')
        .doc(user!.uid)
        .collection('items')
        .doc(docId);

    return FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(documentReference);

      if (!snapshot.exists) {
        throw Exception("Product does not exist in Cart!");
      }

      transaction.update(documentReference, {'qty': qty, 'total': total});

      // Return the new count
      return qty;
    }).then((value) {
      print("Updated Cart");
    }).catchError((error) => print("Failed to update cart: $error"));
  }

  Future<void> removeFromCart(docId) async {
    cart.doc(user!.uid).collection('items').doc(docId).delete();
  }

  Future<void> checkData() async {
    final snapshot = await cart.doc(user!.uid).collection('items').get();
    if (snapshot.docs.isEmpty) {
      cart.doc(user!.uid).delete();
    }
  }

  Future<void> deleteCart() async {
    await cart.doc(user!.uid).collection('items').get().then((snapshot) {
      for (DocumentSnapshot db in snapshot.docs) {
        db.reference.delete();
      }
    });
  }
}
