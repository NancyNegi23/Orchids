import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../commonwidgets/leave_space_widget.dart';
import '../../../constants.dart';
import '../../../services/cart_services.dart';
import 'cart_card.dart';

class CartList extends StatefulWidget {
  DocumentSnapshot? document;

  CartList({
    Key? key,
    this.document,
  }) : super(key: key);

  @override
  _CartListState createState() => _CartListState();
}

class _CartListState extends State<CartList> {
  CartServices _cart = CartServices();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _cart.cart.doc(_cart.user!.uid).collection('items').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(
              child: CircularProgressIndicator(
            color: kPrimaryColor,
          ));
        }

        return Padding(
            padding:
                const EdgeInsets.only(top: 22, bottom: 22, left: 12, right: 12),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              // height: 100,
              child: Column(
                children: [
                  ListView.separated(
                      separatorBuilder: (BuildContext context, int index) {
                        return LeaveSpaceWidget(20);
                      },
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return CartCard(document: snapshot.data!.docs[index]);
                      }),
                  Divider(
                    indent: 10,
                    endIndent: 10,
                    color: Colors.grey.shade700,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Row(
                        children: [
                          Text(
                            '+',
                            style: TextStyle(
                                color: Colors.grey.shade600, fontSize: 15),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            'Add more items',
                            style: TextStyle(
                                color: Colors.grey.shade600, fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ));
      },
    );
  }
}
