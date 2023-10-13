import 'dart:convert';

import 'package:cloud9/dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../widgets/dialogs.dart';

class OTPController extends GetxController {
  TextEditingController otpController = TextEditingController();
  final Future<SharedPreferences> _localStorage =
      SharedPreferences.getInstance();

  var otp = ''.obs;

  increment(v) => otp.value += v;
  decrement() {
    otp.value = otp.value.substring(0, otp.value.length - 1);
  }

  Future<void> loginWithOTP(String phone, bool isLogin) async {
    try {
      var url = isLogin
          ? Api.baseUrl + Api.prefix + Api.endPoints.login
          : Api.baseUrl + Api.prefix + Api.endPoints.register;

      Map body = {
        'phone': phone,
        'code': otp.value,
      };

      http.Response response = await Api().authData(body, url);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json['meta']['status'] == true) {
          final currentUser = json['body'];
          final token = json['body']['token'];
          final SharedPreferences localStorage = await _localStorage;
          localStorage.setString('token', token);
          localStorage.setString('currentUser', jsonEncode(currentUser));

          otpController.clear();
          Get.offAll(() => Dashboard());
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
