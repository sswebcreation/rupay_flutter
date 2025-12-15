import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SelectOptionDoneController extends GetxController {
  SelectOptionDoneController();

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

  void manageSelectOptionDone(String option) {
    selectedDF = option;
    update();
  }

  void select() {
    Get.back(result: selectedDF);
  }

}
