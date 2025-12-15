import 'package:get/get.dart';
import 'package:rupay/controllers/sales/SingleSalesReturnPDFController.dart';
import 'package:rupay/providers/SalesReturnProvider.dart';
import 'package:rupay/repositories/SalesReturnRepository.dart';
class SingleSalesReturnPDFBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SingleSalesReturnPDFController>(() => SingleSalesReturnPDFController());

    Get.lazyPut<SalesReturnRepository>(() => SalesReturnRepository(Get.find()));
    Get.lazyPut<SalesReturnProvider>(() => SalesReturnProvider(Get.find()));
  }
}
