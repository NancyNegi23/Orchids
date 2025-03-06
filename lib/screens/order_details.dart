import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:orchids/constants.dart';

import '../services/order_services.dart';

class OrderDetailScreen extends StatefulWidget {
  static const String routeName = '/delivery_order-screen';
  final DocumentSnapshot document;

  const OrderDetailScreen({required this.document, Key? key}) : super(key: key);

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  final OrderServices _orderServices = OrderServices();

  String orderStatusVal = '';

  @override
  Widget build(BuildContext context) {
    int currentStep = 0;

    if (widget.document['orderStatus'] == 'Ordered') {
      setState(() {
        currentStep = 0;
      });
    }
    if (widget.document['orderStatus'] == 'Packed') {
      setState(() {
        currentStep = 1;
      });
    }
    if (widget.document['orderStatus'] == 'Shipped') {
      setState(() {
        currentStep = 2;
      });
    }
    if (widget.document['orderStatus'] == 'Delivered') {
      setState(() {
        currentStep = 3;
      });
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: const BackButton(
          color: Colors.white,
        ),
        backgroundColor: kPrimaryColor,
        title: const Text('Order Details'),
      ),
      backgroundColor: Colors.white,
      body: StreamBuilder<QuerySnapshot>(
          stream: _orderServices.orders
              .where('orderId', isEqualTo: widget.document['orderId'])
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator(
                color: Color(0xFF70B224),
              ));
            }

            return Padding(
                padding: const EdgeInsets.all(4.0),
                child: ListView(
                  children: snapshot.data!.docs.map((DocumentSnapshot docu) {
                    Map<String, dynamic> data =
                        docu.data()! as Map<String, dynamic>;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // const SizedBox(height: 10),
                        ListTile(
                          horizontalTitleGap: 0,
                          leading: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 14,
                            child: _orderServices.statusIcon(docu),
                          ),
                          title: Text(
                            data['orderStatus'],
                            style: TextStyle(
                                fontSize: 12,
                                color: _orderServices.statusColor(docu),
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'On ${DateFormat().format(DateTime.parse(widget.document['createdAt']))}',
                                style: const TextStyle(fontSize: 12),
                              ),
                              Text(
                                'Payment type : ${widget.document['cod'] == true ? 'COD' : 'Paid Online'}',
                                style: const TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Center(
                          child: Text(
                            'Total Amount : ₹ ${widget.document['total'].toStringAsFixed(0)}',
                            style: const TextStyle(
                                fontSize: 13, fontWeight: FontWeight.bold),
                          ),
                        ),

                        SizedBox(
                          height: 16,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black12,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  return ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      child: Image.network(
                                          widget.document['products'][index]
                                              ['productImage']),
                                    ),
                                    title: Text(widget.document['products']
                                        [index]['productName']),
                                    subtitle: Text(
                                      widget.document['products'][index]
                                          ['size'],
                                    ),
                                    trailing: Text(
                                      '${widget.document['products'][index]['qty']} x ${widget.document['products'][index]['price'].toStringAsFixed(0)} = ${widget.document['products'][index]['total'].toStringAsFixed(0)}',
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 14),
                                    ),
                                  );
                                },
                                itemCount: widget.document['products'].length,
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 5),
                        const Text(
                          'Tracking',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black12,
                            ),
                          ),
                          child: Stepper(
                            currentStep: currentStep,
                            controlsBuilder: (context, details) {
                              return const SizedBox();
                            },
                            steps: [
                              Step(
                                title: const Text('Ordered'),
                                content: const Text(
                                  'Your order is yet to be Packed',
                                ),
                                isActive: currentStep > 0,
                                state: currentStep > 0
                                    ? StepState.complete
                                    : StepState.indexed,
                              ),
                              Step(
                                title: const Text('Packed'),
                                content: Text(
                                  'Your Order is Packed',
                                  style: TextStyle(fontSize: 13),
                                ),
                                isActive: currentStep > 1,
                                state: currentStep > 1
                                    ? StepState.complete
                                    : StepState.indexed,
                              ),
                              Step(
                                title: const Text('Shipped'),
                                content: const Text(
                                  'Your Order is Shipped',
                                  style: TextStyle(fontSize: 13),
                                ),
                                isActive: currentStep > 2,
                                state: currentStep > 2
                                    ? StepState.complete
                                    : StepState.indexed,
                              ),
                              Step(
                                title: const Text('Delivered'),
                                content: Text(
                                  'Your Order is Delivered',
                                  style: TextStyle(fontSize: 13),
                                ),
                                isActive: currentStep >= 3,
                                state: currentStep >= 3
                                    ? StepState.complete
                                    : StepState.indexed,
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ));
          }),
    );
  }
}
