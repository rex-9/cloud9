import 'dart:convert';

import 'package:get/get.dart';

import 'package:cloud9/models/exchange.dart';
import 'package:http/http.dart' as http;

import '../utils/api.dart';

class ExchangeController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<Exchange> myRewardList = <Exchange>[].obs;

  @override
  void onReady() {
    fetchExchanges();
    super.onReady();
  }

  void fetchExchanges() async {
    isLoading(true);
    final url = Api.baseUrl + Api.prefix + Api.endPoints.myReward;
    final http.Response response = await Api().getData(url);
    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = jsonDecode(response.body)['body'];
      final myRewards =
          jsonResponse.map((myReward) => Exchange.fromJson(myReward)).toList();

      myRewardList.assignAll(
          myRewards); // add the fetched rewards to rewardList using spread operator
      myRewardList.refresh(); // notify listeners that the list has changed
      isLoading(false);
    } else {
      throw Exception('Failed to fetch My Rewards');
    }
  }
}
