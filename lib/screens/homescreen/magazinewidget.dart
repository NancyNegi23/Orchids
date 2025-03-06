import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../commonwidgets/leave_space_widget.dart';

String magazineImageUrl1 =
    "https://lp2.hm.com/hmgoepprod?source=url[https://www2.hm.com/content/dam/h-m-magazine-2022/october_2022/adam/adam/Magazine-HM-Move-1-Top-image-1688x1126.jpg]&scale=size[1200]&sink=format[jpeg],quality[80]";
String magazineImageUrl2 =
    "https://lp2.hm.com/hmgoepprod?source=url[https://www2.hm.com/content/dam/h-m-magazine-2022/october_2022/4056/4056-1688x1126-Top-image.jpg]&scale=size[1200]&sink=format[jpeg],quality[80]";
String magazineImageUrl3 =
    "https://lp2.hm.com/hmgoepprod?set=width[1280],quality[80],options[limit]&source=url[https://www2.hm.com/content/dam/h-m-magazine-2022/august_2022/1046/1046A-01-Magazine.jpg]&scale=width[global.width],height[15000],options[global.options]&sink=format[jpg],quality[global.quality]";

class MagazineWidget extends StatelessWidget {
  const MagazineWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xfff4ecdc),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        children: [
          LeaveSpaceWidget(8),
          const Text(
            "MAGAZINE",
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          LeaveSpaceWidget(4),
          const Text(
            "A WORLD OF INSPIRATION",
            style: TextStyle(fontSize: 12),
          ),
          LeaveSpaceWidget(16),
          Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 2.0, color: Colors.black),
                ),
              ),
              child: const Text(
                "READ Orchids MAGAZINE",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              )),
          LeaveSpaceWidget(16),
          MagazineItem(
            imageUrl: magazineImageUrl1,
            desc: "Orchids Move teams up with Zlatan Ibrahimović",
          ),
          LeaveSpaceWidget(16),
          MagazineItem(
            imageUrl: magazineImageUrl2,
            desc: "Imagine that: Kids' Innovation Story",
          ),
          LeaveSpaceWidget(16),
          MagazineItem(
            imageUrl: magazineImageUrl3,
            desc: "Take a seat at Brasserie Hennes",
          ),
          LeaveSpaceWidget(20),
        ],
      ),
    );
  }
}

class MagazineItem extends StatelessWidget {
  final String imageUrl;

  final String desc;
  const MagazineItem({
    Key? key,
    required this.imageUrl,
    required this.desc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 1.5,
            child: CachedNetworkImage(imageUrl: imageUrl),
          ),
          LeaveSpaceWidget(12),
          const Text(
            "INSIDE Orchids",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          LeaveSpaceWidget(2),
          Text(desc),
          LeaveSpaceWidget(12),
        ],
      ),
    );
  }
}
