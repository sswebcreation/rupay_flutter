import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:rupay/essential/Essential.dart';
import 'package:rupay/models/account/AccountModel.dart';
import 'package:rupay/models/bank/BankModel.dart';
import 'package:rupay/models/company/CompanyModel.dart';
import 'package:rupay/models/daybook/DaybookModel.dart';
import 'package:rupay/providers/BankProvider.dart';
import 'package:rupay/services/networking/ApiConstants.dart';
import 'package:rupay/shared/widgets/bottomSheets/SelectOption.dart';

class BankController extends GetxController {
  BankController();

  final storage = GetStorage();

  final BankProvider bankProvider = Get.find();

  // final AccountRepository accountRepository = Get.put(AccountRepository(Get.put(ApiService(Get.find()), permanent: true)));
  // late AccountProvider accountProvider;


  late List<BankModel> banks;
  late List<BankModel> selected_banks;
  late List<BankModel> bank_temp;
  late List<BankModel> show;
  
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
    selected_banks = [];
    search = TextEditingController();
    load = true;
    loaded = false;
    type = Get.arguments?['type']??"";
    filters = ['Daybook'];
    banks = [];
    bank_temp = [];
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
    // getBanks();
  }

  void getBanks() {
    load = false;
    selected_banks = [];
    update();

    Map<String, String> data = {
      ApiConstants.start_date : DateFormat("yyyy-MM-dd").format(sd),
      ApiConstants.end_date : DateFormat("yyyy-MM-dd").format(ed),
      ApiConstants.where : getDaybookString()
    };
    print(data);
    
    bankProvider.fetchByColumn(storage.read("access"), type+ApiConstants.filter, data).then((response) async {
      if(response.code==1) {
        banks = [];
        if (sd.difference(finDate).inDays == 0) {
          print("hello");
          banks.addAll(response.data ?? []);
          print(banks.length);
          if(banks.isNotEmpty) {
            if(banks.first.DOCNUMBER.toString().trim()=="0") {
              banks.first = banks.first.copyWith(DAYBOOKNAME: "Opening Balance");
            }
            else {
              banks.insert(0, BankModel(Particulars: "Opening Balance", DOCNUMBER: "0", Amount: 0, ACCOUNTNAME: banks.first.ACCOUNTNAME, DAYBOOKNAME: "Opening Balance", ));
            }
          }
        }
        else {
          List<BankModel> leds = response.data ?? [];
          double opening = 0;

          for (int i = 0; i < leds.length; i++) {
            BankModel led = leds[i];
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
              banks = leds.sublist(i + 1);
              banks.insert(0, BankModel(Particulars: "Opening Balance",
                DOCNUMBER: "0",
                Amount: opening, ACCOUNTNAME: led.ACCOUNTNAME,
                ContraAccountName: led.ContraAccountName,));
              break;
            }
          }
        }

        print(banks.length);




        update();
        searchBank();
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

      DateTime dateFin = DateTime.now();
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

  void searchBank() {
    print("hheloo");
    amount = 0;
    if(search.text.isEmpty) {
      bank_temp = [];
      // if(status.isNotEmpty) {
      //   for (var element in bank) {
      //     if(status.contains(element.PendingStatus) || (status.contains("PART PENDING") && (element.PendingStatus??"").contains("PART PENDING"))) {
      //       bank_temp.add(element);
      //       amount += element.TAXABLEAMT??0;
      //     }
      //   }
      // }
      // else {
        bank_temp.addAll(banks);
        for (var element in banks) {
          // amount += element.??0;
        }
      // }
    }
    else {
      bank_temp = [];
      for (var element in banks) {
        if((element.ChequeNo??"").trim().toLowerCase() == search.text.toLowerCase() || (element.DOCNUMBER??"").trim().toLowerCase() == search.text.toLowerCase()) {
          // if(status.isNotEmpty) {
          //   if (status.contains(element.PendingStatus) || (status.contains("PART PENDING") && (element.PendingStatus ?? "").contains("PART PENDING"))) {
          //     bank_temp.add(element);
          //     amount += element.TAXABLEAMT??0;
          //   }
          // }
          // else {
            bank_temp.add(element);
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
    show.addAll(bank_temp.sublist(i, bank_temp.length<=(i+30) ? bank_temp.length : (i+30)));
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

  String getDaybookString() {
    String where = "";

    for (var element in daybooks) {
      where+=", '${element.DAYBOOK}'";
    }
    return where.isNotEmpty ? " AND a.NAME IN (${where.substring(2)})" : "";
  }

  void chooseType() {
    Essential.choose("Choose One", "Bank Received", "Bank Payment").then((value) {
      if(value!=null) {
        goto("/addBank", arguments: value=="Bank Received" ? 0 : 1);
      }
    });
  }

  void changeSelectedBank(BankModel bank) {
    if(selected_banks.contains(bank)) {
      selected_banks.remove(bank);
    }
    else {
      selected_banks.add(bank);
    }
    update();
  }

  void changeSelectAll() {
    if(selected_banks.length==bank_temp.length) {
      selected_banks = [];
    }
    else {
      selected_banks = [];
      selected_banks.addAll(bank_temp);
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
      "id" : getBankIDs()
    };

    print(data);

    bankProvider.deleteMultiple(ApiConstants.delete, storage.read("access"), data).then((response) async {
      print(response.toJson());

      if(response.code==1) {
        getBanks();
      }
      else {
        load = true;
        update();
        Essential.showSnackBar(response.message);
      }
    });
  }

  String getBankIDs() {
    String id = "";
    for (var element in selected_banks) {
      id+=",${element.ID}";
    }
    return id.isNotEmpty ? id.substring(1) : "";
  }
}

