import 'package:flutter/material.dart';
import 'package:orchids/screens/cart/widgets/cart_list.dart';
import 'package:provider/provider.dart';

import '../../commonwidgets/leave_space_widget.dart';
import '../../modal/product_modal.dart';
import '../../provider/cart_provider.dart';
import 'bill_confirmation.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _cartProvider = Provider.of<CartProvider>(context);

    _cartProvider.getCartTotal();

    double subTotal = _cartProvider.subTotal;
    return _cartProvider.cartQty == 0
        ? Scaffold(
            body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Your Cart is Empty',
                  style: TextStyle(fontSize: 28),
                ),
                SizedBox(
                  height: 50,
                ),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        // Navigator.pushNamedAndRemoveUntil(
                        //   context,
                        //   HomeScreen.routeName,
                        //   (route) => false,
                        // );
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(),
                          minimumSize: Size(double.maxFinite, 48)),
                      child: Text('Back')),
                )
              ],
            ),
          ))
        : Scaffold(
            persistentFooterButtons: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BillingConfrimation(
                                  totalAmount: _cartProvider.subTotal,
                                  document: _cartProvider.document,
                                )));
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(),
                      minimumSize: Size(double.maxFinite, 48)),
                  child: Text(
                    "Continue to checkout",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
            appBar: AppBar(
              elevation: 2,
              backgroundColor: Colors.white,
              title: const Text(
                "Shopping Bag",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            body: SafeArea(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  LeaveSpaceWidget(30),
                  Text(
                    "Estimated delivery time 2-7 days",
                    style: TextStyle(fontSize: 12),
                  ),
                  LeaveSpaceWidget(30),
                  CartList(),
                  LeaveSpaceWidget(20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Column(
                      children: [
                        Divider(thickness: 1),
                        LeaveSpaceWidget(8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Order Value"),
                            Text("Rs." + subTotal.toStringAsFixed(0))
                          ],
                        ),
                        LeaveSpaceWidget(4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [Text("Delivery"), Text("FREE")],
                        ),
                        Divider(thickness: 1, color: Colors.black45),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Total",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            Text("Rs." + subTotal.toStringAsFixed(0),
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  LeaveSpaceWidget(12),
                  LeaveSpaceWidget(40)
                ],
              ),
            )),
          );
  }
}

class CartItemWidget extends StatelessWidget {
  const CartItemWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 5.5,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            AspectRatio(
              aspectRatio: 3 / 4,
              child: Image.network(
                greenSweatshirt.imageUrl![0],
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    greenSweatshirt.name,
                    style: TextStyle(fontSize: 16),
                  ),
                  // LeaveSpaceWidget(4),
                  Text(
                    "Rs. " + greenSweatshirt.price.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  // LeaveSpaceWidget(4),
                  Text(
                    "Size: Large",
                    // style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  // LeaveSpaceWidget(4),
                  Container(
                    width: double.maxFinite,
                    height: 36,
                    margin: EdgeInsets.symmetric(horizontal: 0),
                    decoration: BoxDecoration(border: Border.all()),
                    child: Center(child: Text("Remove")),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
