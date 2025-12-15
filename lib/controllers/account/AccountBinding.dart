import 'package:get/get.dart';
import 'package:rupay/controllers/account/AccountController.dart';
import 'package:rupay/providers/AccountProvider.dart';
import 'package:rupay/repositories/AccountRepository.dart';

class AccountBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AccountController>(() => AccountController());

    Get.lazyPut<AccountRepository>(() => AccountRepository(Get.find()));
    Get.lazyPut<AccountProvider>(() => AccountProvider(Get.find()));
  }
}
