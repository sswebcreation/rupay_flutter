import 'package:get/get.dart';
import 'package:rupay/controllers/cash/CashController.dart';
import 'package:rupay/providers/CashProvider.dart';
import 'package:rupay/repositories/CashRepository.dart';
class CashBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CashController>(() => CashController());

    Get.lazyPut<CashRepository>(() => CashRepository(Get.find()));
    Get.lazyPut<CashProvider>(() => CashProvider(Get.find()));
  }
}
