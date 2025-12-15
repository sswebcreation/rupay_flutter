import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rupay/constants/AccountConstants.dart';
import 'package:rupay/essential/Essential.dart';
import 'package:rupay/models/account/AccountModel.dart';
import 'package:rupay/providers/AccountProvider.dart';
import 'package:rupay/services/networking/ApiConstants.dart';

class AccountController extends GetxController {
  AccountController();

  final storage = GetStorage();

  late AccountProvider accountProvider = Get.find();

  List<AccountModel> accounts = [];
  List<AccountModel> show = [];
  List<AccountModel> selected = [];
  List<AccountModel> temp = [];

  late TextEditingController search;
  late bool load;
  late String type;
  late String title;

  @override
  void onInit() {
    super.onInit();
    title = Get.arguments['title']??"Accounts";
    temp = Get.arguments['list'];
    type = Get.arguments['type']??"";
    search = TextEditingController();
    load = false;
    show = [];
    accounts = [];
    start();
  }

  void start() {
    getAccounts();
  }

  void getAccounts() {
    accountProvider.fetch(storage.read("access"), ApiConstants.customerAPI+type).then((response) async {
      print(response.toJson());

      if(response.code==1) {
        accounts = response.data??[];
        print(accounts.length);

        show = [];
        show.addAll(accounts);
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

  void manageAccount(bool? value, AccountModel account) {
    if(value!=null) {
      if (value == true) {
        selected.add(account);
      }
      else if (value == false) {
        selected.remove(account);
      }
      update();
    }
  }

  void searchAccount() {
    if(search.text.isEmpty) {
      show = [];
      show.addAll(accounts);
    }
    else {
      show = [];
      for (var element in accounts) {
        if(element.NAME.toLowerCase().contains(search.text.toLowerCase())) {
          show.add(element);
        }
      }
    }
    update();
  }
}
