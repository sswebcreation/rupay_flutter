import 'package:get/get.dart';
import 'package:rupay/controllers/sales/MultiLISalesPDFController.dart';
import 'package:rupay/providers/SalesProvider.dart';
import 'package:rupay/repositories/SalesRepository.dart';
class MultiLISalesPDFBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MultiLISalesPDFController>(() => MultiLISalesPDFController());

    Get.lazyPut<SalesRepository>(() => SalesRepository(Get.find()));
    Get.lazyPut<SalesProvider>(() => SalesProvider(Get.find()));
  }
}
