import 'package:crack_tech_app/app/data/movieDataResponse.dart';
import 'package:crack_tech_app/utils/constrains.dart';
import 'package:get/get.dart';

class DetailsController extends GetxController {
  final Rx<Movie> movieData = Movie().obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    argumentData();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  argumentData(){
    movieData.value = Get.arguments[Constants.MOVIE];
  }
}
