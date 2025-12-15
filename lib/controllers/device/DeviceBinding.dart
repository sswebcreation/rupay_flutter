import 'package:get/get.dart';
import 'package:rupay/controllers/device/DeviceController.dart';
import 'package:rupay/providers/UserProvider.dart';
import 'package:rupay/repositories/UserRepository.dart';

class DeviceBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DeviceController>(() => DeviceController());

    Get.lazyPut<UserRepository>(() => UserRepository(Get.find()));
    Get.lazyPut<UserProvider>(() => UserProvider(Get.find()));
  }
}
