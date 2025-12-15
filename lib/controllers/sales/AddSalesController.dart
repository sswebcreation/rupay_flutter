


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:rupay/essential/Essential.dart';
import 'package:rupay/models/account/AccountModel.dart';
import 'package:rupay/models/company/CompanyModel.dart';
import 'package:rupay/models/daybook/DaybookModel.dart';
import 'package:rupay/models/item/ItemModel.dart';
import 'package:rupay/providers/AccountProvider.dart';
import 'package:rupay/providers/DaybookProvider.dart';
import 'package:rupay/providers/SalesProvider.dart';
import 'package:rupay/services/networking/ApiConstants.dart';

class AddSalesController extends GetxController {
  AddSalesController();

  final storage = GetStorage();

  late SalesProvider salesProvider = Get.find();
  late AccountProvider accountProvider = Get.find();
  late DaybookProvider daybookProvider = Get.find();

  late CompanyModel company;

  List<DaybookModel> daybooks = [];
  List<AccountModel> accounts = [];
  List<ItemModel> items = [];

  DaybookModel? daybook;
  AccountModel? account;

  late DateTime bdate;
  late bool load;

  late GlobalKey<FormState> formKey;

  late TextEditingController billDate;
  late TextEditingController billNo;
  late List<TextEditingController> name;
  late List<TextEditingController> pcs;
  late List<TextEditingController> cut;
  late List<TextEditingController> mts;
  late List<TextEditingController> rate;
  late List<TextEditingController> gross;
  late List<TextEditingController> amount;
  late List<TextEditingController> gstAmount;
  late List<ItemModel?> item;

  @override
  void onInit() {
    super.onInit();

    formKey = GlobalKey<FormState>();
    load = false;

    company = storage.read("company");

    billDate = TextEditingController();
    setDate(DateTime.now());

    billNo = TextEditingController();
    account = null;
    name = [];
    pcs = [];
    cut = [];
    mts = [];
    rate = [];
    gross = [];
    amount = [];
    gstAmount = [];
    item = [];

    start();
  }

  void start() {
    getValue();
  }

  void getValue() {
    load = false;
    update();

    salesProvider.fetchValue(storage.read("access"), ApiConstants.value).then((response) async {
      if(response.code==1) {
        daybooks = response.daybooks??[];
        accounts = response.parties??[];
        items = response.items??[];
      }
      else {
        Essential.showSnackBar(response.message);
      }

      load = true;
      update();

      if(daybooks.isNotEmpty) {
        changeDaybook(daybooks.first);
      }
      // getDaybooks();
    });
  }

  void getLastBill() {
    load = false;
    update();

    Map<String, dynamic> data = {
      "DAYBOOK" : daybook?.DAYBOOK??""
    };

    salesProvider.fetchLastBill(storage.read("access"), ApiConstants.bill, data).then((response) async {
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

  void addItem() {
    name.add(TextEditingController());
    pcs.add(TextEditingController());
    cut.add(TextEditingController());
    mts.add(TextEditingController());
    rate.add(TextEditingController());
    gross.add(TextEditingController());
    amount.add(TextEditingController());
    gstAmount.add(TextEditingController());
    item.add(null);
    update();
  }

  void addSales() {
    if(formKey.currentState!.validate()) {
      Map<String, dynamic> data = {
        "DOCNUMBER" : billNo.text,
        "TXNDATE" : DateFormat("yyyy-MM-dd").format(bdate),
        "DAYBOOK" : daybook?.DAYBOOK??"",
        "ACCOUNTCODE" : account?.CODE??"",
        "ACCOUNTNAME" : account?.NAME??"",
        "RATE" : getRate(),
        "GROSSAMT" : getGrossAmount(),
        "TAXABLEAMT" : getGrossAmount(),
        "GST" : getGSTAmount(),
        "NETAMOUNT" : getNetAmount(),
        "LINEITEM": getLineItem().toString(),
      };

      print(data);

      salesProvider.add(storage.read("access"), ApiConstants.add, data).then((
          response) async {
        print(response.toJson());
        if (response.code == 1) {
          // onInit();
          Essential.showSnackBar(response.message);
          goto("/singleSalesPDF", arguments: {"id" : response.data, "type" : "S", "entryType" : ApiConstants.latest});
        }
        else {
          Essential.showSnackBar(response.message);
        }
      });
    }
  }

  void goto(String path, {dynamic arguments}) {
    print(path);
    Get.toNamed(path, arguments: arguments)?.then((value) {
      onInit();
    });
  }

  List<String> getPcs() {
    List<String> list = [];
    for (var element in pcs) {
      list.add(element.text);
    }
    return list;
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

  void changeItem(ItemModel? value, index) {
    item[index] = value;
    update();
    calculate(index);
  }

  void removeItem(int index) {
    name.removeAt(index);
    pcs.removeAt(index);
    cut.removeAt(index);
    mts.removeAt(index);
    rate.removeAt(index);
    gross.removeAt(index);
    amount.removeAt(index);
    gstAmount.removeAt(index);
    item.removeAt(index);
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

  List<Map<String, dynamic>> getLineItem() {
    List<Map<String, dynamic>> data = [];
    for(int i = 0; i<name.length; i++) {
      int rateper = item[i]?.RATEPER??0;
      double r = double.parse(rate[i].text.isEmpty ? "0" : rate[i].text);
      double g = r * double.parse(rateper==1 ? pcs[i].text : rateper==2 ? cut[i].text : mts[i].text);
      double p = item[i]?.HSNPer??0;

      double gst = (g * (p/100));
      data.add(
          {
            '"ITEMCODE"':'"${item[i]?.CODE??""}"',
            '"ITEMNAME"':'"${item[i]?.NAME??""}"',
            '"QTY1"':pcs[i].text.isEmpty ? 0 : pcs[i].text,
            '"QTY2"':cut[i].text.isEmpty ? 0 : cut[i].text,
            '"QTY3"':mts[i].text.isEmpty ? 0 : mts[i].text,
            '"ITEMRATE"':r,
            '"GROSSAMOUNT"':g,
            '"AMOUNT"':r,
            '"GSTAMOUNT"':gst,
            '"NETAMOUNT"':gst+g,
            '"TAXABLEVALUE"':r,
            '"GSTPERCENT"':p
          }
      );
    }
    return data;
  }

  double getGrossAmount() {
    double amount = 0;
    for(int i = 0; i<gross.length; i++) {
      amount += double.parse(gross[i].text);
    }
    return amount;
  }


  double getGSTAmount() {
    double amount = 0;
    for(int i = 0; i<gstAmount.length; i++) {
      amount += double.parse(gstAmount[i].text);
    }
    return amount;
  }


  double getNetAmount() {
    double amount = 0;
    for(int i = 0; i<this.amount.length; i++) {
      amount += double.parse(this.amount[i].text);
    }
    return amount;
  }


  double getRate() {
    double amount = 0;
    for(int i = 0; i<rate.length; i++) {
      amount += double.parse(rate[i].text);
    }
    return amount;
  }

  void calculate(int index) {
    int rateper = item[index]?.RATEPER??0;
    double r = double.parse(rate[index].text.isEmpty ? "0" : rate[index].text);
    double g = r * double.parse(rateper==1 ? pcs[index].text : rateper==2 ? cut[index].text : mts[index].text);
    double p = item[index]?.HSNPer??0;

    double gst = (g * (p/100));

    gross[index].text =  g.toStringAsFixed(2);
    gstAmount[index].text =  gst.toStringAsFixed(2);
    amount[index].text =  (gst + g).toStringAsFixed(2);
  }
}


