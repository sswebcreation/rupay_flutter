import 'package:get/get.dart';
import 'package:rupay/controllers/signUp/SignUpController.dart';

class SignUpBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignUpController>(() => SignUpController());

    // Get.lazyPut<UserRepository>(() => UserRepository(Get.find()));
    // Get.lazyPut<UserProvider>(() => UserProvider(Get.find()));
  }
}
