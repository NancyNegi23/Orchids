// ignore_for_file: prefer_const_constructors
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'leave_space_widget.dart';

// Widget with image as background and text at bottom
class RecommendedItem extends StatelessWidget {
  final String bgImageUrl;
  final String title;
  final String desc;
  RecommendedItem({
    Key? key,
    required this.bgImageUrl,
    required this.title,
    required this.desc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: InkWell(
        onTap: () {},
        child: Stack(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: CachedNetworkImage(
                imageUrl: bgImageUrl,
                fit: BoxFit.cover,
              ),
            ),
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                width: double.maxFinite,
                height: double.maxFinite,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Colors.black.withOpacity(0.4),
                    Colors.white.withOpacity(0)
                  ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
                ),
              ),
            ),
            Positioned(
              width: MediaQuery.of(context).size.width - 32,
              bottom: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      LeaveSpaceWidget(8),
                      Text(
                        desc,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      LeaveSpaceWidget(12),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
