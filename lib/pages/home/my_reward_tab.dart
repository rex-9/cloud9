import 'package:cloud9/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/drag_controller.dart';
import '../../controllers/exchange_controller.dart';
import '../withdraw_scan_page.dart';

class MyRewardTab extends StatelessWidget {
  MyRewardTab({super.key});

  final ExchangeController exchangeController = Get.put(ExchangeController());
  final DragController dragController = Get.put(DragController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragDown: dragController.onVerticalDragDown,
      onVerticalDragUpdate: (details) => dragController.onVerticalDragUpdate(
        details,
        () => exchangeController.fetchExchanges(),
      ),
      // print("Vertical Drag Down detected at (${details.globalPosition.dx},${details.globalPosition.dy})"),
      child: Scaffold(
        body: Obx(() {
          if (exchangeController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else if (exchangeController.myRewardList.isEmpty) {
            return const Center(
              child: Text('No My Rewards yet...'),
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                children: exchangeController.myRewardList
                    .map((exchange) => Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 5,
                          ),
                          margin: const EdgeInsets.only(top: 18),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 2.0,
                                spreadRadius: 0.5,
                                offset: Offset(
                                  2.0,
                                  2.0,
                                ),
                              )
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              fadeInImage(
                                exchange.reward.image,
                                "assets/images/logo.png",
                                "assets/images/logo.png",
                                100,
                                90,
                              ),
                              SizedBox(
                                width: 140,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Flexible(
                                          child: Text(
                                            exchange.reward.title,
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          '(${exchange.status})',
                                          style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Text('used points: ${exchange.usedPoint}'),
                                    const SizedBox(height: 5),
                                    Text(
                                      exchange.exchangeDate,
                                      style: const TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 5),
                              exchange.status == 'pending'
                                  ? TextButton(
                                      onPressed: () =>
                                          Get.to(() => WithdrawScanPage(
                                                exchangeId: exchange.id,
                                              )),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        child: const Padding(
                                          padding: EdgeInsets.symmetric(
                                            vertical: 5,
                                            horizontal: 10,
                                          ),
                                          child: Text(
                                            'Withdraw',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : const SizedBox(
                                      width: 70,
                                      child: Text(
                                        'Claimed',
                                        style: TextStyle(
                                          color: Colors.green,
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                        ))
                    .toList(),
              ),
            );
          }
        }),
      ),
    );
  }
}
