// import 'package:rupay/providers/UserProvider.dart';
// import 'package:rupay/repositories/UserRepository.dart';
import 'package:get/get.dart';
import 'package:rupay/controllers/login/LoginController.dart';
import 'package:rupay/providers/UserProvider.dart';
import 'package:rupay/repositories/UserRepository.dart';

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());

    Get.lazyPut<UserRepository>(() => UserRepository(Get.find()));
    Get.lazyPut<UserProvider>(() => UserProvider(Get.find()));
  }
}
