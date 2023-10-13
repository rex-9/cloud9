import 'dart:convert';

import 'package:cloud9/utils/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../pages/auth/otp_page.dart';
import '../widgets/dialogs.dart';

class RegisterController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  Future<void> requestOtpRegister() async {
    try {
      var url = Api.baseUrl + Api.prefix + Api.endPoints.requestOtpRegister;

      Map body = {
        'name': nameController.text,
        'phone': phoneController.text.trim(),
        'email': emailController.text.trim(),
      };

      http.Response response = await Api().authData(body, url);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json['meta']['status'] == true) {
          final phone = json['body']['phone'];

          nameController.clear();
          phoneController.clear();
          emailController.clear();
          Get.to(() => OTPPage(phone: phone, isLogin: false));
        } else {
          throw jsonDecode(response.body)['meta']['message'] ?? "Unknown Error";
        }
      } else {
        throw jsonDecode(response.body)['meta']['message'] ?? "Unknown Error";
      }
    } catch (e) {
      errorDialog(e);
    }
  }
}
