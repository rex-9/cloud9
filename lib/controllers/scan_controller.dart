import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import '../utils/api.dart';
import '../widgets/dialogs.dart';
import 'dashboard_controller.dart';
import 'me_controller.dart';

class ScanController extends GetxController {
  final DashboardController dashboardController = Get.put(
    DashboardController(),
    permanent: false,
  );

  final MeController meController = Get.put(MeController());

  final HomeNavController _tabx = Get.put(HomeNavController());

  RxBool isLoading = false.obs;

  RxBool isScanned = false.obs;

  Future<void> scan(String? code) async {
    isLoading(true);
    try {
      var url = Api.baseUrl + Api.prefix + Api.endPoints.scan;

      Map body = {
        'code': code,
      };

      http.Response response = await Api().postData(url, jsonEncode(body));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json['meta']['status'] == true) {
          meController.fetchMe();
          isLoading(false);
          dashboardController.changeTabIndex(0);
          _tabx.controller.index = 0;
          successDialog('Success!');
        } else {
          isLoading(false);
          dashboardController.changeTabIndex(0);
          _tabx.controller.index = 0;
          errorDialog(
            jsonDecode(response.body)['meta']['message'] ?? "Unknown Error",
          );
        }
      } else {
        throw jsonDecode(response.body)['meta']['message'] ?? "Unknown Error";
      }
    } catch (e) {
      isLoading(false);
      dashboardController.changeTabIndex(0);
      _tabx.controller.index = 0;
      errorDialog(e);
    }
    isLoading(false);
  }
}
