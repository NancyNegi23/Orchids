import 'package:flutter/material.dart';

import '../../commonwidgets/item_slider.dart';
import '../../commonwidgets/leave_space_widget.dart';
import '../../constants.dart';

class NewArrivalsWidget extends StatelessWidget {
  const NewArrivalsWidget({
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
            "New Arrivals",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        NewArrivalsTabBar(),
        LeaveSpaceWidget(8),
        ItemsThumbnailSlider(items: newArrivals),
      ],
    );
  }
}

class NewArrivalsTabBar extends StatefulWidget {
  NewArrivalsTabBar({
    Key? key,
  }) : super(key: key);

  @override
  State<NewArrivalsTabBar> createState() => _NewArrivalsTabBarState();
}

class _NewArrivalsTabBarState extends State<NewArrivalsTabBar> {
  final List items = ["Ladies", "Men", "Divided", "Kids", "Baby", "H&M HOME"];
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.only(
              top: 10,
              bottom: 10,
              left: (index == 0) ? 12 : 8,
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  foregroundColor:
                      (index == _index) ? Colors.white : Colors.black,
                  minimumSize: const Size(0, 0),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  elevation: 4,
                  backgroundColor:
                      (index == _index) ? Colors.red : Colors.white,
                  shape: (index == _index)
                      ? RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        )
                      : RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: const BorderSide(color: Colors.black),
                        )),
              onPressed: () {
                setState(() {
                  _index = index;
                });
              },
              child: Text(
                items[index],
                style: const TextStyle(fontSize: 12, letterSpacing: 0.5),
              ),
            ),
          );
        },
      ),
    );
  }
}
