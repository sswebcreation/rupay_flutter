import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rupay/essential/Essential.dart';
import 'package:rupay/models/daybook/DaybookModel.dart';
import 'package:rupay/providers/DaybookProvider.dart';
import 'package:rupay/services/networking/ApiConstants.dart';

class DaybookController extends GetxController {
  DaybookController();

  final storage = GetStorage();

  late DaybookProvider daybookProvider = Get.find();

  List<DaybookModel> daybooks = [];
  List<DaybookModel> show = [];
  List<DaybookModel> selected = [];
  List<DaybookModel> temp = [];

  late TextEditingController search;
  late bool load;
  late String endpoint;

  @override
  void onInit() {
    super.onInit();
    endpoint = Get.arguments['endpoint'];
    temp = Get.arguments['list'];
    search = TextEditingController();
    load = false;
    show = [];
    daybooks = [];
    start();
  }

  void start() {
    getDaybooks();
  }

  void getDaybooks() {
    daybookProvider.fetch(storage.read("access"), endpoint).then((response) async {
      print(response.toJson());

      if(response.code==1) {
        daybooks = response.data??[];
        print(daybooks.length);

        show = [];
        show.addAll(daybooks);
        print(temp);
        if(temp.isNotEmpty) {
          for (var element in show) {
            for (var ele in temp) {
              // if(title.contains("Company")) {
              //   if(ele.COCODE==element.COCODE) {
              //     print("hello");
              //     selected.add(element);
              //   }
              // }
              // else {
                if(ele.DAYBOOK==element.DAYBOOK) {
                  selected.add(element);
                }
              // }
            }
          }
        }
        load = true;
        update();
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

  goto(String path, {dynamic arguments}) {
    print(path);
    Get.toNamed(path, arguments: arguments);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void manageDaybook(bool? value, DaybookModel daybook) {
    if(value!=null) {
      if (value == true) {
        selected.add(daybook);
      }
      else if (value == false) {
        selected.remove(daybook);
      }
      update();
    }
  }

  void searchDaybook() {
    if(search.text.isEmpty) {
      show = [];
      show.addAll(daybooks);
    }
    else {
      show = [];
      for (var element in daybooks) {
        if(element.DAYBOOK.toLowerCase().contains(search.text.toLowerCase())) {
          show.add(element);
        }
      }
    }
    update();
  }
}
