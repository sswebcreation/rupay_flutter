import 'package:get/get.dart';
import 'package:rupay/controllers/order/AddOrderController.dart';
import 'package:rupay/providers/AccountProvider.dart';
import 'package:rupay/providers/OrderProvider.dart';
import 'package:rupay/repositories/AccountRepository.dart';
import 'package:rupay/repositories/OrderRepository.dart';
class AddOrderBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddOrderController>(() => AddOrderController());

    Get.lazyPut<OrderRepository>(() => OrderRepository(Get.find()));
    Get.lazyPut<OrderProvider>(() => OrderProvider(Get.find()));

    Get.lazyPut<AccountRepository>(() => AccountRepository(Get.find()));
    Get.lazyPut<AccountProvider>(() => AccountProvider(Get.find()));
  }
}
