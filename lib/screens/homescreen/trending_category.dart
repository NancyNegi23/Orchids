import 'package:flutter/material.dart';

import '../../commonwidgets/leave_space_widget.dart';
import '../../modal/trending_categories_item_modal.dart';

class TrendingCategoriesWidget extends StatelessWidget {
  const TrendingCategoriesWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "Categories you might like",
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
          ),
        ),
        LeaveSpaceWidget(16),
        TrendingCategoryItems(),
      ],
    );
  }
}

//Widget with the items of trending categories
class TrendingCategoryItems extends StatelessWidget {
  TrendingCategoryItems({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List items = trendingCategoriesItems;
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.17,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.only(
                left: 8, right: (index == items.length - 1) ? 8 : 0),
            width: MediaQuery.of(context).size.width * 0.2,
            child: Column(
              children: [
                CircleAvatar(
                  radius: 36,
                  backgroundColor: const Color(0xffeee5ce),
                  backgroundImage: NetworkImage(items[index].imageUrl),
                ),
                LeaveSpaceWidget(6),
                //Section
                Text(
                  items[index].section,
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
                LeaveSpaceWidget(4),
                //Cloth
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: Text(
                    items[index].category,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      overflow: TextOverflow.clip,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
