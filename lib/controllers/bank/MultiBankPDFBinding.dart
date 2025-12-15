import 'package:get/get.dart';
import 'package:rupay/controllers/bank/MultiBankPDFController.dart';
import 'package:rupay/providers/BankProvider.dart';
import 'package:rupay/repositories/BankRepository.dart';
class MultiBankPDFBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MultiBankPDFController>(() => MultiBankPDFController());

    Get.lazyPut<BankRepository>(() => BankRepository(Get.find()));
    Get.lazyPut<BankProvider>(() => BankProvider(Get.find()));
  }
}
