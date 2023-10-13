import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/dashboard_controller.dart';
import '../../widgets/appbar_widget.dart';
import 'history_tab.dart';
import 'home_tab.dart';
import 'my_reward_tab.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final HomeNavController _tabx = Get.put(HomeNavController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabx.tabs.length,
      child: Scaffold(
        appBar: appBarWidget(context, 'Home', _tabx.tabs, _tabx.controller),
        body: TabBarView(
          controller: _tabx.controller,
          children: [
            HomeTab(),
            MyRewardTab(),
            HistoryTab(),
          ],
        ),
      ),
    );
  }
}
