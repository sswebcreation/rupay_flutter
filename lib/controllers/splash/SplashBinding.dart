// import 'package:rupay/providers/UserProvider.dart';
// import 'package:rupay/repositories/UserRepository.dart';
import 'package:get/get.dart';
import 'package:rupay/controllers/splash/SplashController.dart';

class SplashBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(() => SplashController());

    // Get.lazyPut<UserRepository>(() => UserRepository(Get.find()));
    // Get.lazyPut<UserProvider>(() => UserProvider(Get.find()));
  }
}
