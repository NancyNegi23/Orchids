import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

import '../../appbars/custom_appbar.dart';
import '../../commonwidgets/item_slider.dart';
import '../../commonwidgets/leave_space_widget.dart';
import '../../commonwidgets/recommendation_wid.dart';
import '../../constants.dart';
import '../catalogscreen/catalog_screen.dart';

class SectionScreen extends StatelessWidget {
  static const String routeName = '/section-screen';
  const SectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Men"),
      // drawer: const MyDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LeaveSpaceWidget(16),
              RecommendedItem(
                  bgImageUrl: imageUrl6,
                  title: "Premium wool",
                  desc: "The finest outdoor pieces,upgraded"),
              LeaveSpaceWidget(16),
              const Padding(
                padding: EdgeInsets.only(left: 16),
                child: Text(
                  'Trending',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              LeaveSpaceWidget(8),
              ItemsThumbnailSlider(items: menTrendingItems),
              LeaveSpaceWidget(16),
              const DropDownCategories(
                isExpanded: false,
                title: 'New Arrivals',
                items: ["View All", "Clothes", "Shoes & Accessories"],
              ),
              LeaveSpaceWidget(16),
              const DropDownCategories(
                isExpanded: false,
                title: 'Autumn lookbook',
                items: [
                  "Casual looks",
                  "Smart looks",
                  "Street looks",
                ],
              ),
              LeaveSpaceWidget(16),
              const DropDownCategories(
                isExpanded: false,
                title: 'Trending now',
                items: [
                  "The Party Edit",
                  "Oversized must haves",
                  "Matching sets",
                  "Music, Movies & Logos",
                  "layer up:Overshirts",
                ],
              ),
              LeaveSpaceWidget(16),
              const DropDownCategories(
                isExpanded: true,
                title: 'Shop by Product',
                items: [
                  "View All",
                  "Hoodies & Sweatshirts",
                  "T-shirts & Tanks",
                  "Cardigans & Jumpers",
                  "Shirts",
                  "Knitwear",
                  "Jeans",
                  "Jackets & Coats",
                  "Shoes",
                  "Trousers",
                  "Basics",
                  "Shorts",
                  "Suits & Blazers",
                  "Underwear & Innerwear",
                  "Socks",
                  "Accessories",
                  "Sportswear",
                  "Care products",
                  "Premium Selection",
                  "Sale",
                ],
              ),
              LeaveSpaceWidget(16),
              const DropDownCategories(
                isExpanded: false,
                title: 'The essentials',
                items: [
                  "The Party Edit",
                  "Oversized must haves",
                  "Matching sets",
                  "Music, Movies & Logos",
                  "layer up:Overshirts",
                ],
              ),
              LeaveSpaceWidget(16),
              const DropDownCategories(
                isExpanded: false,
                title: 'Trending now',
                items: [
                  "The Party Edit",
                  "Oversized must haves",
                  "Matching sets",
                  "Music, Movies & Logos",
                  "layer up:Overshirts",
                ],
              ),
              LeaveSpaceWidget(16),
            ],
          ),
        ),
      ),
    );
  }
}

class DropDownCategories extends StatelessWidget {
  final List items;
  final String title;
  final bool isExpanded;

  const DropDownCategories({
    Key? key,
    required this.items,
    required this.title,
    required this.isExpanded,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    buildList() {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        LeaveSpaceWidget(4),
        ...List.generate(
            items.length,
            (index) => InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, CatalogScreen.routeName);
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
                    child: SizedBox(
                      width: double.maxFinite,
                      child: Text(
                        items[index],
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ))
      ]);
    }

    return ExpandableNotifier(
        initialExpanded: isExpanded,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 4),
          child: ScrollOnExpand(
            child: Column(
              children: <Widget>[
                ExpandablePanel(
                  theme: const ExpandableThemeData(
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    tapBodyToExpand: true,
                    tapBodyToCollapse: false,
                    hasIcon: false,
                  ),
                  header: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
                    child: Builder(builder: (context) {
                      var controller =
                          ExpandableController.of(context, required: true)!;
                      return Row(
                        children: [
                          Expanded(
                            child: Text(
                              title,
                              style: TextStyle(
                                  fontSize: 18,
                                  color: controller.expanded
                                      ? Colors.red.shade500
                                      : Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          ExpandableIcon(
                            theme: ExpandableThemeData(
                              expandIcon: Icons.keyboard_arrow_down,
                              collapseIcon: Icons.keyboard_arrow_up,
                              iconColor: controller.expanded
                                  ? Colors.red.shade500
                                  : Colors.black,
                              iconSize: 24.0,
                              // iconRotationAngle: math.pi / 2,
                              iconPadding: const EdgeInsets.only(right: 5),
                              hasIcon: false,
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                  collapsed: Container(),
                  expanded: buildList(),
                ),
              ],
            ),
          ),
        ));
  }
}
