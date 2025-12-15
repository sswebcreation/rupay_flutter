import 'package:get/get.dart';
import 'package:rupay/controllers/cash/MultiCashPDFController.dart';
import 'package:rupay/providers/CashProvider.dart';
import 'package:rupay/repositories/CashRepository.dart';
class MultiCashPDFBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MultiCashPDFController>(() => MultiCashPDFController());

    Get.lazyPut<CashRepository>(() => CashRepository(Get.find()));
    Get.lazyPut<CashProvider>(() => CashProvider(Get.find()));
  }
}
