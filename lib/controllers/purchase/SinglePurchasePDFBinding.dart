import 'package:get/get.dart';
import 'package:rupay/controllers/purchase/SinglePurchasePDFController.dart';
import 'package:rupay/providers/PurchaseProvider.dart';
import 'package:rupay/repositories/PurchaseRepository.dart';
class SinglePurchasePDFBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SinglePurchasePDFController>(() => SinglePurchasePDFController());

    Get.lazyPut<PurchaseRepository>(() => PurchaseRepository(Get.find()));
    Get.lazyPut<PurchaseProvider>(() => PurchaseProvider(Get.find()));
  }
}
