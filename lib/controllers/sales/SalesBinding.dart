import 'package:get/get.dart';
import 'package:rupay/controllers/sales/SalesController.dart';
import 'package:rupay/controllers/sales/SalesReturnController.dart';
import 'package:rupay/providers/SalesProvider.dart';
import 'package:rupay/repositories/SalesRepository.dart';
class SalesBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SalesController>(() => SalesController());

    Get.lazyPut<SalesRepository>(() => SalesRepository(Get.find()));
    Get.lazyPut<SalesProvider>(() => SalesProvider(Get.find()));
  }
}
