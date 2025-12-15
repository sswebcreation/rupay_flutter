import 'package:get/get.dart';
import 'package:rupay/controllers/purchase/SinglePurchaseReturnPDFController.dart';
import 'package:rupay/providers/PurchaseReturnProvider.dart';
import 'package:rupay/repositories/PurchaseReturnRepository.dart';
class SinglePurchaseReturnPDFBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SinglePurchaseReturnPDFController>(() => SinglePurchaseReturnPDFController());


    Get.lazyPut<PurchaseReturnRepository>(() => PurchaseReturnRepository(Get.find()));
    Get.lazyPut<PurchaseReturnProvider>(() => PurchaseReturnProvider(Get.find()));
  }
}
