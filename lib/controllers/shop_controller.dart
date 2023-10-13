import 'dart:convert';

import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

import '../models/shop.dart';
import '../utils/api.dart';

class ShopController extends GetxController {
  RxList<Shop> shopList = <Shop>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onReady() {
    fetchShops();
    super.onReady();
  }

  void fetchShops() async {
    isLoading(true);
    final url = Api.baseUrl + Api.prefix + Api.endPoints.shops;
    try {
      final http.Response response = await Api().getData(url);
      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = jsonDecode(response.body)['body'];
        final shops = jsonResponse.map((shop) => Shop.fromJson(shop)).toList();
        shopList.assignAll(
            shops); // add the fetched shops to shopList using spread operator
        shopList.refresh(); // notify listeners that the list has changed
      } else {
        throw Exception('Failed to fetch shops');
      }
    } catch (e) {
      print('Exception thrown when fetching rewards: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> openMap(double latitude, double longitude) async {
    final googleUrl = Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude');
    if (await canLaunchUrl(googleUrl)) {
      await launchUrl(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }

  bool isOpen(String openTime, String closeTime) {
    DateTime now = DateTime.now();
    int openHour = int.parse(openTime.split(':')[0]);
    int openMin = int.parse(openTime.split(':')[1]);
    int closeHour = int.parse(closeTime.split(':')[0]);
    int closeMin = int.parse(closeTime.split(':')[1]);
    if (now.hour > openHour &&
        now.minute > openMin &&
        now.hour < closeHour &&
        now.minute < closeMin) {
      return true;
    }
    return false;
  }
}
