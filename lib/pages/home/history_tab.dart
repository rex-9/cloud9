import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/drag_controller.dart';
import '../../controllers/history_controller.dart';

class HistoryTab extends StatelessWidget {
  HistoryTab({super.key});

  final HistoryController historyController = Get.put(HistoryController());
  final DragController dragController = Get.put(DragController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragDown: dragController.onVerticalDragDown,
      onVerticalDragUpdate: (details) => dragController.onVerticalDragUpdate(
        details,
        () => historyController.fetchHistories(),
      ),
      // print("Vertical Drag Down detected at (${details.globalPosition.dx},${details.globalPosition.dy})"),
      child: Scaffold(
        body: Obx(
          () {
            if (historyController.isLoading.value) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (historyController.historyList.isEmpty) {
              return const Center(
                child: Text('No Histories yet...'),
              );
            } else {
              return ListView.builder(
                itemCount: historyController.historyList.length,
                itemBuilder: (BuildContext ctxt, int i) {
                  return Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
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
                          ), // shadow direction: bottom right
                        )
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image(
                          image: NetworkImage(
                            historyController.historyList[i].image,
                          ),
                          height: 50,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(historyController.historyList[i].title),
                            const SizedBox(height: 5),
                            Text(
                              historyController.historyList[i].message,
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text(
                              'View',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              historyController.historyList[i].createdAt
                                  .split("T")
                                  .first,
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
