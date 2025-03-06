import 'package:flutter/material.dart';
import 'package:orchids/screens/homescreen/homescreen.dart';

class DeliveryOrder extends StatelessWidget {
  static const String routeName = '/delivery-order';

  const DeliveryOrder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Order  Placed'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 80,
          ),
          // Image.asset(
          //   'images/flower.gif',
          //   height: 350,
          //   fit: BoxFit.cover,
          // ),
          const SizedBox(
            height: 40,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: const Center(
              child: Text(
                  'Your Order has been placed\n           successfully! ',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20)),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            child: const Text('Home '),
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, HomeScreen.routeName, (route) => false);
            },
            style: ElevatedButton.styleFrom(
                fixedSize: const Size(200, 50),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                primary: const Color(0xFF70B224)),
          )
        ],
      ),
    );
  }
}
