import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Obx(() => Container(
        color: Colors.white,
        child: Center(
          child: Image.asset("assets/icons/app-logo.jpeg",height: controller.height.value,width:controller.width.value,),
        ),
      ),
      ),
    );
  }
}
