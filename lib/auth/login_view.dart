import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:orchids/constants.dart';

import 'otp_screen.dart';

class LoginView extends StatefulWidget {
  static const String id = 'Login-screen';

  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

bool validate = false;
TextEditingController mobNumController = TextEditingController();

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              // if(!isKeyboard)
              Center(
                child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.25,
                    child: Image.asset(
                      'assets/images/login.png',
                      fit: BoxFit.contain,
                    )),
              ),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Enter your Phone number",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    const Text(
                      'We will send confirmation code to your phone',
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Card(
                      elevation: 5,
                      shadowColor: Colors.blue[300],
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(50),
                              topRight: Radius.circular(50),
                              topLeft: Radius.circular(50),
                              bottomLeft: Radius.circular(50))),
                      child: SizedBox(
                        height: 50,
                        child: TextFormField(
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(10)
                          ],
                          onChanged: (value) {
                            if (value.length == 10) {
                              setState(() {
                                validate = true;
                              });
                              FocusScope.of(context).unfocus();
                            }
                            if (value.length < 10) {
                              setState(() {
                                validate = false;
                              });
                            }
                          },
                          controller: mobNumController,
                          style: const TextStyle(fontSize: 18),
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            prefixText: '+91',
                            prefixIcon: Icon(
                              Icons.phone,
                              color: Colors.black,
                            ),
                            hintText: 'Type your phone Number',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    Center(
                        child: AbsorbPointer(
                            absorbing: validate ? false : true,
                            child: ElevatedButton(
                              child: const Text(
                                'Request OTP',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 18),
                              ),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        OTPScreen(mobNumController.text)));
                              },
                              style: ElevatedButton.styleFrom(
                                  fixedSize: const Size(220, 60),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50)),
                                  backgroundColor:
                                      validate ? kPrimaryColor : Colors.grey),
                            )))
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'By clicking, I accept the',
                    style: TextStyle(fontSize: 10),
                  ),
                  TextButton(
                    child: Text(
                      'Terms & Conditions',
                      style: TextStyle(fontSize: 10),
                    ),
                    onPressed: () {
                      // final url = 'https://badidukkan.web.app/terms';
                      // openBrowerURL(url: url, inApp: false);
                    },
                  ),
                  Text(
                    '&',
                    style: TextStyle(fontSize: 10),
                  ),
                  TextButton(
                    child: Text(
                      'Privacy Policy',
                      style: TextStyle(fontSize: 10),
                    ),
                    onPressed: () {
                      // final url = 'https://badidukkan.web.app/privacy';
                      // openBrowerURL(url: url, inApp: false);
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
