import 'package:get/get.dart';
import 'package:rupay/controllers/sales/MultiSalesPDFController.dart';
import 'package:rupay/providers/SalesProvider.dart';
import 'package:rupay/repositories/SalesRepository.dart';
class MultiSalesPDFBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MultiSalesPDFController>(() => MultiSalesPDFController());

    Get.lazyPut<SalesRepository>(() => SalesRepository(Get.find()));
    Get.lazyPut<SalesProvider>(() => SalesProvider(Get.find()));
  }
}
