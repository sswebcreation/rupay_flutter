import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SelectOptionController extends GetxController {
  SelectOptionController();

  final storage = GetStorage();
  // List<String> dateFilter = ['Today', 'This Week', 'Last 30 Days', 'This Quarter', 'This Fin. Year', 'Custom'];
  late List<String> dateFilter;
  String? selectedDF;


  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void manageSelectOption(String option) {
    selectedDF = option;
    update();
    select();
  }

  void select() {
    Get.back(result: selectedDF);
  }

}
