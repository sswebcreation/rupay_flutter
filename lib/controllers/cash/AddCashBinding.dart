import 'package:get/get.dart';
import 'package:rupay/controllers/cash/AddCashController.dart';
import 'package:rupay/providers/AccountProvider.dart';
import 'package:rupay/providers/DaybookProvider.dart';
import 'package:rupay/providers/CashProvider.dart';
import 'package:rupay/repositories/AccountRepository.dart';
import 'package:rupay/repositories/DaybookRepository.dart';
import 'package:rupay/repositories/CashRepository.dart';
class AddCashBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddCashController>(() => AddCashController());

    Get.lazyPut<CashRepository>(() => CashRepository(Get.find()));
    Get.lazyPut<CashProvider>(() => CashProvider(Get.find()));

    Get.lazyPut<AccountRepository>(() => AccountRepository(Get.find()));
    Get.lazyPut<AccountProvider>(() => AccountProvider(Get.find()));

    Get.lazyPut<DaybookRepository>(() => DaybookRepository(Get.find()));
    Get.lazyPut<DaybookProvider>(() => DaybookProvider(Get.find()));
  }
}
