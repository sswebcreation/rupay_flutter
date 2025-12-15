import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:rupay/essential/Essential.dart';
import 'package:rupay/models/account/AccountModel.dart';
import 'package:rupay/models/company/CompanyModel.dart';
import 'package:rupay/models/ledger/LedgerModel.dart';
import 'package:rupay/providers/AccountProvider.dart';
import 'package:rupay/providers/LedgerProvider.dart';
import 'package:rupay/repositories/AccountRepository.dart';
import 'package:rupay/repositories/LedgerRepository.dart';
import 'package:rupay/services/networking/ApiConstants.dart';
import 'package:rupay/services/networking/ApiService.dart';
import 'package:rupay/shared/widgets/bottomSheets/SelectOption.dart';

class LedgerController extends GetxController {
  LedgerController();

  final storage = GetStorage();

  final LedgerRepository ledgerRepository = Get.put(LedgerRepository(Get.put(ApiService(Get.find()), permanent: true)));
  late LedgerProvider ledgerProvider;

  final AccountRepository accountRepository = Get.put(AccountRepository(Get.put(ApiService(Get.find()), permanent: true)));
  late AccountProvider accountProvider;


  late List<LedgerModel> ledgers;
  late List<LedgerModel> ledger_temp;
  late List<LedgerModel> show;
  late List<AccountModel> customers;

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

  late CompanyModel company;

  @override
  void onInit() {
    super.onInit();
    search = TextEditingController();
    load = true;
    loaded = false;
    filters = [];
    customers = [];
    ledgers = [];
    ledger_temp = [];
    show = [];

    company = storage.read("company");

    filters.insertAll(0, ['Account']);
    if(Get.arguments!=null) {
      customers = [Get.arguments?['customer']];
    }

    amount = 0;

    selectedDF = dateFilter[4];

    List<String> years = company.YEAR.split("-");

    finDate = DateTime(int.parse(years[0]), 4);
    endFinDate = DateTime(int.parse(years[1]), 3, 31);

    sd = finDate;
    ed = endFinDate;

    ledgerProvider = Get.put(LedgerProvider(ledgerRepository));
    accountProvider = Get.put(AccountProvider(accountRepository));

    start();
  }

  void start() {
    // getLedgers();
  }

