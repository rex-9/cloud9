import 'package:cloud9/controllers/shop_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/drag_controller.dart';

class ShopPage extends StatelessWidget {
  ShopPage({super.key});

  final ShopController shopController = Get.put(ShopController());
  final DragController dragController = Get.put(DragController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragDown: dragController.onVerticalDragDown,
      onVerticalDragUpdate: (details) => dragController.onVerticalDragUpdate(
        details,
        () => shopController.fetchShops(),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Padding(
            padding: EdgeInsets.only(top: 15),
            child: Text('Shops'),
          ),
          automaticallyImplyLeading: false,
          centerTitle: false,
          backgroundColor: Theme.of(context).primaryColor,
          titleSpacing: 30,
          elevation: 2,
        ),
        body: Obx(() {
          if (shopController.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (shopController.shopList.isEmpty) {
            return const Center(child: Text('No Shops yet...'));
          } else {
            return Column(
              children: shopController.shopList
                  .map((shop) => GestureDetector(
                        onTap: () => shopController.openMap(
                          double.parse(shop.latitude),
                          double.parse(shop.longitude),
                        ),
                        child: Container(
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
                                ), // shadow direction: bottom right
                              )
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image(
                                image: NetworkImage(shop.image),
                                height: 50,
                              ),
                              const SizedBox(height: 5),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      shopController.isOpen(
                                        shop.openHour,
                                        shop.closeHour,
                                      )
                                          ? Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                                color: Colors.green,
                                              ),
                                              width: 10,
                                              height: 10,
                                            )
                                          : Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                                color: Colors.grey,
                                              ),
                                              width: 10,
                                              height: 10,
                                            ),
                                      const SizedBox(width: 5),
                                      Text(
                                        shop.name,
                                        style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.65,
                                    child: Text(shop.address),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ))
                  .toList(),
            );
          }
        }),
      ),
    );
  }
}
