import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:geolocator/geolocator.dart';
import 'package:orchids/constants.dart';

import '../utils/get_location.dart';
import 'landing_screen.dart';
import 'login_view.dart';

class RegistrationScreen extends StatefulWidget {
  static const String routeName = '/regn-screen';
  final String phone;

  RegistrationScreen(this.phone);

  static const String id = 'Registration-Screen';

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  TextEditingController phoneController = mobNumController;
  TextEditingController locationController = TextEditingController();

  var address;
  double? latitude, longitude;
  // loaction.Location location = loaction.Location();
  late List<geo.Placemark> placemark;

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    locationController.dispose();
  }

  @override
  void initState() {
    getuserLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          elevation: 0,
          backgroundColor: kPrimaryColor,
          title: const Text('Registration '),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 8, 30, 8),
                child: Column(
                  children: [
                    FormField(
                        inputFormatter: LengthLimitingTextInputFormatter(50),
                        controller: nameController,
                        hintText: 'Name',
                        data: Icons.person,
                        type: TextInputType.name,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter Your Name';
                          }
                          return null;
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    FormField(
                        inputFormatter: LengthLimitingTextInputFormatter(10),
                        controller: phoneController,
                        hintText: 'Contact Number',
                        data: Icons.phone,
                        type: TextInputType.phone,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter Contact Name';
                          }
                          return null;
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    FormField(
                        inputFormatter: LengthLimitingTextInputFormatter(50),
                        controller: emailController,
                        hintText: 'Email',
                        data: Icons.email,
                        type: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter Email';
                          }
                          return null;
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 300,
                      height: 30,
                      alignment: Alignment.center,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          getuserLocation();
                        },
                        icon: const Icon(
                          Icons.location_on,
                          color: Colors.blue,
                        ),
                        label: const Text(
                          'Get My Location',
                          style: TextStyle(color: Colors.blue),
                        ),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    FormField(
                        inputFormatter: LengthLimitingTextInputFormatter(50),
                        enabled: false,
                        data: Icons.location_on,
                        controller: locationController,
                        hintText: 'Address',
                        type: TextInputType.name,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter Address';
                          }
                          return null;
                        }),
                  ],
                ),
              )
            ],
          ),
        ),
        persistentFooterButtons: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      onPressed: () {
                        formValidation();
                      },
                      style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).primaryColor,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
                          textStyle: const TextStyle(
                            fontSize: 18,
                          )),
                      child: const Text('Register')),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  void getuserLocation() async {
    Position? position = await determinePosition();
    getAddress(position.latitude, position.longitude);
    if (mounted) latitude = position.latitude;
    longitude = position.longitude;
    setState(() {});
  }

  Future<void> formValidation() async {
    if (_formKey.currentState!.validate()) {
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
                    color: Theme.of(context).primaryColor,
                    strokeWidth: 5,
                  ),
                ),
                SizedBox(width: 30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Please wait...',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
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

      //Save info to firestore

      await saveDataToFirestore();
      // Navigator.pop(context);
    } else {
      EasyLoading.showError('Please fill all the details');
    }
  }

  User? user = FirebaseAuth.instance.currentUser;

  Future saveDataToFirestore() async {
    FirebaseFirestore.instance.collection('users').doc(user!.uid).set({
      'userUid': user!.uid,
      'email': emailController.text.trim(),
      'name': nameController.text.trim(),
      'phone': phoneController.text.trim(),
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'accVerified': true,
      'location': GeoPoint(latitude!, longitude!),
      'createdAt': DateTime.now(),
      'walletBalance': 100
    }).then((value) {
      emailController.clear();
      nameController.clear();
      phoneController.clear();

      return Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) =>
              LandingScreen(mobNumController.text)));
    });
  }

  void getAddress(double latitude, double longitude) async {
    placemark = await placemarkFromCoordinates(latitude, longitude);
    setState(() {
      address = placemark[0].name.toString() +
          ", " +
          placemark[0].thoroughfare.toString() +
          ", " +
          placemark[0].subLocality.toString() +
          ", " +
          placemark[0].locality.toString() +
          "," +
          placemark[0].postalCode.toString();
      locationController.text = address;
    });
  }
}

class FormField extends StatelessWidget {
  bool? enabled = true;
  int? maxLines;
  String? phone;
  final TextInputFormatter inputFormatter;
  TextEditingController? controller;
  String? label;
  final String? hintText;
  TextInputType? type;
  final IconData? data;
  String? Function(String?)? validator;

  FormField(
      {this.enabled = true,
      this.maxLines,
      this.phone,
      required this.inputFormatter,
      this.controller,
      this.label,
      this.hintText,
      this.type,
      this.data,
      this.validator,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white70,
          border: Border.all(color: Colors.grey),
          borderRadius: const BorderRadius.all(Radius.circular(15))),
      padding: const EdgeInsets.only(left: 10),
      margin: const EdgeInsets.all(10),
      child: TextFormField(
        inputFormatters: [inputFormatter],
        enabled: enabled,
        maxLines: maxLines,
        controller: controller,
        keyboardType: type,
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(
            data,
            color: Colors.black54,
          ),
          focusColor: Theme.of(context).primaryColor,
          labelText: label,
          hintText: hintText,
        ),
        validator: validator,
      ),
    );
  }
}
