import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:rupay/essential/Essential.dart';
import 'package:rupay/models/account/AccountModel.dart';
import 'package:rupay/models/company/CompanyModel.dart';
import 'package:rupay/models/daybook/DaybookModel.dart';
import 'package:rupay/models/sales/SalesModel.dart';
import 'package:rupay/providers/SalesProvider.dart';
import 'package:rupay/services/networking/ApiConstants.dart';
import 'package:rupay/shared/widgets/bottomSheets/MultiSelectOption.dart';
import 'package:rupay/shared/widgets/bottomSheets/SelectOption.dart';
import 'package:rupay/shared/widgets/bottomSheets/SelectOptionDone.dart';

class SalesController extends GetxController {
  SalesController();

  final storage = GetStorage();

  final SalesProvider salesProvider = Get.find();


  List<SalesModel> sales = [];
  List<SalesModel> sales_temp = [];
  List<SalesModel> selected_sales = [];
  List<SalesModel> show = [];
  List<AccountModel> customers = [];
  List<DaybookModel> daybooks = [];
  List<String> status = [];
  late TextEditingController search;
  late CompanyModel company;


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

  late String type;

  @override
  void onInit() {
    super.onInit();
    company = storage.read("company");
    search = TextEditingController();
    load = true;
    loaded = false;
    selected_sales = [];

    filters.insertAll(0, ['Customer']);
    print(Get.arguments);
    try {
      if (Get.arguments != null) {
        customers = [Get.arguments?['customer']];
      }
    }
    catch(ex) {
      customers = [];
    }
    type = Get.arguments?['type']??"";

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
    getSales();
  }

  void getSales() {
    load = false;
    selected_sales = [];
    update();
    Map<String, String> data = {
      ApiConstants.start_date : DateFormat("yyyy-MM-dd").format(sd),
      ApiConstants.end_date : DateFormat("yyyy-MM-dd").format(ed),
      ApiConstants.where : getCustomerString()+getDaybookString()
    };
    print(data);
    print(storage.read("access"));

    salesProvider.fetchByColumn(storage.read("access"), type+ApiConstants.filter, data).then((response) async {
      print(response.toJson());
      if(response.code==1) {
        sales = response.data??[];

        update();
        searchSales();
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

  void searchSales() {
    amount = 0;
    print(search.text);
    if(search.text.isEmpty) {
      sales_temp = [];
      if(status.isNotEmpty) {
        for (var element in sales) {
          if(status.contains(element.PendingStatus) || (status.contains("PART PENDING") && (element.PendingStatus??"").contains("PART PENDING"))) {
            sales_temp.add(element);
            amount += element.NETAMOUNT??0;
          }
        }
      }
      else {
        sales_temp.addAll(sales);
        for (var element in sales) {
          amount += element.NETAMOUNT??0;
        }
      }
    }
    else {
      sales_temp = [];
      for (var element in sales) {
        if((element.LRNO??"").toLowerCase() == search.text.toLowerCase() || (element.DOCNUMBER??"").trim().toLowerCase() == search.text.toLowerCase() || (element.ACCOUNTNAME??"").trim().toLowerCase().contains(search.text.toLowerCase())) {
          if(status.isNotEmpty) {
            if (status.contains(element.PendingStatus) || (status.contains("PART PENDING") && (element.PendingStatus ?? "").contains("PART PENDING"))) {
              sales_temp.add(element);
              amount += element.NETAMOUNT??0;
            }
          }
          else {
            sales_temp.add(element);
            amount += element.NETAMOUNT??0;
          }
        }
      }
    }
    print(sales_temp);
    update();
    getShowUpdate(0);
  }


  goto(String path, {dynamic arguments}) {
    print(path);
    Get.toNamed(path, arguments: arguments)?.then((value) {
      if(value!=null) {
        if(path.contains("account")) {
          customers = value;
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

  void removeDaybook(DaybookModel daybook) {
    daybooks.remove(daybook);
    update();
  }

  void removeCustomer(AccountModel customer) {
    customers.remove(customer);
    update();
  }

  void removeStatus(String option) {
    status.remove(option);
    update();
    searchSales();
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
    show.addAll(sales_temp.sublist(i, sales_temp.length<=(i+30) ? sales_temp.length : (i+30)));
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
        searchSales();
      }
    });
  }

  void choosePDFType(BuildContext context) {
    if(selected_sales.isEmpty) {
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
              ? "/multiSalesPDF"
              : "/multiLISalesPDF",
              arguments: {"sales": sales_temp, "sd": sd, "ed": ed});
        }
      });
    }
    else {
      goto("/singleSalesPDF", arguments: {"selected" : selected_sales, "type" : "M", "entryType" : type});
    }
  }

  void changeSelectedSales(SalesModel sale) {
    if(selected_sales.contains(sale)) {
      selected_sales.remove(sale);
    }
    else {
      selected_sales.add(sale);
    }
    update();
  }

  void changeSelectAll() {
    if(selected_sales.length==sales_temp.length) {
      selected_sales = [];
    }
    else {
      selected_sales = [];
      selected_sales.addAll(sales_temp);
    }
    update();
  }

  Future<void> confirmDelete() async {
    if(await Essential.popUp("Are you sure you want to delete this sales?", "Yes", "No")) {
      delete();
    }
  }

  void delete() {
    load = false;
    update();

    Map<String, String> data = {
      "id" : getSalesIDs()
    };

    salesProvider.deleteMultiple(ApiConstants.delete, storage.read("access"), data).then((response) async {
      print(response.toJson());

      if(response.code==1) {
        getSales();
      }
      else {
        load = true;
        update();
        Essential.showSnackBar(response.message);
      }
    });
  }

  String getSalesIDs() {
    String id = "";
    for (var element in selected_sales) {
      id+=",${element.ID}";
    }
    return id.isNotEmpty ? id.substring(1) : "";
  }
}
