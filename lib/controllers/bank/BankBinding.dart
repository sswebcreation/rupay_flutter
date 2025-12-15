import 'package:get/get.dart';
import 'package:rupay/controllers/bank/BankController.dart';
import 'package:rupay/providers/BankProvider.dart';
import 'package:rupay/repositories/BankRepository.dart';
class BankBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BankController>(() => BankController());

    Get.lazyPut<BankRepository>(() => BankRepository(Get.find()));
    Get.lazyPut<BankProvider>(() => BankProvider(Get.find()));
  }
}
