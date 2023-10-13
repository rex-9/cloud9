import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/history.dart';
import '../utils/api.dart';

class HistoryController extends GetxController {
  RxList<History> historyList = <History>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onReady() {
    fetchHistories();
    super.onReady();
  }

  void fetchHistories() async {
    isLoading(true);
    final url = Api.baseUrl + Api.prefix + Api.endPoints.histories;
    final http.Response response = await Api().getData(url);
    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = jsonDecode(response.body)['body'];
      final histories =
          jsonResponse.map((history) => History.fromJson(history)).toList();

      historyList.assignAll(
          histories); // add the fetched histories to historyList using spread operator
      historyList.refresh(); // notify listeners that the list has changed
    } else {
      throw Exception('Failed to fetch histories');
    }
    isLoading(false);
  }
}
