import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:rupay/essential/Essential.dart';
import 'package:rupay/models/account/AccountModel.dart';
import 'package:rupay/models/cash/CashModel.dart';
import 'package:rupay/models/company/CompanyModel.dart';
import 'package:rupay/models/daybook/DaybookModel.dart';
import 'package:rupay/providers/CashProvider.dart';
import 'package:rupay/services/networking/ApiConstants.dart';
import 'package:rupay/shared/widgets/bottomSheets/SelectOption.dart';

class CashController extends GetxController {
  CashController();

  final storage = GetStorage();

  final CashProvider cashProvider = Get.find();

  // final AccountRepository accountRepository = Get.put(AccountRepository(Get.put(ApiService(Get.find()), permanent: true)));
  // late AccountProvider accountProvider;


  late List<CashModel> cashs;
  late List<CashModel> selected_cashs;
  late List<CashModel> cash_temp;
  late List<CashModel> show;
  
  late TextEditingController search;

  late DateTime finDate;
  late DateTime endFinDate;
  late DateTime sd;
  late DateTime ed;

  late List<String> filters;
  List<String> dateFilter = ['Today', 'This Week', 'Last 30 Days', 'This Quarter', 'This Fin. Year', 'Custom'];
  late String selectedDF;

  late double amount;
  late bool load;
  late bool loaded;

  List<DaybookModel> daybooks = [];

  late CompanyModel company;
  late String type;

  @override
  void onInit() {
    super.onInit();
    selected_cashs = [];
    search = TextEditingController();
    load = true;
    loaded = false;
    type = Get.arguments?['type']??"";
    filters = ['Daybook'];
    cashs = [];
    cash_temp = [];
    show = [];

    daybooks = [];

    company = storage.read("company");

    amount = 0;

    selectedDF = dateFilter[4];

    List<String> years = company.YEAR.split("-");

    finDate = DateTime(int.parse(years[0]), 4);
    endFinDate = DateTime(int.parse(years[1]), 3, 31);

    sd = finDate;
    ed = endFinDate;

    start();
  }

  void start() {
    // getCashs();
  }

