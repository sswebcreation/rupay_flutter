import 'package:get/get.dart';
import 'package:rupay/controllers/ledger/LedgerController.dart';
import 'package:rupay/providers/LedgerProvider.dart';
import 'package:rupay/repositories/LedgerRepository.dart';
class LedgerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LedgerController>(() => LedgerController());

    Get.lazyPut<LedgerRepository>(() => LedgerRepository(Get.find()));
    Get.lazyPut<LedgerProvider>(() => LedgerProvider(Get.find()));
  }
}
