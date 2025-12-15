import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:rupay/colors/MyColors.dart';
import 'package:rupay/essential/Essential.dart';
import 'package:rupay/models/account/AccountModel.dart';
import 'package:rupay/models/company/CompanyModel.dart';
import 'package:rupay/models/order/OrderModel.dart';
import 'package:rupay/providers/AccountProvider.dart';
import 'package:rupay/providers/OrderProvider.dart';
import 'package:rupay/services/networking/ApiConstants.dart';
import 'package:rupay/shared/widgets/bottomSheets/SelectOption.dart';

class OrderController extends GetxController {
  OrderController();

  final storage = GetStorage();

  late OrderProvider orderProvider = Get.find();
  late AccountProvider accountProvider = Get.find();

  List<OrderModel> orders = [];
  List<OrderModel> orders_temp = [];
  List<OrderModel> show = [];
  List<AccountModel> customers = [];
  late TextEditingController search;

  late DateTime sd;
  late DateTime ed;

  List<String> filters = [];
  List<String> dateFilter = ['Today', 'This Week', 'Last 30 Days', 'This Quarter', 'This Fin. Year', 'Custom'];
  late String selectedDF;

  late double amount;
  late bool load;

  late CompanyModel company;
  
  @override
  void onInit() {
    super.onInit();

    company = storage.read("company");
    filters.insertAll(0, ['Customer']);

    amount = 0;
    search = TextEditingController();
    load = true;

    selectedDF = dateFilter[2];
    DateTime date = DateTime.now();
    ed = DateTime(date.year, date.month, date.day);
    sd = ed.subtract(Duration(days: 30));
    // sd = DateTime(date.year, date.month);
    // ed = DateTime(date.year, date.month+1).subtract(Duration(days: 1));

    // start();
  }

  void start() {
    getOrders();
  }

  void getOrders() {
    load = false;
    update();

    Map<String, String> data = {
      ApiConstants.start_date : DateFormat("yyyy-MM-dd").format(sd),
      ApiConstants.end_date : DateFormat("yyyy-MM-dd").format(ed),
      // ApiConstants.where : "${getCustomerString()}"
      ApiConstants.where : getCustomerString()
    };
    print(data);
    
    orderProvider.fetchByColumn(storage.read("access"), ApiConstants.filter, data).then((response) async {
      print(response.toJson());
      if(response.code==1) {
        orders = response.data??[];

        update();
        searchOrders();
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

  void searchOrders() {
    amount = 0;
    print(search.text);
    if(search.text.isEmpty) {
      orders_temp = [];
      // if(status.isNotEmpty) {
      //   for (var element in orders) {
      //     if(status.contains(element.PendingStatus) || (status.contains("PART PENDING") && (element.PendingStatus??"").contains("PART PENDING"))) {
      //       orders_temp.add(element);
      //       amount += element.TAXABLEAMT??0;
      //     }
      //   }
      // }
      // else {
        orders_temp.addAll(orders);
        for (var element in orders) {
          amount += element.InvAmount??0;
        }
      // }
    }
    else {
      orders_temp = [];
      for (var element in orders) {
        // if((element.LRNO??"").toLowerCase() == search.text.toLowerCase() || (element.DOCNUMBER??"").trim().toLowerCase() == search.text.toLowerCase()) {
        //   if(status.isNotEmpty) {
        //     if (status.contains(element.PendingStatus) || (status.contains("PART PENDING") && (element.PendingStatus ?? "").contains("PART PENDING"))) {
        //       orders_temp.add(element);
        //       amount += element.TAXABLEAMT??0;
        //     }
        //   }
        //   else {
            orders_temp.add(element);
            amount += element.InvAmount??0;
        //   }
        // }
      }
    }
    print(orders_temp);
    update();
    getShowUpdate(0);
  }


  goto(String path, {dynamic arguments}) {
    print(path);
    Get.toNamed(path, arguments: arguments)?.then((value) {
      if(value!=null) {
        // if(arguments['title'].contains("Company")) {
        //   companies = value;
        // }
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

  List<AccountModel> getList(int index) {
    if(index==0) {
      return customers;
    }
    return [];
    // else {
    //   return companies;
    // }
  }

  void removeCustomer(AccountModel customer) {
    customers.remove(customer);
    update();
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

  String getCustomerString() {
    String where = "";

    for (var element in customers) {
      where+=", '${element.CODE}'";
    }
    return where.isNotEmpty ? " AND AccountCode IN (${where.substring(2)})" : "";
  }

  void getShowUpdate(int i) {
    print(i);
    if(i==0) {
      show = [];
    }
    show.addAll(orders_temp.sublist(i, orders_temp.length<=(i+30) ? orders_temp.length : (i+30)));
    print(show.length);
    load = true;
    update();
  }
}
