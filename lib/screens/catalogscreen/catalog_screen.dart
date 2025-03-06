import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../appbars/custom_appbar.dart';
import '../../commonwidgets/leave_space_widget.dart';
import '../../modal/catalog_modal.dart';
import '../productscreen/product_screen.dart';

class CatalogScreen extends StatelessWidget {
  static const String routeName = '/Catalog-screen';
  const CatalogScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Sweatshirts"),
      // drawer: const MyDrawer(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 12,
              childAspectRatio: 2 / 4.25,
              crossAxisCount: 2,
            ),
            itemCount: sweatshirtCatalog.length,
            itemBuilder: (BuildContext context, int itemIndex) {
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(context, ProductScreen.routeName);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        AspectRatio(
                          aspectRatio: 0.675,
                          child: Hero(
                            tag: "ProductImage" + itemIndex.toString(),
                            child: CachedNetworkImage(
                              imageUrl: sweatshirtCatalog[itemIndex].imageUrl,
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
                    sweatshirtCatalog[0].isCollaborated
                        ? Column(
                            children: [
                              LeaveSpaceWidget(4),
                              Text(
                                sweatshirtCatalog[itemIndex]
                                    .collaborationPartner,
                                style: const TextStyle(
                                    letterSpacing: 1.5, fontSize: 12),
                              ),
                            ],
                          )
                        : LeaveSpaceWidget(0),
                    LeaveSpaceWidget(6),
                    SizedBox(
                      width: (MediaQuery.of(context).size.width - 48) / 2,
                      child: Text(
                        sweatshirtCatalog[itemIndex].name,
                        style: const TextStyle(fontSize: 13),
                      ),
                    ),
                    LeaveSpaceWidget(4),
                    Text(
                      "Rs ${sweatshirtCatalog[itemIndex].price}",
                      style: const TextStyle(fontSize: 13),
                    ),
                    LeaveSpaceWidget(10),
                    Row(
                      children: [
                        ...List.generate(
                            (sweatshirtCatalog[itemIndex].itemColors.length > 4)
                                ? 4
                                : sweatshirtCatalog[itemIndex]
                                    .itemColors
                                    .length,
                            // sweatshirtCatalog[itemIndex].itemColors.length,
                            (index) => Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: Container(
                                    height: 10,
                                    width: 10,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: sweatshirtCatalog[itemIndex]
                                            .itemColors[index],
                                        //change its value
                                        border: Border.all(width: 0.2)),
                                  ),
                                )),
                        (sweatshirtCatalog[itemIndex].itemColors.length > 4)
                            ? Text(
                                "+" +
                                    (sweatshirtCatalog[itemIndex]
                                                .itemColors
                                                .length -
                                            4)
                                        .toString(),
                                style: const TextStyle(
                                  fontSize: 12,
                                ),
                              )
                            : const SizedBox()
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
