import 'package:get/get.dart';
import 'package:rupay/controllers/sales/SingleSalesPDFController.dart';
import 'package:rupay/providers/SalesProvider.dart';
import 'package:rupay/repositories/SalesRepository.dart';
class SingleSalesPDFBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SingleSalesPDFController>(() => SingleSalesPDFController());

    Get.lazyPut<SalesRepository>(() => SalesRepository(Get.find()));
    Get.lazyPut<SalesProvider>(() => SalesProvider(Get.find()));
  }
}
