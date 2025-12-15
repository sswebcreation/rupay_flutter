import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:rupay/essential/Essential.dart';
import 'package:rupay/models/account/AccountModel.dart';
import 'package:rupay/models/company/CompanyModel.dart';
import 'package:rupay/models/voucher/VoucherModel.dart';
import 'package:rupay/providers/AccountProvider.dart';
import 'package:rupay/providers/VoucherProvider.dart';
import 'package:rupay/repositories/AccountRepository.dart';
import 'package:rupay/repositories/VoucherRepository.dart';
import 'package:rupay/services/networking/ApiConstants.dart';
import 'package:rupay/services/networking/ApiService.dart';
import 'package:rupay/shared/widgets/bottomSheets/SelectOption.dart';

class VoucherController extends GetxController {
  VoucherController();

  final storage = GetStorage();

  final VoucherRepository voucherRepository = Get.put(VoucherRepository(Get.put(ApiService(Get.find()), permanent: true)));
  late VoucherProvider voucherProvider;

  final AccountRepository accountRepository = Get.put(AccountRepository(Get.put(ApiService(Get.find()), permanent: true)));
  late AccountProvider accountProvider;


  List<VoucherModel> vouchers = [];
  List<AccountModel> customers = [];

  late DateTime sd;
  late DateTime ed;

  List<String> filters = [];
  List<String> dateFilter = ['Today', 'This Week', 'Last 30 Days', 'This Quarter', 'This Fin. Year', 'Custom'];
  late String selectedDF;

  late CompanyModel company;

  @override
  void onInit() {
    super.onInit();

    company = storage.read("company");
    filters.insertAll(0, ['Customer']);

    selectedDF = dateFilter[2];
    DateTime date = DateTime.now();
    ed = DateTime(date.year, date.month, date.day);
    sd = ed.subtract(Duration(days: 30));
    // sd = DateTime(date.year, date.month);
    // ed = DateTime(date.year, date.month+1).subtract(Duration(days: 1));

    voucherProvider = Get.put(VoucherProvider(voucherRepository));
    accountProvider = Get.put(AccountProvider(accountRepository));

    start();
  }

  void start() {
    // getVouchers();
  }

  void getVouchers() {
    voucherProvider.fetch(storage.read("access"), ApiConstants.all).then((response) async {
      print(response.toJson());
      if(response.code==1) {
        vouchers = response.data??[];
        update();
      }
      else if(response.code==-1) {
        await Essential.getNewAccessToken();
      }
      else {
        Essential.showSnackBar(response.message);
      }
    });
  }

  goto(String path, {dynamic arguments}) {
    print(path);
    Get.toNamed(path, arguments: arguments)?.then((value) {
      if(value!=null) {
        if(arguments['title'].contains("Customer")) {
          customers = value;
        }
        update();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void setDate(DateTime date, String type) {
    if(type=="sd") {
      sd = date;
    }
    else {
      ed = date;
    }
    update();
  }

  String getDateText(DateTime date) {
    return DateFormat("dd MMM, yyyy").format(date);
  }

  void chooseDateFilter(BuildContext context) {
    Get.bottomSheet(
      SelectOption(dateFilter, selectedDF),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      isDismissible: false,
    ).then((value) {
      print(value);
      if(value!=null && value!=selectedDF) {
        changeDates(value);
      }
    });
  }

  void changeDates(String value) {
    selectedDF = value;
    print(value);
    if(value=="Today") {
      sd = DateTime.now();
      ed = DateTime.now();
    }
    else if(value=="This Week") {
      DateTime date = DateTime.now();
      sd = date.subtract(Duration(days: date.weekday - 1));
      ed = date.add(Duration(days: DateTime.daysPerWeek - date.weekday));
    }
    else if(value=="Last 30 Days") {
      DateTime date = DateTime.now();
      ed = DateTime(date.year, date.month, date.day);
      sd = ed.subtract(Duration(days: 30));
      // sd = DateTime(date.year, date.month);
      // ed = DateTime(date.year, date.month+1).subtract(Duration(days: 1));
    }
    else if(value=="This Quarter") {
      DateTime date = DateTime.now();
      int quarter = (date.month/3).ceil();
      sd = DateTime(date.year, (quarter*3)-2);
      ed = DateTime(date.year, (quarter*3)+1).subtract(Duration(days: 1));
    }
    else if(value=="This Fin. Year") {
      List<String> years = company.YEAR.split("-");

      sd = DateTime(int.parse(years[0]), 4);
      ed = DateTime(int.parse(years[1]), 3, 31);
    }
    update();
  }

  List<AccountModel> getList(int index) {
    if(index==0) {
      return customers;
    }
    else {
      return customers;
    }
  }

  void removeCustomer(AccountModel customer) {
    customers.remove(customer);
    update();
  }
}
