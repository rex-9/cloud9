import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Api {
  static const String baseUrl = 'https://point.cityhr.com.mm';
  static const String prefix = '/api/v1';
  static final _EndPoints endPoints = _EndPoints();
  late String token = '';

  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    token = localStorage.getString('token')!;
  }

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

  getData(url) async {
    await _getToken();
    return await http.get(Uri.parse(url), headers: _setHeaders());
  }

  postData(url, body) async {
    await _getToken();
    final result = await http.post(
      Uri.parse(url),
      body: body,
      headers: _setHeaders(),
    );
    return result;
  }

  deleteData(url) async {
    await _getToken();
    return await http.delete(Uri.parse(url), headers: _setHeaders());
  }

  authData(data, url) async {
    return await http.post(
      Uri.parse(url),
      body: jsonEncode(data),
      headers: _setHeaders(),
    );
  }
}

class _EndPoints {
  final String requestOtpRegister = '/customer/requestOtpRegister';
  final String register = '/customer/store';
  final String requestOtpLogin = '/customer/requestOtpLogin';
  final String login = '/customer/loginWithOtp';
  final String shops = '/shop';
  final String rewards = '/reward';
  final String me = '/me';
  final String myReward = '/my-reward-list';
  final String exchangeReward = '/exchange-reward';
  // final String withdrawReward = '/withdraw-reward';
  final String scan = '/scan-product-qr';
  final String histories = '/histories';
  final String rewardDetail = '/reward/detail';
}
