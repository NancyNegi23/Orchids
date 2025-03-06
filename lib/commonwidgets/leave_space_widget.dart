import 'package:flutter/material.dart';

class LeaveSpaceWidget extends StatelessWidget {
  final double height;
  LeaveSpaceWidget(
    this.height, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
    );
  }
}
