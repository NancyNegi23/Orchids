import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:orchids/screens/productscreen/product_details_widget.dart';

import '../../commonwidgets/item_slider.dart';
import '../../commonwidgets/leave_space_widget.dart';
import '../../constants.dart';
import '../../modal/product_modal.dart';
import 'bottom_nav_bar.dart';
import 'image_widget.dart';

class ProductScreen extends StatelessWidget {
  static const String routeName = '/product-screen';
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      bottomNavigationBar: BottomNavBar(),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProductImageWidget(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LeaveSpaceWidget(24),
                const Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Text(
                    "H&M",
                    style: TextStyle(decoration: TextDecoration.underline),
                  ),
                ),
                LeaveSpaceWidget(8),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(
                    greenSweatshirt.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                LeaveSpaceWidget(16),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Row(
                    children: [
                      Text(
                        "Rs." + greenSweatshirt.price.toString(),
                        style: const TextStyle(
                          fontSize: 18,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      const Text(
                        "Per U",
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ],
                  ),
                ),
                LeaveSpaceWidget(32),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(
                    greenSweatshirt.color!,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                LeaveSpaceWidget(12),
                SizedBox(
                  height: 90,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: greenSweatshirt.otherColors!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.only(
                            left: (index == 0) ? 16 : 0,
                            right: (index ==
                                    greenSweatshirt.otherColors!.length - 1)
                                ? 16
                                : 4),
                        child: CachedNetworkImage(
                          imageUrl: greenSweatshirt.otherColors![index],
                          fit: BoxFit.cover,
                          width: 60,
                          filterQuality: FilterQuality.high,
                        ),
                      );
                    },
                  ),
                ),
                LeaveSpaceWidget(32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.store_outlined,
                      color: Colors.black54,
                      size: 20,
                    ),
                    SizedBox(width: 4),
                    Text("Check availability in store",
                        style: TextStyle(fontSize: 12))
                  ],
                ),
                LeaveSpaceWidget(16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Reviews (${greenSweatshirt.reviews})",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    RatingBar.builder(
                      ignoreGestures: true,
                      glow: false,
                      itemSize: 16,
                      initialRating: 4.2,
                      // minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.black,
                      ),
                      onRatingUpdate: (rating) {},
                    )
                  ],
                ),
                LeaveSpaceWidget(24),
              ],
            ),
            const ProductDetailsCard(),
            LeaveSpaceWidget(32),
            Center(
              child: TextButton(
                  onPressed: () {},
                  child: const Text("Details",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black))),
            ),
            LeaveSpaceWidget(4),
            Center(
              child: TextButton(
                  onPressed: () {},
                  child: const Text("Product background",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black))),
            ),
            LeaveSpaceWidget(4),
            Center(
              child: TextButton(
                  onPressed: () {},
                  child: const Text("Share",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black))),
            ),
            LeaveSpaceWidget(8),
            const Center(
                child: Text(
              "Delivery in 2-7 days.",
              style: TextStyle(fontSize: 12),
            )),
            LeaveSpaceWidget(12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Text(
                    "Style with",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                LeaveSpaceWidget(8),
                ItemsThumbnailSlider(items: styleWith),
                LeaveSpaceWidget(20),
                const Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Text(
                    "Others also bought",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                LeaveSpaceWidget(12),
                ItemsThumbnailSlider(items: othersAlsoBought),
                LeaveSpaceWidget(20),
                Container(
                  width: double.maxFinite,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 24,
                  ),
                  color: const Color(0xff889a8e),
                  child: Column(
                    children: [
                      LeaveSpaceWidget(20),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          "By 2030, we aim to only work with recycled, organic or other more sustainably sourced materials.",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 13),
                        ),
                      ),
                      LeaveSpaceWidget(18),
                      const Text(
                        "Right now, we're at 80%.",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      LeaveSpaceWidget(18),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          "Curious about what we're doing to lessen our environmental impact? Read more here →",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      LeaveSpaceWidget(20),
                    ],
                  ),
                ),
                LeaveSpaceWidget(64),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