  void getCashs() {
    load = false;
    selected_cashs = [];
    update();

    Map<String, String> data = {
      ApiConstants.start_date : DateFormat("yyyy-MM-dd").format(sd),
      ApiConstants.end_date : DateFormat("yyyy-MM-dd").format(ed),
      ApiConstants.where : getDaybookString()
    };
    print(data);
    
    cashProvider.fetchByColumn(storage.read("access"), type+ApiConstants.filter, data).then((response) async {
      if(response.code==1) {
        cashs = [];
        if (sd.difference(finDate).inDays == 0) {
          print("hello");
          cashs.addAll(response.data ?? []);
          print(cashs.length);
          if(cashs.isNotEmpty) {
            if(cashs.first.DOCNUMBER.toString().trim()=="0") {
              cashs.first = cashs.first.copyWith(DAYBOOKNAME: "Opening Balance");
            }
            else {
              cashs.insert(0, CashModel(Particulars: "Opening Balance", DOCNUMBER: "0", Amount: 0, ACCOUNTNAME: cashs.first.ACCOUNTNAME, DAYBOOKNAME: "Opening Balance", ));
            }
          }
        }
        else {
          List<CashModel> leds = response.data ?? [];
          double opening = 0;

          for (int i = 0; i < leds.length; i++) {
            CashModel led = leds[i];
            DateTime date = DateTime.parse(led.TXNDATE ?? "");


            if (date
                .difference(sd)
                .isNegative) {
              if (led.Amount?.isNegative == true) {
                opening += (led.Amount ?? 0).abs();
              }
              else {
                opening -= (led.Amount ?? 0).abs();
              }
            }
            else {
              cashs = leds.sublist(i + 1);
              cashs.insert(0, CashModel(Particulars: "Opening Balance",
                  DOCNUMBER: "0",
                  Amount: opening, ACCOUNTNAME: led.ACCOUNTNAME,
                ContraAccountName: led.ContraAccountName,));
              break;
            }
          }
        }

        print(cashs.length);




        update();
        searchCash();
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

  String getDaybookString() {
    String where = "";

    for (var element in daybooks) {
      where+=", '${element.DAYBOOK}'";
    }
    return where.isNotEmpty ? " AND a.NAME IN (${where.substring(2)})" : "";
  }

  goto(String path, {dynamic arguments}) {
    Get.toNamed(path, arguments: arguments)?.then((value) {
      if(value!=null) {
        if (path.contains("daybook")) {
          daybooks = value;
          update();
        }
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
      if(ed.difference(finDate).isNegative) {
        ed = endFinDate;
      }
      else if(endFinDate.difference(ed).isNegative) {
        ed = endFinDate;
      }
    }
    else {
      if(endFinDate.difference(date).isNegative) {
        ed = endFinDate;
      }
      else {
        ed = date;
      }
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
      if(value!=null && value!=selectedDF) {
        changeDates(value);
      }
    });
  }

  void changeDates(String value) {
    selectedDF = value;
    DateTime date = DateTime.now();

    if(value=="Today") {
      sd = DateTime.now();
      ed = DateTime.now();
    }
    else if(value=="This Week") {
      sd = date.subtract(Duration(days: date.weekday - 1));
      ed = date.add(Duration(days: DateTime.daysPerWeek - date.weekday));
    }
    else if(value=="Last 30 Days") {
      ed = DateTime(date.year, date.month, date.day);
      sd = ed.subtract(Duration(days: 30));
      // sd = DateTime(date.year, date.month);
      // ed = DateTime(date.year, date.month+1).subtract(Duration(days: 1));
    }
    else if(value=="This Quarter") {
      int quarter = (date.month/3).ceil();
      sd = DateTime(date.year, (quarter*3)-2);
      ed = DateTime(date.year, (quarter*3)+1).subtract(Duration(days: 1));
    }
    else if(value=="This Fin. Year") {
      sd = finDate;
      ed = endFinDate;
    }
    update();
  }

  void searchCash() {
    print("hheloo");
    amount = 0;
    if(search.text.isEmpty) {
      cash_temp = [];
      // if(status.isNotEmpty) {
      //   for (var element in cash) {
      //     if(status.contains(element.PendingStatus) || (status.contains("PART PENDING") && (element.PendingStatus??"").contains("PART PENDING"))) {
      //       cash_temp.add(element);
      //       amount += element.TAXABLEAMT??0;
      //     }
      //   }
      // }
      // else {
        cash_temp.addAll(cashs);
        for (var element in cashs) {
          // amount += element.??0;
        }
      // }
    }
    else {
      cash_temp = [];
      for (var element in cashs) {
        if((element.ChequeNo??"").trim().toLowerCase() == search.text.toLowerCase() || (element.DOCNUMBER??"").trim().toLowerCase() == search.text.toLowerCase()) {
          // if(status.isNotEmpty) {
          //   if (status.contains(element.PendingStatus) || (status.contains("PART PENDING") && (element.PendingStatus ?? "").contains("PART PENDING"))) {
          //     cash_temp.add(element);
          //     amount += element.TAXABLEAMT??0;
          //   }
          // }
          // else {
            cash_temp.add(element);
            // amount += element.TAXABLEAMT??0;
          // }
        }
      }
    }
    update();
    getShowUpdate(0);
  }

  void getShowUpdate(int i) {
    if(i==0) {
      show = [];
    }
    show.addAll(cash_temp.sublist(i, cash_temp.length<=(i+30) ? cash_temp.length : (i+30)));
    load = true;
    loaded = true;
    update();
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

  void chooseType() {
    Essential.choose("Choose One", "Cash Received", "Cash Payment").then((value) {
      if(value!=null) {
        goto("/addCash", arguments: value=="Cash Received" ? 0 : 1);
      }
    });
  }

  void changeSelectedCash(CashModel cash) {
    if(selected_cashs.contains(cash)) {
      selected_cashs.remove(cash);
    }
    else {
      selected_cashs.add(cash);
    }
    update();
  }

  void changeSelectAll() {
    if(selected_cashs.length==cash_temp.length) {
      selected_cashs = [];
    }
    else {
      selected_cashs = [];
      selected_cashs.addAll(cash_temp);
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
      "id" : getCashIDs()
    };

    print(data);

    cashProvider.deleteMultiple(ApiConstants.delete, storage.read("access"), data).then((response) async {
      print(response.toJson());

      if(response.code==1) {
        getCashs();
      }
      else {
        load = true;
        update();
        Essential.showSnackBar(response.message);
      }
    });
  }

  String getCashIDs() {
    String id = "";
    for (var element in selected_cashs) {
      id+=",${element.ID}";
    }
    return id.isNotEmpty ? id.substring(1) : "";
  }
}
