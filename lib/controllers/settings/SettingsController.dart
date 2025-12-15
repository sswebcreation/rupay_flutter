import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rupay/constants/CommonConstants.dart';
import 'package:rupay/essential/Essential.dart';
import 'package:rupay/models/company/CompanyModel.dart';
import 'package:rupay/providers/UserProvider.dart';
import 'package:rupay/repositories/UserRepository.dart';
import 'package:rupay/services/networking/ApiConstants.dart';
import 'package:rupay/services/networking/ApiService.dart';


class SettingsController extends GetxController {
  SettingsController();

  final storage = GetStorage();

  late CompanyModel company;
  final UserRepository userRepository = Get.put(UserRepository(Get.put(ApiService(Get.find()), permanent: true)));
  late UserProvider userProvider;

  @override
  void onInit() {
    super.onInit();
    userProvider = Get.put(UserProvider(userRepository));
    if(storage.read("company")!=null) {
      company = storage.read("company");
    }
    // Essential.logout();
  }

  @override
  void dispose() {
    super.dispose();
  }

  goto(String path, {dynamic arguments}) {
    print(path);
    Get.toNamed(path, arguments: arguments)?.then((value) {
      if(value=="update") {
        company = storage.read("company");
      }
    });
  }

  void logout() async {
    if(await Essential.popUp("Are you sure you want to logout?", "Logout", "Cancel")) {
      userProvider.logout(storage.read("access"), ApiConstants.logout).then((response) async {
        print(response.toJson());
        Essential.logout();
      });
    }
  }

  void delete() async {
    if(await Essential.popUp("Are you sure you want to delete your account?", "Yes", "No")) {
      Essential.process("Deleting Account");
      Future.delayed(Duration(seconds: 3), () async {
        print("ghdvcgh");
        Get.back();
        storage.write("delete", true);
        await Essential.inform("Your account has been deleted successfully.", "OK").then((value) {
          Essential.logout();
        });

      });
    }

  }

}
