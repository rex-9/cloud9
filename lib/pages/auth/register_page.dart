import 'package:cloud9/controllers/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../utils/constants.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  RegisterController registerController = RegisterController();

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
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
                    TextFormField(
                      controller: registerController.nameController,
                      validator: (value) =>
                          value!.length < 3 ? 'Minimum of 3 digits!' : null,
                      decoration: inputDecoration.copyWith(
                        label: const Text('Full Name'),
                        hintText: 'e.g. Mg Phyu',
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: registerController.phoneController,
                      validator: (value) =>
                          value!.isEmpty ? 'Enter Phone Number!' : null,
                      decoration: inputDecoration.copyWith(
                        label: const Text('Phone Number'),
                        hintText: 'e.g. 09443221151',
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: registerController.emailController,
                      // validator: (value) => value!.isEmpty ||
                      //         !EmailValidator.validate(value.trim(), true)
                      //     ? 'Enter a valid Email!'
                      //     : null,
                      decoration: inputDecoration.copyWith(
                        label: const Text('Email'),
                        hintText: 'e.g. john@example.com (optional)',
                      ),
                    ),
                    const SizedBox(height: 20),
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
                            'Register',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          registerController.requestOtpRegister();
                        }
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    "Already have an account?",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  TextButton(
                    child: Text(
                      "Log in here!",
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    onPressed: () {
                      Get.to(() => const LoginPage());
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
