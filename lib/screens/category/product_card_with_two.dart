import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:orchids/screens/category/product_detail_screen.dart';

import '../../appbars/custom_appbar.dart';
import '../../commonwidgets/leave_space_widget.dart';
import '../../constants.dart';

class MyProductCatalogScreen extends StatelessWidget {
  final String subCatId;
  final String catId;
  final String subCatName;
  const MyProductCatalogScreen(
      {required this.catId,
      required this.subCatName,
      required this.subCatId,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: subCatName),
      // drawer: const MyDrawer(),
      body: SafeArea(
          child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('categories')
                  .doc(catId)
                  .collection('subcategories')
                  .doc(subCatId)
                  .collection('items')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                      child: CircularProgressIndicator(
                    color: kPrimaryColor,
                  ));
                }
                return Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 12,
                      childAspectRatio: 2 / 4,
                      crossAxisCount: 2,
                    ),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int itemIndex) {
                      var data = snapshot.data!.docs[itemIndex];
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetailScreen(
                                  documnets: data,
                                ),
                              ));
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                AspectRatio(
                                  aspectRatio: 0.675,
                                  child: Hero(
                                    tag: data["itemId"],
                                    child: CachedNetworkImage(
                                      imageUrl: data['images'][0],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                // Positioned(
                                //     bottom: 4,
                                //     right: 4,
                                //     child: IconButton(
                                //       icon: const Icon(
                                //         CupertinoIcons.heart,
                                //         size: 28,
                                //       ),
                                //       onPressed: () {},
                                //     ))
                              ],
                            ),
                            LeaveSpaceWidget(6),
                            SizedBox(
                              width:
                                  (MediaQuery.of(context).size.width - 48) / 2,
                              child: Text(
                                data['name'],
                                style: const TextStyle(fontSize: 13),
                              ),
                            ),
                            LeaveSpaceWidget(4),
                            Text(
                              "Rs ${data['price']}",
                              style: const TextStyle(fontSize: 13),
                            ),
                            LeaveSpaceWidget(10),
                          ],
                        ),
                      );
                    },
                  ),
                );
              })),
    );
  }
}
