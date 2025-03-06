import 'package:flutter/material.dart';

import '../../commonwidgets/leave_space_widget.dart';
import '../../modal/product_modal.dart';

class ProductDetailsCard extends StatelessWidget {
  const ProductDetailsCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.height * 0.4,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            greenSweatshirt.desc!,
            // style: const TextStyle(fontSize: 16),
          ),
          LeaveSpaceWidget(32),
          Row(
            children: [
              const Text(
                "Fit",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12.5,
                ),
              ),
              const SizedBox(width: 6),
              const Text("—"),
              const SizedBox(width: 6),
              Text(
                greenSweatshirt.fit!,
                style: const TextStyle(
                  fontSize: 12.5,
                ),
              ),
            ],
          ),
          LeaveSpaceWidget(14),
          Row(
            children: [
              const Text(
                "Composition",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12.5,
                ),
              ),
              const SizedBox(width: 6),
              const Text("—"),
              const SizedBox(width: 6),
              Text(
                greenSweatshirt.composition!,
                style: const TextStyle(
                  fontSize: 12.5,
                ),
              ),
            ],
          ),
          LeaveSpaceWidget(14),
          Row(
            children: [
              const Text(
                "Article Number",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12.5,
                ),
              ),
              const SizedBox(width: 6),
              const Text("—"),
              const SizedBox(width: 6),
              Text(
                greenSweatshirt.articleNumber!,
                style: const TextStyle(
                  fontSize: 12.5,
                ),
              ),
            ],
          ),
          LeaveSpaceWidget(24),
          Row(
            children: [
              const Text(
                "True to Size based on",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12.5,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                greenSweatshirt.reviews! + " reviews",
                style: const TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
          LeaveSpaceWidget(16),
          SizedBox(
            // height: 16,
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: Colors.grey.shade500,
                inactiveTrackColor: Colors.grey.shade500,
                trackShape: RectangularSliderTrackShape(),
                trackHeight: 2,
                thumbColor: Colors.black,
                thumbShape:
                    const RoundSliderThumbShape(enabledThumbRadius: 6.0),
                overlayShape: SliderComponentShape.noOverlay,
              ),
              child: Slider(
                min: 0,
                max: 100,
                divisions: 100,
                value: 56,
                onChanged: (value) {},
              ),
            ),
          ),
          LeaveSpaceWidget(2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "Small",
                style: TextStyle(
                  color: Colors.black45,
                  fontSize: 12.5,
                ),
              ),
              Text(
                "Spot on",
                style: TextStyle(
                  color: Colors.black45,
                  fontSize: 12.5,
                ),
              ),
              Text(
                "Large",
                style: TextStyle(
                  color: Colors.black45,
                  fontSize: 12.5,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
