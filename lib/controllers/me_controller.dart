import 'dart:convert';

import 'package:cloud9/widgets/appbar_widget.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/me.dart';
import '../utils/api.dart';
import 'login_controller.dart';

class MeController extends GetxController {
  var me = Me(id: 0, email: '', name: '', phone: '', point: 0, status: '').obs;
  RxBool isLoading = false.obs;

  LoginController login = Get.put(LoginController());

  @override
  void onReady() {
    fetchMe();
    super.onReady();
  }

  void fetchMe() async {
    isLoading(true);
    final url = Api.baseUrl + Api.prefix + Api.endPoints.me;
    final http.Response response = await Api().getData(url);
    if (response.statusCode == 200) {
      var dataResponse = jsonDecode(response.body)['body'];
      Me user = Me.fromJson(dataResponse);
      me.value = user;
      isLoading(false);
    } else if (jsonDecode(response.body)['meta']['message'] ==
        "Invalid Token") {
      loginController.logout();
      print("Invalid Token");
      throw Exception('Failed Get API');
    }
  }
}
