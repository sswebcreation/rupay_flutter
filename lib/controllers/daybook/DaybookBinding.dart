import 'package:get/get.dart';
import 'package:rupay/controllers/daybook/DaybookController.dart';
import 'package:rupay/providers/DaybookProvider.dart';
import 'package:rupay/repositories/DaybookRepository.dart';

class DaybookBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DaybookController>(() => DaybookController());

    Get.lazyPut<DaybookRepository>(() => DaybookRepository(Get.find()));
    Get.lazyPut<DaybookProvider>(() => DaybookProvider(Get.find()));
  }
}
