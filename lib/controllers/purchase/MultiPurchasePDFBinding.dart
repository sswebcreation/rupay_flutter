import 'package:get/get.dart';
import 'package:rupay/controllers/purchase/MultiPurchasePDFController.dart';
import 'package:rupay/providers/PurchaseProvider.dart';
import 'package:rupay/repositories/PurchaseRepository.dart';
class MultiPurchasePDFBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MultiPurchasePDFController>(() => MultiPurchasePDFController());

    Get.lazyPut<PurchaseRepository>(() => PurchaseRepository(Get.find()));
    Get.lazyPut<PurchaseProvider>(() => PurchaseProvider(Get.find()));
  }
}
