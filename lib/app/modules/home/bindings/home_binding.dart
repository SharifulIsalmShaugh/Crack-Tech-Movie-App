import 'package:get/get.dart';

import '../../../../utils/network/connectionManagerController.dart';
import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<HomeController>(HomeController());
  }
}
