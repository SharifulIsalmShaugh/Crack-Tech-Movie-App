import 'dart:async';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class SplashController extends GetxController {
  final height = 320.0.obs;
  final width = 320.0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    loadPage();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<Timer> loadPage() async {
    return Timer(const Duration(milliseconds: 1000), onDoneLoading);
  }

  onDoneLoading() async {
      navigateToHomeScreen();
  }

  navigateToHomeScreen() {
    Get.offAndToNamed(Routes.HOME);
  }

}
