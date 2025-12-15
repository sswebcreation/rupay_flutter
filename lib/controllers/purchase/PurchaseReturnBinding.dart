import 'package:get/get.dart';
import 'package:rupay/controllers/purchase/PurchaseReturnController.dart';
import 'package:rupay/providers/PurchaseReturnProvider.dart';
import 'package:rupay/repositories/PurchaseReturnRepository.dart';
class PurchaseReturnBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PurchaseReturnController>(() => PurchaseReturnController());

    Get.lazyPut<PurchaseReturnRepository>(() => PurchaseReturnRepository(Get.find()));
    Get.lazyPut<PurchaseReturnProvider>(() => PurchaseReturnProvider(Get.find()));
  }
}
