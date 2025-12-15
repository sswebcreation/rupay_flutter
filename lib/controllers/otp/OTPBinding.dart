import 'package:get/get.dart';
import 'package:rupay/controllers/otp/OTPController.dart';

class OTPBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OTPController>(() => OTPController());
  }
}
