import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:orchids/screens/category/product_card_with_two.dart';

import '../../appbars/custom_appbar.dart';
import '../../commonwidgets/leave_space_widget.dart';
import '../../commonwidgets/recommendation_wid.dart';
import '../../constants.dart';

class CategoryScreen extends StatelessWidget {
  final String cateId;
  final String? dimage;
  final String? dtitle;
  final String? dDescription;
  const CategoryScreen(
      {required this.cateId,
      this.dimage,
      this.dtitle,
      this.dDescription,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(title: ""),
      body: SingleChildScrollView(
        child: Column(
          children: [
            RecommendedItem(
                bgImageUrl: dimage != null ? dimage! : imageUrl6,
                title: dtitle != null ? dtitle! : "Premium wool",
                desc: dDescription != null
                    ? dDescription!
                    : "The finest outdoor pieces,upgraded"),
            LeaveSpaceWidget(30),
            const Text(
              "Shop By Category",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.transparent,
                shadows: [Shadow(offset: Offset(0, -8), color: Colors.black)],
                decoration: TextDecoration.underline,
                decorationThickness: 2,
                decorationColor: Colors.black,
              ),
            ),
            LeaveSpaceWidget(16),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('categories')
                  .doc(cateId)
                  .collection('subcategories')
                  .orderBy('createdAt', descending: true)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                      child: CircularProgressIndicator(
                    color: kPrimaryColor,
                  ));
                }

                return GridView.builder(
                  itemCount: snapshot.data!.docs.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyProductCatalogScreen(
                                catId: cateId,
                                subCatName: snapshot.data!.docs[index]['name'],
                                subCatId: snapshot.data!.docs[index].id,
                              ),
                            ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CircleAvatar(
                                // radius: 40,
                                maxRadius: 60,
                                minRadius: 60,
                                backgroundColor: Colors.grey.shade100,
                                backgroundImage: NetworkImage(
                                    snapshot.data!.docs[index]['image']),
                              ),
                              Text(
                                snapshot.data!.docs[index]['name'],
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            LeaveSpaceWidget(100)
          ],
        ),
      ),
    );
  }
}
