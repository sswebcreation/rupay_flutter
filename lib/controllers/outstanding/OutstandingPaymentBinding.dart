import 'package:get/get.dart';
import 'package:rupay/controllers/outstanding/OutstandingPaymentController.dart';
import 'package:rupay/providers/AccountProvider.dart';
import 'package:rupay/providers/OutstandingProvider.dart';
import 'package:rupay/repositories/AccountRepository.dart';
import 'package:rupay/repositories/OutstandingRepository.dart';
class OutstandingPaymentBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OutstandingPaymentController>(() => OutstandingPaymentController());

    Get.lazyPut<OutstandingRepository>(() => OutstandingRepository(Get.find()));
    Get.lazyPut<OutstandingProvider>(() => OutstandingProvider(Get.find()));

    Get.lazyPut<AccountRepository>(() => AccountRepository(Get.find()));
    Get.lazyPut<AccountProvider>(() => AccountProvider(Get.find()));
  }
}
