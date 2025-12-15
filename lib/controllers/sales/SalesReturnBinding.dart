import 'package:get/get.dart';
import 'package:rupay/controllers/sales/SalesReturnController.dart';
import 'package:rupay/providers/SalesReturnProvider.dart';
import 'package:rupay/repositories/SalesReturnRepository.dart';
class SalesReturnBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SalesReturnController>(() => SalesReturnController());

    Get.lazyPut<SalesReturnRepository>(() => SalesReturnRepository(Get.find()));
    Get.lazyPut<SalesReturnProvider>(() => SalesReturnProvider(Get.find()));
  }
}
