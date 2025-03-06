import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:orchids/screens/category/product_detail_screen.dart';

import '../modal/product_modal.dart';

class SearchCard extends StatefulWidget {
  SearchCard({
    Key? key,
    required this.product,
    required this.document,
  }) : super(key: key);

  final Product product;
  final DocumentSnapshot document;

  @override
  State<SearchCard> createState() => _SearchCardState();
}

class _SearchCardState extends State<SearchCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Theme.of(context).primaryColor,
      height: 160,

      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 1, color: Colors.grey))),
      child: Padding(
        padding:
            const EdgeInsets.only(top: 8.0, bottom: 8, left: 10, right: 10),
        child: Row(
          children: [
            Stack(
              children: [
                Material(
                  elevation: 0,
                  borderRadius: BorderRadius.circular(10),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductDetailScreen(
                                  documnets: widget.document)));
                    },
                    child: SizedBox(
                        height: 140,
                        width: 130,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Hero(
                                tag: widget.product.document!['itemId'],
                                child: Image.network(
                                    widget.product.document!['images'][0])))),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text(product.document['brand'],
                        //   style: TextStyle(fontSize: 10),),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          widget.product.document!['name'],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),

                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              '\₹${widget.product.document!['price'].toStringAsFixed(0)}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.end,
                  //   children: [
                  //     Container(
                  //         width: MediaQuery.of(context).size.width - 160,
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.end,
                  //           children: [

                  //             if (widget.document['sizeList'].length == 0)
                  //               CounterForCard(widget.document),
                  //             if (widget.document['sizeList'].length > 0)
                  //               ShowModelBottom(
                  //                 document: widget.document,
                  //               ),
                  //           ],
                  //         )),
                  //   ],
                  // )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
