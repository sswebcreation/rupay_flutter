import 'package:get/get.dart';
import 'package:rupay/controllers/rateList/RateListController.dart';
class RateListBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RateListController>(() => RateListController());
  }
}
