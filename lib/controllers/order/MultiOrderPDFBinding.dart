import 'package:get/get.dart';
import 'package:rupay/controllers/order/MultiOrderPDFController.dart';
class MultiOrderPDFBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MultiOrderPDFController>(() => MultiOrderPDFController());
  }
}
