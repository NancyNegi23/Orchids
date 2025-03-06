import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screens/productscreen/product_screen.dart';
import 'leave_space_widget.dart';

//Widget that displays product image , title and price
class ItemsThumbnailSlider extends StatelessWidget {
  List items;
  ItemsThumbnailSlider({
    Key? key,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.25 + 72,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.only(left: (index == 0) ? 16 : 0, right: 12),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, ProductScreen.routeName);
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.25,
                    width: MediaQuery.of(context).size.height * 0.166667,
                    child: Stack(
                      children: [
                        AspectRatio(
                          aspectRatio: 2 / 3,
                          child: CachedNetworkImage(
                              imageUrl: items[index].imageUrl,
                              fit: BoxFit.cover),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: IconButton(
                            padding: const EdgeInsets.all(8),
                            alignment: Alignment.bottomRight,
                            icon: const Icon(CupertinoIcons.heart, size: 28),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                  LeaveSpaceWidget(8),
                  SizedBox(
                    //height 32
                    width: MediaQuery.of(context).size.height * 0.166667,
                    child: Text(
                      items[index].name,
                      maxLines: 2,
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                  LeaveSpaceWidget(4),
                  Text(
                    "Rs ${items[index].price}",
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
