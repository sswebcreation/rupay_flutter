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
import 'package:rupay/models/outstanding/OutstandingModel.dart';
import 'package:rupay/providers/AccountProvider.dart';
import 'package:rupay/providers/OutstandingProvider.dart';
import 'package:rupay/services/networking/ApiConstants.dart';
import 'package:rupay/shared/widgets/bottomSheets/SelectOption.dart';

class OutstandingPaymentController extends GetxController {
  OutstandingPaymentController();

  final storage = GetStorage();

  late OutstandingProvider outstandingProvider = Get.find();
  late AccountProvider accountProvider = Get.find();

  List<OutstandingModel> outstandings = [];
  List<OutstandingModel> outstandings_temp = [];
  List<OutstandingModel> show = [];
  List<AccountModel> customers = [];

  late DateTime sd;
  late DateTime ed;

  List<String> filters = [];
  List<String> dateFilter = ['Today', 'This Week', 'Last 30 Days', 'This Quarter', 'This Fin. Year', 'Custom'];
  late String selectedDF;

  late double amount;
  late double os;

  late TextEditingController search;
  late bool load;
  late bool loaded;
  late String type;

  late CompanyModel company;

  @override
  void onInit() {
    super.onInit();
    company = storage.read("company");
    search = TextEditingController();
    load = true;
    loaded = false;

    amount = os = 0;

    print(Get.arguments);
    if(Get.arguments!=null) {
      if(Get.arguments['customer']!=null) {
        customers = [Get.arguments?['customer']];
      }
      type = Get.arguments['type'];
    }

    filters.insertAll(0, [type.toLowerCase()=="sales" ? 'Customer' : 'Vendor']);

    selectedDF = dateFilter.last;
    sd = DateTime(2010, 04, 01);
    ed = DateTime.now();
    
    // start();
  }

  void start() {
    // getOutstandings();
  }

  void getOutstandings() {
    load = false;
    update();

    Map<String, String> data = {
      ApiConstants.start_date : DateFormat("yyyy-MM-dd").format(sd),
      ApiConstants.end_date : DateFormat("yyyy-MM-dd").format(ed),
      ApiConstants.where : "${getCustomerString()} AND os.TYP = '${type.toUpperCase()}'"
    };
    print(data);
    
    outstandingProvider.fetchByColumn(storage.read("access"), ApiConstants.filter, data).then((response) async {
      print(response.toJson());
      if(response.code==1) {
        outstandings = response.data??[];
        
        update();
        searchOutstanding();
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

  void searchOutstanding() {
    amount = 0;
    os = 0;
    print(search.text);
    if(search.text.isEmpty) {
      outstandings_temp = [];
      outstandings_temp.addAll(outstandings);

      OutstandingModel? last;
      for (var element in outstandings) {
        int cnt = 0;
        if(last==null) {
          cnt++;
        }
        else if(element.AccountCode!=last.AccountCode) {
          print("--------------------------------------");
          print(last.AccountCode);
        }
        else if(element.OSType==1) {
          if(last.OSType!=1) {
            cnt++;
          }
          cnt++;
        }
        else {
          if(element.DaybookCodeID==last.DaybookCodeID) {
          }
          else {
            cnt++;
          }
        }

        if(cnt>0) {
          amount += element.NetAmount ?? 0;
          os += element.NetOSAmount ?? 0;
        }
        last = element;
      }
    }
    else {
      outstandings_temp = [];

      OutstandingModel? last;
      for (var element in outstandings) {
        if((element.DocNumber??"").toLowerCase() == search.text.toLowerCase() || (element.DocNumber??"").trim().toLowerCase() == search.text.toLowerCase()) {
          outstandings_temp.add(element);
          int cnt = 0;
          if(last==null) {
            cnt++;
          }
          else if(element.AccountCode!=last.AccountCode) {
            print("--------------------------------------");
            print(last.AccountCode);
          }
          else if(element.OSType==1) {
            if(last.OSType!=1) {
              cnt++;
            }
            cnt++;
          }
          else {
            if(element.DaybookCodeID==last.DaybookCodeID) {
            }
            else {
              cnt++;
            }
          }

          if(cnt>0) {
            amount += element.NetAmount ?? 0;
            os += element.NetOSAmount ?? 0;
          }
          last = element;
        }
      }
    }
    print(outstandings_temp);
    update();
    getShowUpdate(0);
  }
  
  void getShowUpdate(int i) {
    print(i);
    if(i==0) {
      show = [];
    }
    show.addAll(outstandings_temp.sublist(i, outstandings_temp.length<=(i+30) ? outstandings_temp.length : (i+30)));
    load = true;
    loaded = true;
    update();
  }
  
  String getCustomerString() {
    String where = "";

    for (var element in customers) {
      where+=", '${element.CODE}'";
    }
    return where.isNotEmpty ? " AND os.ACCOUNTCODE IN (${where.substring(2)})" : "";
  }
  
  goto(String path, {dynamic arguments}) {
    print(path);
    Get.toNamed(path, arguments: arguments)?.then((value) {
      if(value!=null) {
        // if(arguments['title'].contains("Company")) {
        //   companies = value;
        // }
        if(arguments['title'].contains("Customer") || arguments['title'].contains("Vendor")) {
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

}