  void getLedgers() {
    load = false;
    update();

    Map<String, String> data = {
      ApiConstants.start_date : DateFormat("yyyy-MM-dd").format(sd),
      // ApiConstants.start_date : DateFormat("yyyy-MM-dd").format(finDate),
      ApiConstants.end_date : DateFormat("yyyy-MM-dd").format(ed),
      ApiConstants.where : getCustomerString(),
    };
    print(data);
    
    ledgerProvider.fetchByColumn(storage.read("access"), ApiConstants.filter, data).then((response) async {
      if(response.code==1) {
        ledgers = [];
        print("customers.length<=1 ${customers.length<=1}");
        if(customers.length<=1) {
          print("sd.difference(finDate).inDays ${sd.difference(finDate).inDays}");
          if (sd.difference(finDate).inDays == 0) {
            print("hello");
            ledgers.addAll(response.data ?? []);
            print(ledgers.length);
            if(ledgers.isNotEmpty) {
              if(ledgers.first.DOCNUMBER.toString().trim()=="0") {
                ledgers.first = ledgers.first.copyWith(DAYBOOKNAME: "Opening Balance");
              }
              else {
                ledgers.insert(0, LedgerModel(Particulars: "Opening Balance", DOCNUMBER: "0", Amount: 0, ACCOUNTCODE: ledgers.first.ACCOUNTCODE, ACCOUNTNAME: ledgers.first.ACCOUNTNAME, DAYBOOKNAME: "Opening Balance", ADD1: ledgers.first.ADD1, ADD2: ledgers.first.ADD2));
              }
            }
          }
          else {
            List<LedgerModel> leds = response.data ?? [];
            double opening = 0;

            for (int i = 0; i < leds.length; i++) {
              LedgerModel led = leds[i];
              DateTime date = DateTime.parse(led.TXNDATE ?? "");


              print(date);
              print(sd);
              print("date.difference(sd) ${date.difference(sd).inHours}");
              print("date.difference(sd).isNegative ${date.difference(sd).isNegative}");
              if (date.difference(sd).isNegative) {
                if (led.Amount?.isNegative == true) {
                  opening += (led.Amount ?? 0).abs();
                }
                else {
                  opening -= (led.Amount ?? 0).abs();
                }
              }
              else {
                ledgers = leds.sublist(i + 1);
                ledgers.insert(0, LedgerModel(Particulars: "Opening Balance",
                    DOCNUMBER: "0",
                    Amount: opening, ACCOUNTCODE: led.ACCOUNTCODE));
                break;
              }
            }
          }
        }
        else {
          List<LedgerModel> leds = [];
          leds.addAll(response.data ?? []);
          print(leds.length);
          double opening = 0;
          ledgers = [];
          int last = 0;

          for (int i = 0; i < leds.length; i++) {
            print(i);
            LedgerModel led = leds[i];
            DateTime date = DateTime.parse(led.TXNDATE ?? "");
            bool old = true;

            if(i==0) {
              print("reset");
              print(i);
              opening = 0;
              old = false;
            }
            else if(led.ACCOUNTCODE!=leds[i-1].ACCOUNTCODE) {
              print("newwwww");
              print(opening);
              print(leds[i-1].ACCOUNTCODE);
              if(leds[last].DOCNUMBER.toString().trim()!="0") {
                ledgers.add(LedgerModel(Particulars: "Opening Balance",
                    DOCNUMBER: "0",
                    Amount: opening,
                    ACCOUNTCODE: leds[i - 1].ACCOUNTCODE,
                    ACCOUNTNAME: leds[i - 1].ACCOUNTNAME,
                    DAYBOOKNAME: "Opening Balance",
                    ADD1: leds[i - 1].ADD1,
                    ADD2: leds[i - 1].ADD2));
              }
              else {
                leds[last] = leds[last].copyWith(DAYBOOKNAME: "Opening Balance");
              }
              ledgers.addAll(leds.sublist(last, i));

              last = i;
              print("reset");
              print(i);

              opening = 0;
              old = false;
            }


            print(date);
            print(sd);
            print("date.difference(sd) ${date.difference(sd).inHours}");
            print("date.difference(sd).isNegative ${date.difference(sd).isNegative}");
            if (date.difference(sd).isNegative) {
              if (led.Amount?.isNegative == true) {
                opening += (led.Amount ?? 0).abs();
              }
              else {
                opening -= (led.Amount ?? 0).abs();
              }
            }
            else {
              continue;
            }
          }
          print(opening);
          if(leds[last].DOCNUMBER.toString().trim()!="0") {
            ledgers.add(LedgerModel(Particulars: "Opening Balance",
                DOCNUMBER: "0",
                Amount: opening,
                ACCOUNTCODE: leds[last].ACCOUNTCODE,
                ACCOUNTNAME: leds[last].ACCOUNTNAME,
                DAYBOOKNAME: "Opening Balance",
                ADD1: leds[last].ADD1,
                ADD2: leds[last].ADD2));
          }
          else {
            leds[last] = leds[last].copyWith(DAYBOOKNAME: "Opening Balance");
          }
          // ledgers.add(LedgerModel(Particulars: "Opening Balance", DOCNUMBER: "0", Amount: opening, ACCOUNTCODE: leds[last].ACCOUNTCODE, ACCOUNTNAME: leds[last].ACCOUNTNAME, DAYBOOKNAME: "Opening Balance", ADD1: leds[last].ADD1, ADD2: leds[last].ADD2));
          ledgers.addAll(leds.sublist(last));
        }

        print(ledgers.length);




        update();
        searchLedger();
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
        if(arguments['title'].contains("Accounts")) {
          customers = value;
        }
        update();
      }
    });
  }

  String getCustomerString() {
    String where = "";

    for (var element in customers) {
      where+=", '${element.CODE}'";
    }
    return where.isNotEmpty ? " AND led.ACCOUNTCODE IN (${where.substring(2)})" : "";
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
      // if(endFinDate.difference(date).isNegative) {
      //   ed = endFinDate;
      // }
      // else {
        ed = date;
      // }
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

  List<AccountModel> getCustomerList(int index) {
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


  void searchLedger() {
    print("hheloo");
    amount = 0;
    if(search.text.isEmpty) {
      ledger_temp = [];
      // if(status.isNotEmpty) {
      //   for (var element in ledger) {
      //     if(status.contains(element.PendingStatus) || (status.contains("PART PENDING") && (element.PendingStatus??"").contains("PART PENDING"))) {
      //       ledger_temp.add(element);
      //       amount += element.TAXABLEAMT??0;
      //     }
      //   }
      // }
      // else {
        ledger_temp.addAll(ledgers);
        for (var element in ledgers) {
          // amount += element.??0;
        }
      // }
    }
    else {
      ledger_temp = [];
      for (var element in ledgers) {
        if((element.ChequeNo??"").trim().toLowerCase() == search.text.toLowerCase() || (element.DOCNUMBER??"").trim().toLowerCase() == search.text.toLowerCase()) {
          // if(status.isNotEmpty) {
          //   if (status.contains(element.PendingStatus) || (status.contains("PART PENDING") && (element.PendingStatus ?? "").contains("PART PENDING"))) {
          //     ledger_temp.add(element);
          //     amount += element.TAXABLEAMT??0;
          //   }
          // }
          // else {
            ledger_temp.add(element);
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
    show.addAll(ledger_temp.sublist(i, ledger_temp.length<=(i+30) ? ledger_temp.length : (i+30)));
    load = true;
    loaded = true;
    update();
  }
}
