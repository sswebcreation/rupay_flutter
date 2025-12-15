import 'package:get/get.dart';
import 'package:rupay/controllers/customer/CustomerController.dart';
import 'package:rupay/providers/AccountProvider.dart';
import 'package:rupay/repositories/AccountRepository.dart';

class CustomerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomerController>(() => CustomerController());

    Get.lazyPut<AccountRepository>(() => AccountRepository(Get.find()));
    Get.lazyPut<AccountProvider>(() => AccountProvider(Get.find()));
  }
}
