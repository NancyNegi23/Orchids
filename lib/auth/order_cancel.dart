import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:orchids/constants.dart';

import '../screens/homescreen/homescreen.dart';
import '../services/firebase_services.dart';

class OrderCancelScreen extends StatefulWidget {
  final String? argument;
  const OrderCancelScreen({this.argument, super.key});
  static const String routeName = '/orderCancel-screen';
  @override
  State<OrderCancelScreen> createState() => _OrderCancelScreenState();
}

class _OrderCancelScreenState extends State<OrderCancelScreen> {
  final FirebaseService _services = FirebaseService();
  int _start = 30;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) => setState(() {
        if (_start == 0) {
          validate = false;
          setState(() {});
          timer.cancel();
          // Timer completed, do something
        } else {
          _start--;
        }
      }),
    );
  }

  bool validate = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 60,
          backgroundColor: kPrimaryColor,
          child: Text(
            '$_start',
            style: TextStyle(
                fontSize: 48, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 100,
        ),
        AbsorbPointer(
          absorbing: validate ? false : true,
          child: SizedBox(
            width: 200,
            child: ElevatedButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => (AlertDialog(
                            title: const Text(
                              'Do you want to cancel this order ? ',
                              style: TextStyle(fontSize: 16),
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    EasyLoading.show();
                                    _services.updateDocs(
                                        data: {
                                          'orderStatus': 'Cancel',
                                        },
                                        docName: widget.argument,
                                        reference:
                                            _services.orders).then((value) {
                                      EasyLoading.dismiss();
                                      Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        HomeScreen.routeName,
                                        (route) => false,
                                      );
                                    });
                                    EasyLoading.showSuccess(
                                        'Your Order is Cancelled');
                                  },
                                  child: const Text('Yes')),
                              TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('No')),
                            ],
                          )));
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: validate ? Colors.black : Colors.grey,
                    shape: RoundedRectangleBorder(),
                    minimumSize: Size(double.maxFinite, 48)),
                child: Text('Cancel Order')),
          ),
        ),
        SizedBox(
          height: 50,
        ),
        SizedBox(
          width: 200,
          child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  HomeScreen.routeName,
                  (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(),
                  minimumSize: Size(double.maxFinite, 48)),
              child: Text('Home Screen')),
        )
      ],
    ));
  }
}
