import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rupay/constants/AccountConstants.dart';
import 'package:rupay/essential/Essential.dart';
import 'package:rupay/models/account/AccountModel.dart';
import 'package:rupay/providers/AccountProvider.dart';
import 'package:rupay/repositories/AccountRepository.dart';
import 'package:rupay/services/networking/ApiConstants.dart';
import 'package:rupay/services/networking/ApiService.dart';
import 'package:rupay/shared/widgets/bottomSheets/SelectOption.dart';

class CustomerController extends GetxController {
  CustomerController();

  final storage = GetStorage();

  final AccountRepository accountRepository = Get.put(AccountRepository(Get.put(ApiService(Get.find()), permanent: true)));
  late AccountProvider accountProvider;

  late List<AccountModel> customers = [];
  late List<AccountModel> show = [];
  late List<AccountModel> temp = [];

  late TextEditingController search;

  List<String> option = ['Sales', 'Ledger', 'Outstanding'];
  String? selected;

  late bool load;

  @override
  void onInit() {
    super.onInit();
    search = TextEditingController();
   customers = [];
   show = [];
   temp = [];
    load = false;
    accountProvider = Get.put(AccountProvider(accountRepository));
    start();
  }

  void start() {
    getCustomers();
  }

  void getCustomers() {
    accountProvider.fetch(storage.read("access"), ApiConstants.customerAPI).then((response) async {
      print(response.data?.length??0);
      if(response.code==1) {
        customers = response.data??[];

        show = [];
        show.addAll(customers);
        load = true;
        print(temp);
        // if(temp.isNotEmpty) {
        //   for (var element in show) {
        //     for (var ele in temp) {
        //       // if(title.contains("Company")) {
        //       //   if(ele.COCODE==element.COCODE) {
        //       //     print("hello");
        //       //     selected.add(element);
        //       //   }
        //       // }
        //       // else {
        //         if(ele.CODE==element.CODE) {
        //           selected.add(element);
        //         }
        //       // }
        //     }
        //   }
        // }
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

  void searchCustomer() {
    print(search.text);
    if(search.text.isEmpty) {
      show = [];
      show.addAll(customers);
    }
    else {
      show = [];
      for (var element in customers) {
        if(element.NAME.toLowerCase().contains(search.text.toLowerCase())) {
          show.add(element);
        }
      }
    }
    print(show);
    update();
  }

  void chooseOption(BuildContext context, AccountModel customer) {
    Get.bottomSheet(
      SelectOption(option, selected),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      isDismissible: false,
    ).then((value) {
      print(value);
      if(value!=null) {
        if(value=="Sales") {
          goto("/sales", arguments: {"customer" : customer});
        }
        else if(value=="Ledger") {
          goto("/ledger", arguments: {"customer" : customer});
        }
        else if(value=="Outstanding") {
          goto("/outstandingPayment", arguments: {"customer" : customer, "type" : "SALES"});
        }
      }
    });
  }
}
