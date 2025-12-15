import 'package:get/get.dart';
import 'package:rupay/controllers/ledger/MultiLedgerPDFController.dart';
import 'package:rupay/providers/LedgerProvider.dart';
import 'package:rupay/repositories/LedgerRepository.dart';
class MultiLedgerPDFBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MultiLedgerPDFController>(() => MultiLedgerPDFController());

    Get.lazyPut<LedgerRepository>(() => LedgerRepository(Get.find()));
    Get.lazyPut<LedgerProvider>(() => LedgerProvider(Get.find()));
  }
}
