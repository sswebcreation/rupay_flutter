import 'package:get/get.dart';
import 'package:rupay/controllers/purchase/PurchaseController.dart';
import 'package:rupay/controllers/purchase/PurchaseReturnController.dart';
import 'package:rupay/providers/PurchaseProvider.dart';
import 'package:rupay/repositories/PurchaseRepository.dart';
class PurchaseBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PurchaseController>(() => PurchaseController());
    Get.lazyPut<PurchaseReturnController>(() => PurchaseReturnController());

    Get.lazyPut<PurchaseRepository>(() => PurchaseRepository(Get.find()));
    Get.lazyPut<PurchaseProvider>(() => PurchaseProvider(Get.find()));
  }
}
