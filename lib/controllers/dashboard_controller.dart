import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'me_controller.dart';
import 'reward_controller.dart';
import 'shop_controller.dart';

MeController meController = Get.put(MeController());
RewardController rewardController = Get.put(RewardController());
ShopController shopController = Get.put(ShopController());

class DashboardController extends GetxController {
  var tabIndex = 0.obs;

  void changeTabIndex(int index) {
    tabIndex.value = index;
    // if (index == 0) {
    //   meController.fetchMe();
    //   rewardController.fetchRewards();
    // } else if (index == 2) {
    //   rewardController.fetchRewards();
    // } else if (index == 3) {
    //   shopController.fetchShops();
    // }
  }
}

class HomeNavController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final List<SizedBox> tabs = <SizedBox>[
    const SizedBox(height: 35, child: Tab(text: 'Home')),
    const SizedBox(height: 35, child: Tab(text: 'My Reward')),
    const SizedBox(height: 35, child: Tab(text: 'History')),
  ];

  late TabController controller;

  @override
  void onInit() {
    super.onInit();
    controller = TabController(vsync: this, length: tabs.length);
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }
}
