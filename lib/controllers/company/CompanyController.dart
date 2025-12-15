import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rupay/essential/Essential.dart';
import 'package:rupay/models/company/CompanyModel.dart';
import 'package:rupay/providers/CompanyProvider.dart';
import 'package:rupay/providers/UserProvider.dart';
import 'package:rupay/services/networking/ApiConstants.dart';

class CompanyController extends GetxController {
  CompanyController();

  final storage = GetStorage();

  late CompanyProvider companyProvider = Get.find();
  late UserProvider userProvider = Get.find();

  List<CompanyModel> companies = [];
  CompanyModel? company;

  late bool load;
  late bool back;

  @override
  void onInit() {
    super.onInit();
    back = Get.arguments!=null ? Get.arguments['back']??false : false;
    if(Get.arguments!=null) {
      load = true;
      companies = Get.arguments['company']??[];

      if(storage.read("company")!=null) {
        company = storage.read("company") is CompanyModel ? storage.read("company") : CompanyModel.fromJson(storage.read("company"));
        for (var element in companies) {
          if(element.CODE==(company?.CODE??"") && element.UID==(company?.UID??"")) {
            company = element;
            break;
          }
        }
      }
    }
    else {
      load = false;
      companies = [];
    }
    start();
  }

  void start() {
    getCompanies();
  }

  void startLoad() {
    load = false;
    update();
  }

  void getCompanies() {
    companyProvider.fetch(storage.read("access"), ApiConstants.all).then((response) async {
      print(response.toJson());

      if(response.code==1) {
        companies = response.data??[];
        if(storage.read("company")!=null) {
          company = storage.read("company") is CompanyModel ? storage.read("company") : CompanyModel.fromJson(storage.read("company"));
          for (var element in companies) {
            if(element.CODE==(company?.CODE??"") && element.UID==(company?.UID??"")) {
              company = element;
              break;
            }
          }
        }
      }
      else {
        Essential.showSnackBar(response.message);
      }
      load = true;
      update();
    });
  }

  void manageCompany(CompanyModel company) {
    this.company = company;
    storage.write("company", company);
    update();
    print("hellliiii");
    // if(back) {
    //   Get.back(result: "update");
    // }
    // else {
      goto("/home");
    // }
  }

  goto(String path, {dynamic arguments}) {
    Get.offAllNamed(path, arguments: arguments);
  }

  @override
  void dispose() {
    super.dispose();
  }


  void logout() async {
    if(await Essential.popUp("Are you sure you want to logout?", "Logout", "Cancel")) {
      userProvider.logout(storage.read("access"), ApiConstants.logout).then((response) async {
        print(response.toJson());
        Essential.logout();
      });
    }
  }
}
