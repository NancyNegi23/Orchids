import 'package:flutter/material.dart';

import '../../commonwidgets/leave_space_widget.dart';
import '../sectionscreen/section_screen.dart';

//Widget with various scetions name and navigation
class SectionsList extends StatelessWidget {
  SectionsList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 8,
      itemBuilder: (BuildContext context, int index) {
        final List items = [
          "Ladies",
          "Men",
          "Kids",
          "Baby",
          "Divided",
          "H&M HOME",
          "Sale",
          "Sustainability"
        ];
        return InkWell(
          onTap: () {
            Navigator.pushNamed(context, SectionScreen.routeName);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 11),
            child: Center(
              child: Text(
                items[index],
                style: const TextStyle(
                  letterSpacing: 1.5,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
