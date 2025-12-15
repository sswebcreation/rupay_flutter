import 'package:get/get.dart';
import 'package:rupay/controllers/order/OrderController.dart';
import 'package:rupay/providers/AccountProvider.dart';
import 'package:rupay/providers/OrderProvider.dart';
import 'package:rupay/repositories/AccountRepository.dart';
import 'package:rupay/repositories/OrderRepository.dart';
class OrderBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderController>(() => OrderController());

    Get.lazyPut<OrderRepository>(() => OrderRepository(Get.find()));
    Get.lazyPut<OrderProvider>(() => OrderProvider(Get.find()));

    Get.lazyPut<AccountRepository>(() => AccountRepository(Get.find()));
    Get.lazyPut<AccountProvider>(() => AccountProvider(Get.find()));
  }
}
