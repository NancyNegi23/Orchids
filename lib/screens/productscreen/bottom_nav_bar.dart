import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:orchids/provider/cart_provider.dart';
import 'package:provider/provider.dart';

import '../../commonwidgets/leave_space_widget.dart';
import '../cart/widgets/counter_for_cart.dart';

class ProductSize {
  final String size;
  final bool isAvailable;
  final bool fewPiecesLeft;
  ProductSize({
    required this.size,
    required this.isAvailable,
    required this.fewPiecesLeft,
  });
}

String? selectedSize;
List sizes = [
  ProductSize(size: "XS", fewPiecesLeft: false, isAvailable: true),
  ProductSize(size: "S", fewPiecesLeft: false, isAvailable: true),
  ProductSize(size: "M", fewPiecesLeft: false, isAvailable: true),
  ProductSize(size: "L", fewPiecesLeft: false, isAvailable: true),
  ProductSize(size: "XL", fewPiecesLeft: false, isAvailable: true),
  ProductSize(size: "XXL", fewPiecesLeft: false, isAvailable: true),
];

class BottomNavBar extends StatefulWidget {
  DocumentSnapshot? documnets;
  BottomNavBar({
    this.documnets,
    Key? key,
  }) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 2,
        )
      ]),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                      return const SizePopUp();
                    });
                  });
            },
            child: Container(
              width: MediaQuery.of(context).size.width / 2 - 22,
              height: 44,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Consumer<CartProvider>(
                  builder: (context, selectedValueProvider, _) {
                    return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            selectedValueProvider.selectedValue == 'Y'
                                ? 'Select Size'
                                : selectedValueProvider.selectedValue,
                            style:
                                TextStyle(color: Colors.black54, fontSize: 12),
                          ),
                          Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.black54,
                          )
                        ]);
                  },
                ),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 2 - 22,
            height: 44,
            decoration: const BoxDecoration(
                // color: Colors.black,
                ),
            child: CounterForCard(
              document: widget.documnets!,
            ),
          )
        ],
      ),
    );
  }
}

class SizePopUp extends StatefulWidget {
  const SizePopUp({
    Key? key,
  }) : super(key: key);

  @override
  State<SizePopUp> createState() => _SizePopUpState();
}

class _SizePopUpState extends State<SizePopUp> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Padding(
          padding:
              const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Select size",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              LeaveSpaceWidget(4),
              Divider(
                color: Colors.grey.shade400,
              ),
              ...List.generate(
                sizes.length,
                (index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  child: GestureDetector(
                    onTap: () {
                      Provider.of<CartProvider>(context, listen: false)
                          .setSelectedValue(sizes[index].size);

                      Navigator.pop(context);
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          sizes[index].size,
                          style: const TextStyle(fontSize: 16),
                        ),
                        sizes[index].isAvailable
                            ? sizes[index].fewPiecesLeft
                                ? Text(
                                    "Few Pieces Left",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.red.shade600),
                                  )
                                : const SizedBox()
                            : Row(
                                children: const [
                                  Icon(
                                    Icons.mail_outline,
                                    size: 20,
                                  ),
                                  SizedBox(width: 4),
                                  Text("Notify Me")
                                ],
                              )
                      ],
                    ),
                  ),
                ),
              ),
              Divider(
                color: Colors.grey.shade500,
              ),
            ],
          ),
        )
      ],
    );
  }
}
