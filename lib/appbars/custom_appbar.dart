import 'package:badges/badges.dart' as badges;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orchids/auth/profile_screen.dart';
import 'package:orchids/utils/search_screen.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../provider/cart_provider.dart';
import '../screens/cart/cart_screen.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const CustomAppBar({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _cartProvider = Provider.of<CartProvider>(context);
    _cartProvider.getCartTotal();
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(
            color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.black),
      actions: [
        IconButton(
          padding: const EdgeInsets.all(0),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SearchScreen()));
          },
          icon: const Icon(CupertinoIcons.search),
        ),
        IconButton(
          padding: const EdgeInsets.all(0),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => UserProfileScreen()));
          },
          icon: const Icon(CupertinoIcons.person),
        ),
        // IconButton(
        //   padding: const EdgeInsets.all(0),
        //   onPressed: () {},
        //   icon: const Icon(CupertinoIcons.heart),
        // ),

        Padding(
          padding: const EdgeInsets.only(right: 12.0),
          child: Center(
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CartScreen()));
              },
              child: badges.Badge(
                badgeStyle: badges.BadgeStyle(
                    badgeColor: _cartProvider.cartQty == 0
                        ? Colors.white
                        : kPrimaryColor),
                badgeContent: Text(
                  '${_cartProvider.cartQty == 0 ? '' : _cartProvider.cartQty}',
                  style: TextStyle(color: Colors.white),
                ),
                child: const Icon(CupertinoIcons.bag),
              ),
            ),
          ),
        )
        // IconButton(

        //   padding: const EdgeInsets.all(0),
        //   onPressed: () {},
        //   icon: const Icon(CupertinoIcons.bag),
        // ),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
