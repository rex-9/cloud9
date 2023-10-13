import 'package:cloud9/controllers/otp_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/dialogs.dart';

class OTPPage extends StatefulWidget {
  final String phone;
  final bool isLogin;
  const OTPPage({super.key, required this.phone, required this.isLogin});

  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  OTPController otpController = OTPController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(
                child: Column(
                  children: [
                    Image(
                      image: AssetImage('assets/images/logo.png'),
                      height: 75,
                    ),
                    SizedBox(height: 25),
                    Text(
                      'Welcome Back',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      "Let's make your home be smart \n easily with us",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _textFieldOTP(),
                        _textFieldOTP(),
                        _textFieldOTP(),
                        _textFieldOTP(),
                        _textFieldOTP(),
                        _textFieldOTP(),
                      ],
                    ),
                    TextButton(
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Text(
                            'Confirm',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      onPressed: () {
                        if (otpController.otp.value.length < 6) {
                          errorDialog(
                              'Enter 6 digit code. ${otpController.otp.value}');
                        } else {
                          otpController.loginWithOTP(
                            widget.phone,
                            widget.isLogin,
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
              TextButton.icon(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.arrow_left),
                label: const Text("Go Back"),
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.white),
                  iconColor: MaterialStatePropertyAll(Colors.black),
                  foregroundColor: MaterialStatePropertyAll(Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _textFieldOTP() {
    return SizedBox(
      height: 85,
      child: AspectRatio(
        aspectRatio: 0.6,
        child: TextFormField(
          autofocus: true,
          onChanged: (value) {
            if (value.length == 1) {
              otpController.increment(value);
              FocusScope.of(context).nextFocus();
            }
            if (value.isEmpty) {
              otpController.decrement();
              FocusScope.of(context).previousFocus();
            }
          },
          showCursor: false,
          readOnly: false,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            counter: const Offstage(),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 2,
                  color: Colors.black12,
                ),
                borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 2,
                color: Theme.of(context).primaryColor,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    );
  }
}
