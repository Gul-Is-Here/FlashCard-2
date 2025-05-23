import 'package:get/get.dart';
import 'dart:async';

class BottomNavController extends GetxController {
  var selectedIndex = 0.obs;
  var isSplashFinished = false.obs;

  void changeIndex(int index) {
    selectedIndex.value = index;
  }

  @override
  void onInit() {
    super.onInit();
    Timer(Duration(seconds: 3), () {
      isSplashFinished.value = true;
    });
  }
}
