import 'package:get/get.dart';
import 'package:rthetapi_player/views/homeScreen/homeScreen.dart';

class splashScreenController extends GetxController {
  @override
  void onInit() {
    animationInitilization();
    super.onInit();
  }

  animationInitilization() {
    Future.delayed(Duration(seconds: 3))
        .then((value) => Get.offAll(homeScreen()));
  }
}