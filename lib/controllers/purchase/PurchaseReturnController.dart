import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:rupay/essential/Essential.dart';
import 'package:rupay/models/account/AccountModel.dart';
import 'package:rupay/models/company/CompanyModel.dart';
import 'package:rupay/models/daybook/DaybookModel.dart';
import 'package:rupay/models/purchase/PurchaseModel.dart';
import 'package:rupay/providers/PurchaseReturnProvider.dart';
import 'package:rupay/services/networking/ApiConstants.dart';
import 'package:rupay/shared/widgets/bottomSheets/MultiSelectOption.dart';
import 'package:rupay/shared/widgets/bottomSheets/SelectOption.dart';
import 'package:rupay/shared/widgets/bottomSheets/SelectOptionDone.dart';

class PurchaseReturnController extends GetxController {
  PurchaseReturnController();

  final storage = GetStorage();

  final PurchaseReturnProvider purchaseReturnProvider = Get.find();


  List<PurchaseModel> purchases = [];
  List<PurchaseModel> purchases_temp = [];
  List<PurchaseModel> selected_purchases = [];
  List<PurchaseModel> show = [];
  List<AccountModel> customers = [];
  List<DaybookModel> daybooks = [];
  List<String> status = [];
  late TextEditingController search;


  late DateTime sd;
  late DateTime ed;

  List<String> filters = ['Daybook', 'Status'];
  List<String> dateFilter = ['Today', 'This Week', 'Last 30 Days', 'This Quarter', 'This Fin. Year', 'Custom'];
  List<String> statusFilter = ['CLEAR', 'PART PENDING', 'FULL PENDING'];
  List<String> selected = ['CLEAR', 'PART PENDING', 'FULL PENDING'];
  late String selectedDF;

  late double amount;

  List<String> pdfType = ['With Line Items', 'Without Line Items'];
  late bool load;
  late bool loaded;
  late CompanyModel company;

  @override
  void onInit() {
    super.onInit();
    company = storage.read("company");
    search = TextEditingController();
    load = true;
    loaded = false;
    selected_purchases = [];

    filters.insertAll(0, ['Vendor']);
    print(Get.arguments);
    if(Get.arguments!=null) {
      customers = [Get.arguments?['customer']];
    }

    daybooks = [];

    amount = 0;

    DateTime date = DateTime.now();

    int year = 0;
    if(date.month<4) {
      year = 1;
    }
    DateTime finDate = DateTime(date.year-year, 4);
    List<String> years = company.YEAR.split("-");


    if(int.parse(years[0])!=finDate.year) {
      selectedDF = dateFilter[4];

      sd = DateTime(int.parse(years[0]), 4);
      ed = DateTime(int.parse(years[1]), 3, 31);
    }
    else {
      selectedDF = dateFilter[2];

      ed = DateTime(date.year, date.month, date.day);
      sd = ed.subtract(const Duration(days: 30));
    }

    // sd = DateTime(date.year, date.month);
    // ed = DateTime(date.year, date.month+1).subtract(Duration(days: 1));

    // start();
  }

  void start() {
    getPurchase();
  }

  void getPurchase() {
    load = false;
    selected_purchases = [];
    update();
    Map<String, String> data = {
      ApiConstants.start_date : DateFormat("yyyy-MM-dd").format(sd),
      ApiConstants.end_date : DateFormat("yyyy-MM-dd").format(ed),
      ApiConstants.where : getCustomerString()+getDaybookString()
    };
    print(data);
    print(storage.read("access"));

    purchaseReturnProvider.fetchByColumn(storage.read("access"), ApiConstants.filter, data).then((response) async {
      print(response.toJson());
      if(response.code==1) {
        purchases = response.data??[];

        update();
        searchPurchase();
      }
      // else if(response.code==-1) {
      //   await Essential.getNewAccessToken();
      // }
      else {
        load = true;
        loaded = true;
        update();
        Essential.showSnackBar(response.message);
      }
    });
  }

