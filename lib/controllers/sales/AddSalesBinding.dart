import 'package:get/get.dart';
import 'package:rupay/controllers/sales/AddSalesController.dart';
import 'package:rupay/providers/AccountProvider.dart';
import 'package:rupay/providers/DaybookProvider.dart';
import 'package:rupay/providers/SalesProvider.dart';
import 'package:rupay/repositories/AccountRepository.dart';
import 'package:rupay/repositories/DaybookRepository.dart';
import 'package:rupay/repositories/SalesRepository.dart';
class AddSalesBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddSalesController>(() => AddSalesController());

    Get.lazyPut<SalesRepository>(() => SalesRepository(Get.find()));
    Get.lazyPut<SalesProvider>(() => SalesProvider(Get.find()));

    Get.lazyPut<AccountRepository>(() => AccountRepository(Get.find()));
    Get.lazyPut<AccountProvider>(() => AccountProvider(Get.find()));

    Get.lazyPut<DaybookRepository>(() => DaybookRepository(Get.find()));
    Get.lazyPut<DaybookProvider>(() => DaybookProvider(Get.find()));
  }
}
