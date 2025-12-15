import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:rupay/essential/Essential.dart';
import 'package:rupay/models/account/AccountModel.dart';
import 'package:rupay/models/company/CompanyModel.dart';
import 'package:rupay/models/daybook/DaybookModel.dart';
import 'package:rupay/providers/AccountProvider.dart';
import 'package:rupay/providers/DaybookProvider.dart';
import 'package:rupay/providers/CashProvider.dart';
import 'package:rupay/services/networking/ApiConstants.dart';

class AddCashController extends GetxController {
  AddCashController();

  final storage = GetStorage();

  late CashProvider cashProvider = Get.find();
  late AccountProvider accountProvider = Get.find();
  late DaybookProvider daybookProvider = Get.find();

  late CompanyModel company;

  List<DaybookModel> daybooks = [];
  List<AccountModel> accounts = [];

  DaybookModel? daybook;
  AccountModel? account;

  late DateTime bdate;
  late bool load;

  late int type;

  late GlobalKey<FormState> formKey;

  late TextEditingController billDate;
  late TextEditingController billNo;
  late TextEditingController amount;
  late TextEditingController notes;

  @override
  void onInit() {
    super.onInit();

    formKey = GlobalKey<FormState>();
    load = false;

    company = storage.read("company");
    type = Get.arguments;

    billDate = TextEditingController();
    setDate(DateTime.now());

    billNo = TextEditingController();
    amount = TextEditingController();
    notes = TextEditingController();
    start();
  }

  void start() {
    getValue();
  }

  void getValue() {
    load = false;
    update();

    cashProvider.fetchValue(storage.read("access"), ApiConstants.value).then((response) async {
      if(response.code==1) {
        daybooks = response.daybooks??[];
        accounts = response.parties??[];
      }
      else {
        Essential.showSnackBar(response.message);
      }
      load = true;
      update();
    });
  }

  void getLastBill() {
    load = false;
    update();

    Map<String, dynamic> data = {
      "DAYBOOK" : daybook?.CODE??"",
      "type" : type,
    };
    
    print(data);

    cashProvider.fetchLastBill(storage.read("access"), ApiConstants.bill, data).then((response) async {
      if(response.code==1) {
        String bill = (response.data??"").trim();
        if(bill.isNotEmpty) {
          int end = findEndOfNumber(bill);
          billNo.text = (int.parse(bill.substring(0, end))+1).toString()+bill.substring(end);
        }
      }
      else {
        billNo.text = "";
        Essential.showSnackBar(response.message);
      }
      load = true;
      update();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  String getDateText(DateTime date) {
    return DateFormat("dd MMM, yyyy").format(date);
  }

  void setDate(DateTime value) {
    bdate = value;
    update();
    billDate.text = getDateText(bdate);
  }

  void addCash() {
    if(formKey.currentState!.validate()) {
      Map<String, dynamic> data = {
        "DOCNUMBER" : billNo.text,
        "TXNDATE" : DateFormat("yyyy-MM-dd").format(bdate),
        "DAYBOOK" : daybook?.CODE??"",
        "ACCOUNTCODE" : account?.CODE??"",
        "ACCOUNTNAME" : account?.NAME??"",
        "NETAMOUNT" : amount.text,
        "RPTYPE" : type,
        "NOTES" : notes.text,
      };

      print(data);

      cashProvider.add(storage.read("access"), ApiConstants.add, data).then((
          response) async {
        print(response.toJson());
        if (response.code == 1) {
          // onInit();
          Essential.showSnackBar(response.message);
        }
        else {
          Essential.showSnackBar(response.message);
        }
      });
    }
  }

  void changeDaybook(DaybookModel? value) {
    daybook = value;
    update();
    getLastBill();
  }

  void changeAccount(AccountModel? value) {
    account = value;
    update();
  }

  int findEndOfNumber(String input) {
    final pattern = r'\d+';
    final regex = RegExp(pattern);

    Match? match = regex.firstMatch(input);
    if (match == null) {
      return -1; // No number found
    }

    int end = match.end;

    return end;
  }
}
