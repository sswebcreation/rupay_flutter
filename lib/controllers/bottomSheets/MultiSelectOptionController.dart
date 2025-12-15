import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class MultiSelectOptionController extends GetxController {
  MultiSelectOptionController();

  final storage = GetStorage();
  late List<String> filter;
  late List<String> selected;


  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void manageAccount(bool? value, String option) {
    if(value!=null) {
      if (value == true) {
        selected.add(option);
      }
      else if (value == false) {
        selected.remove(option);
      }
      update();
    }
  }

  void select() {
    Get.back(result: selected);
  }

}