  void searchPurchase() {
    amount = 0;
    print(search.text);
    if(search.text.isEmpty) {
      purchases_temp = [];
      if(status.isNotEmpty) {
        for (var element in purchases) {
          if(status.contains(element.PendingStatus) || (status.contains("PART PENDING") && (element.PendingStatus??"").contains("PART PENDING"))) {
            purchases_temp.add(element);
            amount += element.NETAMOUNT??0;
          }
        }
      }
      else {
        purchases_temp.addAll(purchases);
        for (var element in purchases) {
          amount += element.NETAMOUNT??0;
        }
      }
    }
    else {
      purchases_temp = [];
      for (var element in purchases) {
        if((element.DOCNUMBER??"").trim().toLowerCase() == search.text.toLowerCase()  || (element.ACCOUNTNAME??"").trim().toLowerCase().contains(search.text.toLowerCase())) {
          if(status.isNotEmpty) {
            if (status.contains(element.PendingStatus) || (status.contains("PART PENDING") && (element.PendingStatus ?? "").contains("PART PENDING"))) {
              purchases_temp.add(element);
              amount += element.NETAMOUNT??0;
            }
          }
          else {
            purchases_temp.add(element);
            amount += element.NETAMOUNT??0;
          }
        }
      }
    }
    print(purchases_temp);
    update();
    getShowUpdate(0);
  }


  goto(String path, {dynamic arguments}) {
    print(path);
    Get.toNamed(path, arguments: arguments)?.then((value) {
      if(value!=null) {
        if(path.contains("account")) {
          if (arguments['title'].contains("Vendor")) {
            customers = value;
          }
        }
        if(path.contains("daybook")) {
          daybooks = value;
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
      shape: const RoundedRectangleBorder(
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
      sd = ed.subtract(const Duration(days: 30));
      // sd = DateTime(date.year, date.month);
      // ed = DateTime(date.year, date.month+1).subtract(Duration(days: 1));
    }
    else if(value=="This Quarter") {
      DateTime date = DateTime.now();
      int quarter = (date.month/3).ceil();
      sd = DateTime(date.year, (quarter*3)-2);
      ed = DateTime(date.year, (quarter*3)+1).subtract(const Duration(days: 1));
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

  List<DaybookModel> getDaybookList(int index) {
    if(index==0) {
      return daybooks;
    }
    else {
      return daybooks;
    }
  }

  void removeCustomer(AccountModel customer) {
    customers.remove(customer);
    update();
  }

  void removeDaybook(DaybookModel daybook) {
    daybooks.remove(daybook);
    update();
  }

  void removeStatus(String option) {
    status.remove(option);
    update();
    searchPurchase();
  }

  String getCustomerString() {
    String where = "";

    for (var element in customers) {
      where+=", '${element.CODE}'";
    }
    return where.isNotEmpty ? " AND sa.ACCOUNTCODE IN (${where.substring(2)})" : "";
  }

  String getDaybookString() {
    String where = "";

    for (var element in daybooks) {
      where+=", '${element.DAYBOOK}'";
    }
    return where.isNotEmpty ? " AND sa.DAYBOOK IN (${where.substring(2)})" : "";
  }

  void getShowUpdate(int i) {
    print(i);
    if(i==0) {
      show = [];
    }
    show.addAll(purchases_temp.sublist(i, purchases_temp.length<=(i+30) ? purchases_temp.length : (i+30)));
    load = true;
    loaded = true;
    update();
  }

  void chooseStatus(BuildContext context) {
    Get.bottomSheet(
      MultiSelectOption(statusFilter, status),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      isDismissible: false,
    ).then((value) {
      print(value);
      if(value!=null) {
        status = value;
        update();
        searchPurchase();
      }
    });
  }

  void choosePDFType(BuildContext context) {
    if(selected_purchases.isEmpty) {
      Get.bottomSheet(
        SelectOptionDone(pdfType, pdfType.first),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        ),
        isDismissible: false,
      ).then((value) {
        print(value);
        if (value != null) {
          goto(value.toString().contains("Without")
              ? "/multiPurchasePDF"
              : "/multiLIPurchasePDF",
              arguments: {"purchases": purchases_temp, "sd": sd, "ed": ed});
        }
      });
    }
    else {
      goto("/singlePurchasePDF", arguments: {"selected" : selected_purchases, "type" : "M"});
    }
  }

  void changeSelectedPurchase(PurchaseModel sale) {
    if(selected_purchases.contains(sale)) {
      selected_purchases.remove(sale);
    }
    else {
      selected_purchases.add(sale);
    }
    update();
  }

  void changeSelectAll() {
    if(selected_purchases.length==purchases_temp.length) {
      selected_purchases = [];
    }
    else {
      selected_purchases = [];
      selected_purchases.addAll(purchases_temp);
    }
    update();
  }
}
