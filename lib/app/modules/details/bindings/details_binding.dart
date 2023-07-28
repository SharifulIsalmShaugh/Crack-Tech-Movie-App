import 'package:get/get.dart';

import '../controllers/details_controller.dart';

class DetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<DetailsController>(DetailsController());
  }
}