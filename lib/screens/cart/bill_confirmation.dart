import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../../services/cart_services.dart';
import '../../../utils/razorpay_credentials.dart';
import '../../auth/order_cancel.dart';
import '../../constants.dart';
import '../../provider/auth_provider.dart';
import '../../provider/cart_provider.dart';
import '../../services/order_services.dart';

enum paymentOption { cod, online }

final now = DateTime.now();
String time = DateFormat('dd-MM-yyyy').format(now);

class BillingConfrimation extends StatefulWidget {
  DocumentSnapshot? document;

  num? totalAmount;

  BillingConfrimation({
    Key? key,
    this.document,
    required this.totalAmount,
  }) : super(key: key);

  @override
  State<BillingConfrimation> createState() => _BillingConfrimationState();
}

class _BillingConfrimationState extends State<BillingConfrimation> {
  final CartServices _cartServices = CartServices();

  User? user = FirebaseAuth.instance.currentUser;

  var textStyle = const TextStyle(color: Colors.grey);
  final OrderServices _orderServices = OrderServices();

  double discount = 0;

  int offUpto = 0;
  int preOrderProcessingFee = 2;
  DocumentSnapshot? doc;

  paymentOption _payment = paymentOption.online;
  @override
  void initState() {
    _razorpay = Razorpay();
    _razorpay!.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay!.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay!.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay!.clear();
  }

  num finalAmountPayable = 0;

