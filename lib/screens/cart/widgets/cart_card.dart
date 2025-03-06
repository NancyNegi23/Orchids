import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:orchids/screens/cart/widgets/counter_for_cart.dart';

class CartCard extends StatelessWidget {
  final DocumentSnapshot document;
  const CartCard({required this.document, super.key});

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
                document['productImage'],
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    document['productName'],
                    style: TextStyle(fontSize: 16),
                  ),
                  // LeaveSpaceWidget(8),
                  Text(
                    "Rs. " + document['price'].toString(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  // LeaveSpaceWidget(12),
                  Text(
                    "Size: " + document['size'],
                    // style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  // Expanded(child: SizedBox()),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Expanded(
                      //   child: Container(
                      //     width: double.maxFinite,
                      //     height: 36,
                      //     margin: EdgeInsets.symmetric(horizontal: 0),
                      //     decoration: BoxDecoration(border: Border.all()),
                      //     child: Center(
                      //         child: Icon(
                      //       CupertinoIcons.heart,
                      //       size: 18,
                      //     )),
                      //   ),
                      // ),
                      SizedBox(width: 12),
                      Expanded(
                        child: CounterForCard(
                          document: document,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
    // Row(
    //   mainAxisAlignment: MainAxisAlignment.spaceAround,
    //   children: [
    //     SizedBox(
    //       width: MediaQuery.of(context).size.width - 260,
    //       child: Text(
    //         document['title'],
    //         style: TextStyle(
    //             overflow: TextOverflow.ellipsis, fontWeight: FontWeight.w500),
    //         maxLines: 2,
    //       ),
    //     ),
    //     // if (document['size'] != null) ...[
    //     //   CounterForSizeCardCartList(document),
    //     // ],
    //     // if (document['size'] == null) ...[
    //     //   CounterForCard(document),
    //     // ],
    //     Text(
    //       '₹ ${document['price'].toStringAsFixed(0)}',
    //       style: TextStyle(fontWeight: FontWeight.bold),
    //     ),
    //   ],
    // );
  }
}
