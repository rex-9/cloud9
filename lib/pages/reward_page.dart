import 'package:cloud9/controllers/reward_controller.dart';
import 'package:cloud9/models/reward.dart';
import 'package:cloud9/pages/reward_detail_page.dart';
import 'package:cloud9/pages/withdraw_scan_page.dart';
import 'package:cloud9/utils/constants.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../controllers/drag_controller.dart';
import '../widgets/dialogs.dart';

class RewardPage extends StatefulWidget {
  const RewardPage({super.key});

  @override
  State<RewardPage> createState() => _RewardPageState();
}

class _RewardPageState extends State<RewardPage> {
  final RewardController rewardController = Get.put(RewardController());
  final DragController dragController = Get.put(DragController());

  // Initialize the controller
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragDown: dragController.onVerticalDragDown,
      onVerticalDragUpdate: (details) => dragController.onVerticalDragUpdate(
        details,
        () => rewardController.fetchRewards(),
      ),
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          title: const Padding(
            padding: EdgeInsets.only(top: 15),
            child: Text('Rewards'),
          ),
          automaticallyImplyLeading: false,
          centerTitle: false,
          backgroundColor: Theme.of(context).primaryColor,
          titleSpacing: 30,
          elevation: 2,
        ),
        body: Obx(() {
          if (rewardController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else if (rewardController.rewardList.isEmpty) {
            return const Center(
              child: Text('No Rewards yet...'),
            );
          } else {
            return Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Material(
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          textButton(
                            () => debugPrint('Pressed Filter'),
                            Icons.filter_outlined,
                            'Start & Filter',
                          ),
                          Container(
                            height: 25,
                            color: Colors.grey,
                            width: 1,
                          ),
                          textButton(
                            () => debugPrint('Pressed Category'),
                            Icons.category_outlined,
                            'Category',
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 20,
                    ),
                    child: Text(
                      'All Rewards',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Expanded(
                    child: GridView.count(
                      padding: const EdgeInsets.all(10),
                      crossAxisCount: 2,
                      crossAxisSpacing: 0,
                      mainAxisSpacing: 0,
                      childAspectRatio: 1 / 1.35,
                      children:
                          rewardController.rewardList.map((Reward reward) {
                        return Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 5,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  rewardController.fetchReward(reward.id);
                                  Get.to(
                                    () => const RewardDetailPage(),
                                  );
                                },
                                child: fadeInImage(
                                  reward.image,
                                  "assets/images/logo.png",
                                  "assets/images/logo.png",
                                  155,
                                  120,
                                ),
                              ),
                              const SizedBox(height: 5),
                              SizedBox(
                                height: 15,
                                child: Text(
                                  reward.title,
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  Text(
                                    '${reward.point}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Text(
                                    ' Points',
                                    style: TextStyle(fontSize: 10),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  ElevatedButton(
                                    onPressed: () => confirmDialog(
                                      'Please confirm to Exchange!',
                                      () => exchange(reward.id),
                                      context,
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Theme.of(context).primaryColor,
                                      textStyle: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    child: const Text('Exchange'),
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            );
          }
        }),
      ),
    );
  }

  void exchange(int id) {
    Get.to(() => WithdrawScanPage(exchangeId: id));
    // rewardController.exchangeReward(id);
    Get.back();
  }

  TextButton textButton(onPressed, icon, label) => TextButton.icon(
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: Colors.black,
        ),
        label: Text(
          label,
          style: const TextStyle(color: Colors.black),
        ),
      );
}
