import 'package:get/get.dart';
import 'package:rupay/controllers/bank/AddBankController.dart';
import 'package:rupay/providers/AccountProvider.dart';
import 'package:rupay/providers/DaybookProvider.dart';
import 'package:rupay/providers/BankProvider.dart';
import 'package:rupay/repositories/AccountRepository.dart';
import 'package:rupay/repositories/DaybookRepository.dart';
import 'package:rupay/repositories/BankRepository.dart';
class AddBankBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddBankController>(() => AddBankController());

    Get.lazyPut<BankRepository>(() => BankRepository(Get.find()));
    Get.lazyPut<BankProvider>(() => BankProvider(Get.find()));

    Get.lazyPut<AccountRepository>(() => AccountRepository(Get.find()));
    Get.lazyPut<AccountProvider>(() => AccountProvider(Get.find()));

    Get.lazyPut<DaybookRepository>(() => DaybookRepository(Get.find()));
    Get.lazyPut<DaybookProvider>(() => DaybookProvider(Get.find()));
  }
}
