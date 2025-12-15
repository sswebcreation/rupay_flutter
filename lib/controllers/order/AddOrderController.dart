import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:rupay/colors/MyColors.dart';
import 'package:rupay/essential/Essential.dart';
import 'package:rupay/models/account/AccountModel.dart';
import 'package:rupay/models/order/OrderModel.dart';
import 'package:rupay/models/screenCode/ScreenCodeModel.dart';
import 'package:rupay/providers/AccountProvider.dart';
import 'package:rupay/providers/OrderProvider.dart';
import 'package:rupay/services/networking/ApiConstants.dart';
import 'package:rupay/shared/widgets/bottomSheets/SelectOption.dart';

class AddOrderController extends GetxController {
  AddOrderController();

  final storage = GetStorage();

  late OrderProvider orderProvider = Get.find();
  late AccountProvider accountProvider = Get.find();

  List<ScreenCodeModel> screen_codes = [];

  late DateTime date;
  late bool load;

  late GlobalKey<FormState> formKey;

  late TextEditingController orderDate;
  late List<TextEditingController> pcs;
  late List<ScreenCodeModel?> codes;

  @override
  void onInit() {
    super.onInit();

    formKey = GlobalKey<FormState>();
    load = false;

    date = DateTime.now();
    orderDate = TextEditingController();
    pcs = [];
    codes = [];

    start();
  }

  void start() {
    getScreenCodes();
  }

  void getScreenCodes() {
    load = false;
    update();

    
    orderProvider.fetchScreenCodes(storage.read("access"), ApiConstants.screencode).then((response) async {
      print(response.toJson());
      load = true;
      update();
      if(response.code==1) {
        screen_codes = response.data??[];
      }
      else {
        Essential.showSnackBar(response.message);
      }
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
    date = value;
    update();
    orderDate.text = getDateText(date);
  }

  void addItem() {
    codes.add(null);
    pcs.add(new TextEditingController());
    update();
  }

  void addOrder() {
    if(formKey.currentState!.validate()) {
      Map<String, dynamic> data = {
        "order_date": DateFormat("yyyy-MM-dd").format(date),
        "pcs": getPcs(),
        "screen_code": getScreenCode(),
      };

      print(data);

      orderProvider.add(storage.read("access"), ApiConstants.add, data).then((
          response) async {
        print(response.toJson());
        if (response.code == 1) {
          onInit();
          Essential.showSnackBar(response.message);
        }
        else {
          Essential.showSnackBar(response.message);
        }
      });
    }
  }

  List<String> getPcs() {
    List<String> list = [];
    for (var element in pcs) {
      list.add(element.text);
    }
    return list;
  }

  List<String> getScreenCode() {
    List<String> list = [];
    for (var element in codes) {
      list.add(element?.code??"");
    }
    return list;
  }

  void changeScreenCode(ScreenCodeModel? value, int index) {
    codes[index] = value;
    update();
  }

  void removeItem(int index) {
    codes.removeAt(index);
    pcs.removeAt(index);
    update();
  }
}
