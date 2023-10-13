import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/dashboard_controller.dart';
import 'pages/home/home_page.dart';
import 'pages/reward_page.dart';
import 'pages/scan_page.dart';
import 'pages/shop_page.dart';

class Dashboard extends StatelessWidget {
  Dashboard({super.key});

  final TextStyle unselectedLabelStyle = TextStyle(
    color: Colors.white.withOpacity(0.5),
    fontWeight: FontWeight.w500,
    fontSize: 12,
  );

  TextStyle selectedLabelStyle(context) => TextStyle(
        color: Theme.of(context).primaryColor,
        fontWeight: FontWeight.w500,
        fontSize: 12,
      );

  BottomNavigationBarItem botNavBarItem(context, icon, label) =>
      BottomNavigationBarItem(
        icon: Container(
          margin: const EdgeInsets.only(bottom: 7),
          child: Icon(
            icon,
            size: 30,
          ),
        ),
        label: label,
        backgroundColor: Colors.white,
      );

  @override
  Widget build(BuildContext context) {
    final DashboardController dashboardController = Get.put(
      DashboardController(),
      permanent: false,
    );

    return SafeArea(
      child: Scaffold(
        bottomNavigationBar:
            buildBottomNavigationMenu(context, dashboardController),
        body: Obx(
          () => IndexedStack(
            index: dashboardController.tabIndex.value,
            children: [
              HomePage(),
              const ScanPage(),
              const RewardPage(),
              ShopPage(),
            ],
          ),
        ),
      ),
    );
  }

  buildBottomNavigationMenu(context, dashboardController) {
    return Obx(
      () => MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: SizedBox(
          child: BottomNavigationBar(
            showUnselectedLabels: true,
            showSelectedLabels: true,
            currentIndex: dashboardController.tabIndex.value,
            onTap: dashboardController.changeTabIndex,
            backgroundColor: Colors.white,
            unselectedItemColor: Colors.black.withOpacity(0.5),
            selectedItemColor: Theme.of(context).primaryColor,
            unselectedLabelStyle: unselectedLabelStyle,
            selectedLabelStyle: selectedLabelStyle(context),
            items: [
              botNavBarItem(context, Icons.home_outlined, 'Home'),
              botNavBarItem(context, Icons.screenshot_outlined, 'Scan'),
              botNavBarItem(context, Icons.star_outline, 'Rewards'),
              botNavBarItem(context, Icons.shopify_outlined, 'Shops'),
            ],
          ),
        ),
      ),
    );
  }
}
