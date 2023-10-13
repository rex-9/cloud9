import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DragController extends GetxController {
  final RxDouble _dragDistance = 0.0.obs;
  final RxDouble _dragThreshold = 20.0.obs; // adjust this as needed

  void onVerticalDragDown(DragDownDetails details) {
    _dragDistance.value = 0.0;
  }

  void onVerticalDragUpdate(
    DragUpdateDetails details,
    void Function() function,
  ) {
    _dragDistance.value += details.delta.dy;
    if (_dragDistance.value >= _dragThreshold.value) {
      // do something when drag distance threshold is reached
      function();
    }
  }
}
