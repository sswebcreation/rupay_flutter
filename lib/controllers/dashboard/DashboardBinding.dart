import 'package:get/get.dart';
import 'package:rupay/controllers/dashboard/DashboardController.dart';
import 'package:rupay/controllers/dashboard/NewDashboardController.dart';
import 'package:rupay/providers/OutstandingProvider.dart';
import 'package:rupay/repositories/OutstandingRepository.dart';

class DashboardBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(() => DashboardController());
    Get.lazyPut<NewDashboardController>(() => NewDashboardController());

    // Get.lazyPut<CategoryRepository>(() => CategoryRepository(Get.find()));
    // Get.lazyPut<CategoryProvider>(() => CategoryProvider(Get.find()));
  }
}
