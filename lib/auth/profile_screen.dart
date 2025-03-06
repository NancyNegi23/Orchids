import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:orchids/constants.dart';
import 'package:orchids/screens/my_order.dart';
import 'package:provider/provider.dart';

import '../commonwidgets/leave_space_widget.dart';
import '../provider/auth_provider.dart';
import 'login_screen.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var userDetails = Provider.of<AuthProvider>(context);
    userDetails.getUserDetails();
    return Scaffold(
      body: userDetails.snapshot == null
          ? Center(child: CircularProgressIndicator())
          : SafeArea(
              child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LeaveSpaceWidget(32),
                    Center(
                        child: CircleAvatar(
                            backgroundColor: kPrimaryColor,
                            child: Text(
                              '${userDetails.snapshot!['name'][0]}',
                              style: const TextStyle(
                                  fontSize: 50, color: Colors.white),
                            ),
                            radius: 44)),
                    LeaveSpaceWidget(32),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyOrders()));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black45),
                            borderRadius: BorderRadius.circular(8)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 10),
                          child: Row(
                            children: [
                              Icon(Icons.shopping_cart_outlined),
                              SizedBox(width: 8),
                              Text("Your Orders"),
                            ],
                          ),
                        ),
                      ),
                    ),
                    LeaveSpaceWidget(32),
                    const Text("Name"),
                    LeaveSpaceWidget(12),
                    OutlinedTextfield(
                      controller: userDetails.snapshot!['name'],
                    ),
                    LeaveSpaceWidget(32),
                    Text("Phone No."),
                    LeaveSpaceWidget(12),
                    OutlinedTextfield(
                        controller: userDetails.snapshot!['phone']),
                    LeaveSpaceWidget(32),
                    const Text("Address"),
                    LeaveSpaceWidget(12),
                    TextField(
                      maxLines: 2,
                      canRequestFocus: false,
                      readOnly: true,
                      controller: TextEditingController(
                          text: userDetails.snapshot!['address']),
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 10),
                        // constraints: BoxConstraints(maxHeight: 40)
                      ),
                    ),
                    LeaveSpaceWidget(32),
                    InkWell(
                      onTap: () {
                        FirebaseAuth.instance.signOut().then((value) {
                          Navigator.pushNamedAndRemoveUntil(
                              context, LoginScreen.routeName, (route) => false);
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          'LogOut',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )),
    );
  }
}

class OutlinedTextfield extends StatelessWidget {
  final String? controller;
  bool? isaddress;
  OutlinedTextfield({
    this.isaddress,
    required this.controller,
    super.key,
    this.textAlign = TextAlign.start,
  });
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return TextField(
      canRequestFocus: false,
      readOnly: true,
      controller: TextEditingController(
        text: controller!,
      ),
      textAlign: textAlign,
      decoration: InputDecoration(
          border: const OutlineInputBorder(),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          constraints: BoxConstraints(maxHeight: 40)),
    );
  }
}
