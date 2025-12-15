import 'package:get/get.dart';
import 'package:rupay/controllers/purchase/MultiLIPurchasePDFController.dart';
import 'package:rupay/providers/PurchaseProvider.dart';
import 'package:rupay/repositories/PurchaseRepository.dart';
class MultiLIPurchasePDFBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MultiLIPurchasePDFController>(() => MultiLIPurchasePDFController());

    Get.lazyPut<PurchaseRepository>(() => PurchaseRepository(Get.find()));
    Get.lazyPut<PurchaseProvider>(() => PurchaseProvider(Get.find()));
  }
}
