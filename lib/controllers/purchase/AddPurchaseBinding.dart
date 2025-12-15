import 'package:get/get.dart';
import 'package:rupay/controllers/purchase/AddPurchaseController.dart';
import 'package:rupay/providers/AccountProvider.dart';
import 'package:rupay/providers/DaybookProvider.dart';
import 'package:rupay/providers/PurchaseProvider.dart';
import 'package:rupay/repositories/AccountRepository.dart';
import 'package:rupay/repositories/DaybookRepository.dart';
import 'package:rupay/repositories/PurchaseRepository.dart';
class AddPurchaseBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddPurchaseController>(() => AddPurchaseController());

    Get.lazyPut<PurchaseRepository>(() => PurchaseRepository(Get.find()));
    Get.lazyPut<PurchaseProvider>(() => PurchaseProvider(Get.find()));

    Get.lazyPut<AccountRepository>(() => AccountRepository(Get.find()));
    Get.lazyPut<AccountProvider>(() => AccountProvider(Get.find()));

    Get.lazyPut<DaybookRepository>(() => DaybookRepository(Get.find()));
    Get.lazyPut<DaybookProvider>(() => DaybookProvider(Get.find()));
  }
}
