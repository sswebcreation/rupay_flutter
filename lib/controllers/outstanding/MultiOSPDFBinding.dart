import 'package:get/get.dart';
import 'package:rupay/controllers/outstanding/MultiOSPDFController.dart';
class MultiOSPDFBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MultiOSPDFController>(() => MultiOSPDFController());
  }
}
