import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rupay/essential/Essential.dart';
import 'package:rupay/models/company/CompanyModel.dart';
import 'package:rupay/providers/CompanyProvider.dart';
import 'package:rupay/services/networking/ApiConstants.dart';

class SelectCompanyController extends GetxController {
  SelectCompanyController();

  final storage = GetStorage();

  late CompanyProvider companyProvider = Get.find();

  List<CompanyModel> companies = [];
  List<CompanyModel> show = [];
  List<CompanyModel> selected = [];
  List<CompanyModel> temp = [];

  late TextEditingController search;
  late bool load;
  late String type;
  late String title;

  @override
  void onInit() {
    super.onInit();
    title = Get.arguments['title']??"Companies";
    temp = Get.arguments['list'];
    type = Get.arguments['type']??"";
    search = TextEditingController();
    load = false;
    show = [];
    companies = [];
    start();
  }

  void start() {
    getCompanies();
  }

  void getCompanies() {
    companyProvider.fetch(storage.read("access"), ApiConstants.all).then((response) async {
      print(response.toJson());

      if(response.code==1) {
        companies = response.data??[];
        print(companies.length);

        show = [];
        show.addAll(companies);
        print(temp);
        if(temp.isNotEmpty) {
          for (var element in show) {
            for (var ele in temp) {
              // if(title.contains("Company")) {
              //   if(ele.COCODE==element.COCODE) {
              //     print("hello");
              //     selected.add(element);
              //   }
              // }
              // else {
              if(ele.CODE==element.CODE) {
                selected.add(element);
              }
              // }
            }
          }
        }
        load = true;
        update();
      }
      // else if(response.code==-1) {
      //   await Essential.getNewAccessToken();
      // }
      else {
        load = true;
        update();
        Essential.showSnackBar(response.message);
      }
    });
  }

  goto(String path, {dynamic arguments}) {
    print(path);
    Get.toNamed(path, arguments: arguments);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void manageCompany(bool? value, CompanyModel company) {
    if(value!=null) {
      if (value == true) {
        selected.add(company);
      }
      else if (value == false) {
        selected.remove(company);
      }
      update();
    }
  }

  void searchCompany() {
    if(search.text.isEmpty) {
      show = [];
      show.addAll(companies);
    }
    else {
      show = [];
      for (var element in companies) {
        if(element.NAME.toLowerCase().contains(search.text.toLowerCase())) {
          show.add(element);
        }
      }
    }
    update();
  }
}
