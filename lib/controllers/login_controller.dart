import 'dart:convert';

import 'package:cloud9/utils/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../pages/auth/login_page.dart';
import '../pages/auth/otp_page.dart';
import '../widgets/dialogs.dart';

class LoginController extends GetxController {
  TextEditingController phoneController = TextEditingController();

  Future<void> requestOtpLogin() async {
    try {
      var url = Api.baseUrl + Api.prefix + Api.endPoints.requestOtpLogin;

      Map body = {
        'phone': phoneController.text.trim(),
      };

      http.Response response = await Api().authData(body, url);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json['meta']['status'] == true) {
          final phone = phoneController.text.trim();

          phoneController.clear();
          Get.to(() => OTPPage(phone: phone, isLogin: true));
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

  void logout() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.clear();
    Get.offAll(() => const LoginPage());
  }
}
