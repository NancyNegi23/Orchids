import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orchids/constants.dart';
import 'package:orchids/utils/search_card.dart';
import 'package:search_page/search_page.dart';

import '../modal/product_modal.dart';

class SearchScreen extends StatefulWidget {
  static const String id = 'search-screen';

  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  static List<Product> products = [];

  DocumentSnapshot? document;

  @override
  void initState() {
    FirebaseFirestore.instance
        .collection('products')
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (mounted) {
        querySnapshot.docs.forEach((doc) {
          setState(() {
            document = doc;

            products.add(Product(
              document: doc,
              name: doc['name'],
              price: doc['price'],
            ));
          });
        });
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    products.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // var _store = Provider.of<StoreProvider>(context);
    return Scaffold(
        // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        // floatingActionButton: Visibility(
        //   visible: distanceInMeters <= 3.5
        //       ? _cartProvider.cartQty > 0
        //           ? true
        //           : false
        //       : false,
        //   child: Container(
        //     decoration: BoxDecoration(
        //       color: const Color(0xFF3D3D3D),
        //       borderRadius: BorderRadius.circular(50),
        //       border: Border.all(width: 5, color: Colors.white),
        //     ),
        //     child: FloatingActionButton(
        //       backgroundColor: const Color(0xFF3D3D3D),
        //       child: Badge(
        //           elevation: 0,
        //           badgeContent: Text(
        //             '${_cartProvider.cartQty}',
        //             style: TextStyle(color: Colors.white),
        //           ),
        //           badgeColor: GlobalVariables.mainThemeColor,
        //           child: const Icon(
        //             Icons.shopping_bag_outlined,
        //             color: Colors.white,
        //           )),
        //       onPressed: () {
        //         Navigator.push(
        //             context,
        //             MaterialPageRoute(
        //               builder: (context) =>
        //                   CartScreen(document: _cartProvider.document),
        //             ));
        //       },
        //     ),
        //   ),
        // ),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: kPrimaryColor,
          actions: [
            IconButton(
              onPressed: () {
                showSearch(
                    context: context,
                    delegate: SearchPage<Product>(
                      barTheme: Theme.of(context).copyWith(
                        appBarTheme: AppBarTheme(
                            elevation: 0, backgroundColor: kPrimaryColor),
                        textTheme: Theme.of(context).textTheme.copyWith(
                              headline6: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                        inputDecorationTheme: const InputDecorationTheme(
                          hintStyle: TextStyle(
                            color: Colors.white,
                            //  Theme.of(context).primaryTextTheme.caption!.color,
                            fontSize: 20,
                          ),
                          focusedErrorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          border: InputBorder.none,
                        ),
                      ),
                      items: products,
                      searchLabel: 'Search product',
                      suggestion: Center(
                        child: Text('Search product by name, or price'),
                      ),
                      failure: Center(
                        child: Text('No product found :('),
                      ),
                      filter: (product) =>
                          [product.name, product.price.toString()],
                      builder: (product) => SearchCard(
                        product: product,
                        document: product.document!,
                      ),
                    ));
              },
              icon: const Icon(CupertinoIcons.search),
            )
          ],
        ),
        body: Center(child: Text('Search Product')));
  }
}
