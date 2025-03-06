import 'package:badges/badges.dart' as badges;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orchids/screens/cart/cart_screen.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../provider/cart_provider.dart';

class ProductImageWidget extends StatefulWidget {
  DocumentSnapshot? docs;
  ProductImageWidget({
    this.docs,
    Key? key,
  }) : super(key: key);

  @override
  State<ProductImageWidget> createState() => _ProductImageWidgetState();
}

class _ProductImageWidgetState extends State<ProductImageWidget> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final _cartProvider = Provider.of<CartProvider>(context);
    _cartProvider.getCartTotal();
    return Stack(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.7,
          width: MediaQuery.of(context).size.width,
          child: Hero(
            tag: "ProductImage1",
            child: PageView.builder(
                itemCount: widget.docs!['images'].length,
                onPageChanged: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: widget.docs!['images'][index],
                  );
                }),
          ),
        ),
        if (widget.docs!['images'].length > 1)
          Positioned(
            bottom: 28,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...List.generate(
                    widget.docs!['images'].length,
                    (index) => Container(
                      height: 8,
                      width: 8,
                      margin: const EdgeInsets.symmetric(horizontal: 6),
                      decoration: BoxDecoration(
                        color: (_selectedIndex == index)
                            ? Colors.white
                            : Colors.white.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        Positioned(
          right: 8,
          top: 12,
          child: GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CartScreen()));
            },
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white,
              child: badges.Badge(
                  badgeStyle: badges.BadgeStyle(
                      badgeColor: _cartProvider.cartQty == 0
                          ? Colors.white
                          : kPrimaryColor),
                  badgeContent: Text(
                    '${_cartProvider.cartQty == 0 ? '' : _cartProvider.cartQty}',
                    style: TextStyle(color: Colors.white),
                  ),
                  child: Icon(
                    CupertinoIcons.bag,
                    color: Colors.black,
                  )),
              // : IconButton(
              //   onPressed: () {},
              //   style: IconButton.styleFrom(
              //       tapTargetSize: MaterialTapTargetSize.shrinkWrap),
              //   icon:

              //  const Icon(
              //   CupertinoIcons.bag,
              //   color: Colors.black,
              // ),
              // ),
            ),
          ),
        ),
        // Positioned(
        //   right: 8,
        //   top: 72,
        //   child: CircleAvatar(
        //     radius: 20,
        //     backgroundColor: Colors.white,
        //     child: IconButton(
        //       onPressed: () {},
        //       style: IconButton.styleFrom(
        //           tapTargetSize: MaterialTapTargetSize.shrinkWrap),
        //       icon: const Icon(
        //         CupertinoIcons.heart,
        //         color: Colors.black,
        //       ),
        //     ),
        //   ),
        // ),
        Positioned(
          left: 8,
          top: 12,
          child: CircleAvatar(
            radius: 20,
            backgroundColor: Colors.white,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: IconButton.styleFrom(
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap),
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
