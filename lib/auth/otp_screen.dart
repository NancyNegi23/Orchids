import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:orchids/constants.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'landing_screen.dart';
import 'login_view.dart';

class OTPScreen extends StatefulWidget {
  final String phone;

  OTPScreen(this.phone);

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  String _verificationCode = '';
  final TextEditingController _pinPutController = TextEditingController();
  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(5.0),
    border: Border.all(color: const Color(0xFFA4DE02)),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldkey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text('OTP Verification'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Center(
              child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.26,
                  child: Image.asset(
                    'assets/images/otp.png',
                    fit: BoxFit.contain,
                  )),
            ),
            const Text(
              " Enter your OTP",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: RichText(
                    text: TextSpan(
                        text:
                            'We have sent a 6- Digit code to verification to your -',
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 16),
                        children: [
                          TextSpan(
                              text: '+91-${widget.phone}',
                              style: const TextStyle(
                                  color: Color(0xFF70B224),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold)),
                          // InkWell(onTap: (){},child: Text('Hi'),)
                        ]),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                            height: 30,
                            width: 30,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFF70B224),
                            ),
                            child: const Icon(
                              Icons.edit,
                              color: Colors.white,
                            )))),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: PinCodeTextField(
                controller: _pinPutController,
                appContext: context,
                length: 6,
                keyboardType: TextInputType.number,
                textStyle: TextStyle(color: Colors.black),
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  activeColor: Color(0xFF70B224),
                  borderRadius: BorderRadius.circular(8),
                  errorBorderColor: Colors.red,
                  fieldHeight: 40,
                  fieldWidth: 40,
                  inactiveColor: Color(0xffE0E0E0),
                  disabledColor: Color(0xffE0E0E0),
                  selectedColor: Color(0xFF70B224),
                  activeFillColor: Colors.white,
                  inactiveFillColor: Colors.white,
                  selectedFillColor: Colors.white,
                ),
                enableActiveFill: true,
                onChanged: (v) {
                  v = _pinPutController.text;
                },
                // onCompleted: (v) {
                //         _pinPutController.text = v;
                //         setState(() {});
                //       },
                //       onChanged: (v) {
                //         _pinPutController.text = v;
                //         setState(() {});
                //       },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Center(
                  child: ElevatedButton(
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

                      try {
                        await FirebaseAuth.instance
                            .signInWithCredential(PhoneAuthProvider.credential(
                                verificationId: _verificationCode,
                                smsCode: _pinPutController.text))
                            .then((value) async {
                          if (value.user != null) {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        LandingScreen(mobNumController.text)),
                                (route) => false).then((value) => {});
                          }
                        });
                      } catch (e) {
                        FocusScope.of(context).unfocus();
                        Fluttertoast.showToast(msg: 'Invalid OTP');

                        Navigator.pop(context);
                      }
                    },
                    child: Text(
                      'Done',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                    ),
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(180, 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        backgroundColor: kPrimaryColor),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> _verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91${widget.phone}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          FirebaseFirestore.instance.collection("otpError").doc().set({
            'error': e.toString(),
            'createdAt': DateTime.now(),
            'mobileNumber': widget.phone
          });

          EasyLoading.showError(e.toString());
        },
        codeSent: (String verficationID, int? resendToken) {
          setState(() {
            _verificationCode = verficationID;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          if (mounted) {
            setState(() {
              _verificationCode = verificationID;
            });
          }
        },
        timeout: const Duration(seconds: 60));
  }

  @override
  void initState() {
    _verifyPhone();
    super.initState();
  }
}
