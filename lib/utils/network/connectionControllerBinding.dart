import 'package:crack_tech_app/utils/network/connectionManagerController.dart';
import 'package:get/get.dart';

class ControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ConnectionManagerController>(ConnectionManagerController());
  }
}