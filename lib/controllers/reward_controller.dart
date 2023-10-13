import 'dart:convert';

import 'package:cloud9/controllers/history_controller.dart';
import 'package:cloud9/models/reward.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../utils/api.dart';
import '../widgets/dialogs.dart';
import 'dashboard_controller.dart';
import 'exchange_controller.dart';

class RewardController extends GetxController {
  RxList<Reward> rewardList = <Reward>[].obs;
  Rx<Reward> reward = Reward(
    id: 0,
    image: '',
    title: '',
    quantity: 0,
    point: 0,
    value: 0,
    status: '',
    type: '',
  ).obs;

  RxBool isLoading = false.obs;
  RxBool isScanned = false.obs;

  final DashboardController dashboardController = Get.put(
    DashboardController(),
    permanent: false,
  );

  final ExchangeController exchangeController = Get.put(ExchangeController());

  final HistoryController historyController = Get.put(HistoryController());

  final HomeNavController homeNavController = Get.put(HomeNavController());

  @override
  void onReady() {
    fetchRewards();
    super.onReady();
  }

  void fetchRewards() async {
    isLoading(true);
    final url = Api.baseUrl + Api.prefix + Api.endPoints.rewards;
    try {
      final http.Response response = await Api().getData(url);
      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = jsonDecode(response.body)['body'];
        final rewards =
            jsonResponse.map((reward) => Reward.fromJson(reward)).toList();
        rewardList.assignAll(
          rewards,
        ); // add the fetched rewards to rewardList using spread operator
        rewardList.refresh(); // notify listeners that the list has changed
      } else {
        throw Exception('Failed to fetch rewards');
      }
    } catch (e) {
      print('Exception thrown when fetching rewards: $e');
    } finally {
      isLoading(false);
    }
  }

  void fetchReward(int id) async {
    isLoading(true);
    final url = '${Api.baseUrl}${Api.prefix}${Api.endPoints.rewardDetail}/$id';
    try {
      final http.Response response = await Api().getData(url);
      if (response.statusCode == 200) {
        var dataResponse = jsonDecode(response.body)['body'];
        Reward result = Reward.fromJson(dataResponse);
        reward.value = result;
        isLoading(false);
      } else {
        throw Exception('Failed to fetch reward detail');
      }
    } catch (e) {
      print('Exception thrown when fetching reward detail: $e');
    } finally {
      isLoading(false);
    }
  }

  final Future<SharedPreferences> _localStorage =
      SharedPreferences.getInstance();

  Future<void> exchangeReward(int rewardId, String? shopId) async {
    isLoading(true);
    try {
      var url = Api.baseUrl + Api.prefix + Api.endPoints.exchangeReward;

      SharedPreferences localStorage = await _localStorage;
      final currentUser = jsonDecode(localStorage.getString('currentUser')!);

      Map body = {
        'customer_id': currentUser['id'],
        'reward_id': rewardId,
        'shop_id': shopId,
      };

      http.Response response = await Api().postData(url, jsonEncode(body));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json['meta']['status'] == true) {
          exchangeController.fetchExchanges();
          historyController.fetchHistories();
          isLoading(false);
          // claimedDialog(json['body']['image'], json['body']['title']);

          // dashboardController.changeTabIndex(0);
          // homeNavController.controller.index = 1;
          Get.back();
          successDialog('Exchanged Successfully');
        } else {
          isLoading(false);
          throw jsonDecode(response.body)['meta']['message'] ?? "Unknown Error";
        }
      } else {
        isLoading(false);
        throw jsonDecode(response.body)['meta']['message'] ?? "Unknown Error";
      }
    } catch (e) {
      isLoading(false);
      Get.back();
      errorDialog(e);
    }
  }

  // Future<void> withdrawReward(int exchangeId, String? shopId) async {
  //   isLoading(true);
  //   try {
  //     var url = Api.baseUrl + Api.prefix + Api.endPoints.withdrawReward;

  //     Map body = {
  //       'exchange_id': exchangeId,
  //       'shop_id': shopId,
  //     };

  //     http.Response response = await Api().postData(url, jsonEncode(body));

  //     if (response.statusCode == 200) {
  //       final json = jsonDecode(response.body);
  //       if (json['meta']['status'] == true) {
  //         exchangeController.fetchExchanges();
  //         historyController.fetchHistories();
  //         isLoading(false);
  //         Get.back();
  //         claimedDialog(json['body']['image'], json['body']['title']);
  //       } else {
  //         isLoading(false);
  //         Get.back();
  //         errorDialog(
  //           jsonDecode(response.body)['meta']['message'] ?? "Unknown Error",
  //         );
  //       }
  //     } else {
  //       isLoading(false);
  //       throw jsonDecode(response.body)['meta']['message'] ?? "Unknown Error";
  //     }
  //   } catch (e) {
  //     isLoading(false);
  //     Get.back();
  //     errorDialog(e);
  //   }
  // }
}