  @override
  Widget build(BuildContext context) {
    var _cartProvider = Provider.of<CartProvider>(context);
    var userDetails = Provider.of<AuthProvider>(context);
    userDetails.getUserDetails();
    var _payable = (widget.totalAmount!);

    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        persistentFooterButtons: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16),
            child: Column(children: [
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          fixedSize: const Size(190, 42),
                          backgroundColor: kPrimaryColor),
                      onPressed: () async {
                        final alert = AlertDialog(
                          content: WillPopScope(
                            onWillPop: () async => false,
                            child: Container(
                              padding: EdgeInsets.all(20),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    width: 40,
                                    height: 40,
                                    child: CircularProgressIndicator(
                                      color: kPrimaryColor,
                                      strokeWidth: 5,
                                    ),
                                  ),
                                  SizedBox(width: 30),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Please wait...',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: kPrimaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                        await _cartProvider.totalAmount(
                            _payable, userDetails.snapshot!['email']);
                        if (_cartProvider.cod == false) {
                          _cartProvider.totalAmount(
                              _payable, userDetails.snapshot!['email']);

                          createOrder(_cartProvider);
                        } else {
                          _saveOrder(_cartProvider, _payable, userDetails);
                        }

                        /////////////////////////////////Online Payment/////////////////////////////////////////////////
                      },
                      child: const Text(
                        'Order now ',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
            ]),
          ),
        ],
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          elevation: 0,
          title: Text('Choose Payment Options'),
          leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              'Total Price',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '(Delivery Fee also included)',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                          ],
                        ),
                        Text(
                          ' ₹ ${widget.totalAmount!.toStringAsFixed(0)}',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Balance Payable',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '₹ ${widget.totalAmount}',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.grey.shade300,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Choose a Payment Options',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _payment = paymentOption.online;
                    _cartProvider.getPaymentMethod(0);
                  });
                },
                child: ListTile(
                  tileColor: Colors.grey.shade100,
                  title: Text(
                    'Online',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  leading: Radio(
                    activeColor: kPrimaryColor,
                    value: paymentOption.online,
                    groupValue: _payment,
                    onChanged: (paymentOption? val) {
                      setState(() {
                        _payment = val!;
                        _cartProvider.getPaymentMethod(0);
                      });
                    },
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _payment = paymentOption.cod;
                    _cartProvider.getPaymentMethod(1);
                  });
                },
                child: ListTile(
                  tileColor: Colors.grey.shade100,
                  title: Text(
                    'Pay On Delivery',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  leading: Radio(
                    activeColor: kPrimaryColor,
                    value: paymentOption.cod,
                    groupValue: _payment,
                    onChanged: (paymentOption? val) {
                      setState(() {
                        _payment = val!;
                        _cartProvider.getPaymentMethod(1);
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //Razor Pay Starts/////////////////////////////////////////
  //
  /////////////////////////////

  Razorpay? _razorpay;

  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) {
    var _cartProvider = Provider.of<CartProvider>(context, listen: false);
    var userDetails = Provider.of<AuthProvider>(context, listen: false);

    var _payable = widget.totalAmount;

    return _saveOrder(
      _cartProvider,
      _payable,
      userDetails,
    );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    EasyLoading.showError('Payment Failed');

    Navigator.pop(context);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    EasyLoading.showError(
      response.walletName!,
    );
    Navigator.pop(context);
  }

  // create order
  void createOrder(CartProvider _cartProvider) async {
    final HttpsCallable callable =
        FirebaseFunctions.instance.httpsCallable('myRazorPayFunction');

    final HttpsCallableResult result = await callable.call(<String, dynamic>{
      'amount': '${_cartProvider.amount}00',
    });
    // print(result);
    final Map<String, dynamic> data = result.data;

    openCheckout(_cartProvider, data['id']);
  }

  Future<void> openCheckout(CartProvider _cartProvider, String orderId) async {
    var options = {
      'key': razorpay_credentails.keyId,
      // 'amount': '100',
      'amount': '${_cartProvider.amount}00',
      'name': 'BadiDukkan',
      "order_id": orderId,
      'retry': {'enabled': true, 'max_count': 4},
      'send_sms_hash': true,
      'prefill': {'contact': user!.phoneNumber, 'email': _cartProvider.email},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay!.open(options);
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      FirebaseFirestore.instance.collection("RazorPaylog").doc().set({
        'error': e.toString(),
        'createdAt': DateTime.now(),
        'userId': user!.uid,
      });

      debugPrint('Error: e');
    }
  }
  //////////////////////   RazorPay Ends   //////////////////////////////////////////////////////////////////////////////////////////////

  Future _saveOrder(
      CartProvider cartProvider, payable, AuthProvider userDetails) async {
    var rng = Random();
    var orderId = rng.nextInt(900000) + 100000;

    try {
      final result = _orderServices.saveOrder({
        'products': cartProvider.cartList,
        'userId': user!.uid,
        'userName': userDetails.snapshot!['name'],
        'orderId': orderId,
        'deliveryFee': 'FreeDelivery',
        'total': payable,
        'discount': discount.toStringAsFixed(0),
        'cod': cartProvider.cod,
        'createdAt': DateTime.now().toString(),
        'date': time,
        'orderStatus': 'Ordered',
        'riderLocation': '',
        'deliveryBoy': {
          'riderUid': '',
          'name': '',
          'phone': '',
          'location': '',
          'image': '',
          'email': '',
        },
      }).then((value) {
        // print('Aman Dwviedi');
        // print(value);
        // print(value.id);

        _cartServices.deleteCart().then((value1) {
          _cartServices.checkData().then((value2) {
            EasyLoading.showSuccess('Your Order is placed');

            setState(() {
              discount = 0;
              cartProvider.paymentStatus(1);
              cartProvider.getPaymentMethod(0);
            });

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => OrderCancelScreen(argument: value.id),
              ),
            );
          }).catchError((e) {
            FirebaseFirestore.instance.collection("log").doc().set({
              'error': e.toString(),
              'createdAt': DateTime.now(),
              'shopName': widget.document!['shopName'],
              'products': cartProvider.cartList,
              'userId': user!.uid,
              'userName': userDetails.snapshot!['Name'],
            });
          });
        });
      });
    } catch (e) {
      FirebaseFirestore.instance.collection("log").doc().set({
        'error': e.toString(),
        'createdAt': DateTime.now(),
        'products': cartProvider.cartList,
        'userId': user!.uid,
        'userName': userDetails.snapshot!['name'],
      });
    }
  }
}
