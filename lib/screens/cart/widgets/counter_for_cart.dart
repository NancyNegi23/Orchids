import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../provider/cart_provider.dart';
import '../../../services/cart_services.dart';

class CounterForCard extends StatefulWidget {
  final DocumentSnapshot document;

  CounterForCard({required this.document, key}) : super(key: key);

  // CounterForCard(
  //   this.itemId,
  //   this.document,
  // );

  @override
  _CounterForCardState createState() => _CounterForCardState();
}

class _CounterForCardState extends State<CounterForCard> {
  User? user = FirebaseAuth.instance.currentUser;
  final CartServices _cart = CartServices();
  int _qty = 1;
  String? _docId;
  bool _exists = false;
  bool _updating = false;

  getCartData() {
    FirebaseFirestore.instance
        .collection('cart')
        .doc(user!.uid)
        .collection('items')
        .where('itemId', isEqualTo: widget.document['itemId'])
        .get()
        .then((QuerySnapshot querySnapshot) => {
              if (querySnapshot.docs.isNotEmpty)
                {
                  querySnapshot.docs.forEach((doc) {
                    if (doc['itemId'] == widget.document['itemId']) {
                      if (mounted) {
                        setState(() {
                          _qty = doc['qty'];
                          _docId = doc.id;
                          _exists = true;
                        });
                      }
                    }
                  }),
                }
              else if (mounted)
                {
                  setState(() {
                    _exists = false;
                  })
                }
            });
  }

  @override
  void initState() {
    super.initState();
    getCartData();
  }

  @override
  void dispose() {
    super.dispose();
    getCartData();
  }

  @override
  Widget build(BuildContext context) {
    var _cartProvider = Provider.of<CartProvider>(context);
    return _exists
        ? StreamBuilder(
            stream: getCartData(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              return Container(
                height: 28,
                decoration: BoxDecoration(
                    border: Border.all(color: kPrimaryColor),
                    borderRadius: BorderRadius.circular(6)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      flex: 10,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _updating = true;
                          });
                          if (_qty == 1) {
                            _cart.removeFromCart(_docId).then((value) {
                              setState(() {
                                _updating = false;
                                _exists = false;
                              });
                              //  Need to check after Remove
                              _cart.checkData();
                            });
                          }
                          if (_qty > 1) {
                            setState(() {
                              _qty--;
                            });
                            var total = _qty * widget.document['price'];
                            _cart
                                .updateCartQty(_docId, _qty, total)
                                .then((value) {
                              setState(() {
                                _updating = false;
                              });
                            });
                          }
                        },
                        child: Container(
                          color: Colors.white,
                          child: Icon(
                            _qty == 1 ? Icons.delete_outline : Icons.remove,
                            color: kPrimaryColor,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 15,
                      child: Container(
                          height: double.infinity,
                          // width: double.maxFinite,
                          color: kPrimaryColor,
                          child: Center(
                              child: FittedBox(
                                  child: _updating
                                      ? const Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: CircularProgressIndicator(
                                            valueColor:
                                                const AlwaysStoppedAnimation<
                                                    Color>(Colors.white),
                                          ),
                                        )
                                      : Text(
                                          _qty.toString(),
                                          style: const TextStyle(
                                              color: Colors.white),
                                        )))),
                    ),
                    Expanded(
                      flex: 10,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _updating = true;
                            _qty++;
                          });
                          var total = _qty * widget.document['price'];
                          _cart
                              .updateCartQty(_docId, _qty, total)
                              .then((value) {
                            setState(() {
                              _updating = false;
                            });
                          });
                        },
                        child: Container(
                          color: Colors.white,
                          child: Icon(
                            Icons.add,
                            color: kPrimaryColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            })
        : StreamBuilder(
            stream: getCartData(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              return InkWell(
                onTap: () {
                  if (_cartProvider.selectedValue == 'Y') {
                    EasyLoading.showToast('Please choose size');
                  } else {
                    EasyLoading.show(status: 'Adding to Cart');

                    // setState(() {
                    //   _exists = true;
                    // });
                    // _cart.addToCart(widget.document).then((value) {
                    //   EasyLoading.showSuccess('Added To Cart');
                    // });

                    // _cart.checkSeller().then((shopName) {
                    //   if (shopName == widget.document['seller']['shopName']) {
                    //     setState(() {
                    //       _exists = true;
                    //     });
                    //     _cart.addToCart(widget.document).then((value) {
                    //       EasyLoading.showSuccess('Added To Cart');
                    //     });
                    //     return;
                    //   }
                    //   if (shopName == null) {
                    //     setState(() {
                    //       _exists = true;
                    //     });
                    _cart
                        .addToCart(widget.document, _cartProvider.selectedValue)
                        .then((value) {
                      EasyLoading.showSuccess('Added To Cart');
                      setState(() {
                        _cartProvider.selectedValue == "Y";
                      });
                      // });
                      return;
                      // }

                      // if (shopName != widget.document['seller']['shopName']) {
                      //   EasyLoading.dismiss();
                      //   showDialog(shopName);
                      // }
                    });
                  }
                },
                child: Container(
                  height: 28,
                  decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(6)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.shopping_bag_outlined,
                        color: Colors.white,
                        size: 18,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        "Add",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      )
                    ],
                  ),
                ),
              );
            });
  }
}
