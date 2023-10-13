import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/dashboard_controller.dart';
import '../../controllers/drag_controller.dart';
import '../../controllers/me_controller.dart';
import '../../controllers/reward_controller.dart';
import '../../utils/constants.dart';
import '../reward_detail_page.dart';

class HomeTab extends StatelessWidget {
  HomeTab({super.key});

  final DashboardController dashboardController = Get.put(
    DashboardController(),
    permanent: false,
  );

  final RewardController rewardController = Get.put(RewardController());

  final MeController meController = Get.put(MeController());
  final DragController dragController = Get.put(DragController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragDown: dragController.onVerticalDragDown,
      onVerticalDragUpdate: (details) => dragController.onVerticalDragUpdate(
        details,
        () {
          meController.fetchMe();
          rewardController.fetchRewards();
        },
      ),
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Builder(
          builder: (context) {
            return Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Obx(() {
                        if (meController.isLoading.value) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 20,
                              horizontal: 15,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.redAccent,
                            ),
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          meController.me.value.name,
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                        const SizedBox(height: 5),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.person,
                                              size: 14,
                                            ),
                                            Text(meController.me.value.phone),
                                          ],
                                        )
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Points',
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        const SizedBox(height: 3),
                                        Text(
                                          '${meController.me.value.point}',
                                          style: const TextStyle(fontSize: 20),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.white,
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 2,
                                        horizontal: 7,
                                      ),
                                      child: const Text(
                                        'Basic',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        margin: const EdgeInsets.only(top: 20),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                        ),
                                        child: Column(
                                          children: [
                                            Container(
                                              height: 2,
                                              color: Colors.white,
                                            ),
                                            const SizedBox(height: 5),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                    '${meController.me.value.point}'),
                                                const Text('Elite')
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: Colors.white,
                                      ),
                                      child: const Icon(
                                        Icons.question_mark_outlined,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }
                      }),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () => dashboardController.changeTabIndex(2),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image(
                                image: const AssetImage(
                                  'assets/images/browse-all-rewards.jpg',
                                ),
                                width: MediaQuery.of(context).size.width * 0.45,
                              ),
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image(
                              image: const AssetImage(
                                'assets/images/how-to-get-points.jpg',
                              ),
                              width: MediaQuery.of(context).size.width * 0.45,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 15,
                    ),
                    alignment: Alignment.bottomLeft,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(18),
                        topRight: Radius.circular(18),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Popular Rewards',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          'Rewards',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 15),
                        SizedBox(
                          height: 140,
                          child: Obx(() {
                            if (rewardController.isLoading.value) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (rewardController.rewardList.isEmpty) {
                              return const Center(
                                child: Text('No Rewards yet...'),
                              );
                            } else {
                              return ListView(
                                scrollDirection: Axis.horizontal,
                                children: rewardController.rewardList
                                    .map((reward) => SizedBox(
                                          width: 120,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  rewardController
                                                      .fetchReward(reward.id);
                                                  Get.to(
                                                    () =>
                                                        const RewardDetailPage(),
                                                  );
                                                },
                                                child: fadeInImage(
                                                  reward.image,
                                                  "assets/images/logo.png",
                                                  "assets/images/logo.png",
                                                  110,
                                                  75,
                                                ),
                                              ),
                                              const SizedBox(height: 5),
                                              Text(
                                                reward.title,
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(height: 5),
                                              Row(
                                                children: [
                                                  Text(
                                                    '${reward.point}',
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  const Text(
                                                    ' Points',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ))
                                    .toList(),
                              );
                            }
                          }),
                        ),
                        const SizedBox(height: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Theme.of(context).primaryColor,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              alignment: Alignment.center,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 10,
                                      ),
                                      minimumSize: const Size(50, 30),
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      alignment: Alignment.centerLeft,
                                    ),
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: Text(
                                        'View All Rewards',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                    ),
                                    onPressed: () =>
                                        dashboardController.changeTabIndex(2),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
