import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../services/cart_services.dart';

class CartProvider with ChangeNotifier {
  final CartServices _cart = CartServices();
  double subTotal = 0.0;
  int cartQty = 0;

  QuerySnapshot? snapshot;
  DocumentSnapshot? document;
  double saving = 0.0;
  double distance = 0.0;
  bool cod = false;
  bool success = false;
  List cartList = [];
  String? shopName;
  late String email;

  late String amount;

  String _selectedValue = "Y";
  Future<double?> getCartTotal() async {
    var cartTotal = 0.0;
    var saving = 0.0;
    List _newList = [];
    QuerySnapshot snapshot =
        await _cart.cart.doc(_cart.user!.uid).collection('items').get();

    snapshot.docs.forEach((doc) {
      if (!_newList.contains(doc.data())) {
        _newList.add(doc.data());
        this.cartList = _newList;
        notifyListeners();
      }

      cartTotal = cartTotal + doc['total'];
      // saving = saving +
      //     ((doc['comparedPrice'] - doc['price']) > 0
      //         ? doc['comparedPrice'] - doc['price']
      //         : 0);
    });
    subTotal = cartTotal;
    cartQty = snapshot.size;
    snapshot = snapshot;
    saving = saving;
    notifyListeners();

    return cartTotal;
  }

  getPaymentMethod(index) {
    if (index == 0) {
      cod = false;
      notifyListeners();
    } else if (index == 1) {
      cod = true;
      notifyListeners();
    }
  }

  String get selectedValue => _selectedValue!;

  void setSelectedValue(String value) {
    _selectedValue = value;
    notifyListeners();
  }

  paymentStatus(index) {
    if (index == 0) {
      this.success = true;
      notifyListeners();
    } else if (index == 1) {
      this.success = false;
      notifyListeners();
    }
    // print('55555555555555');
    // print(index);
  }

  totalAmount(amount, email) {
    this.amount = amount.toStringAsFixed(0);
    this.email = email;
    notifyListeners();
  }
}
