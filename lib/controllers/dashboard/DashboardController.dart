import 'package:carousel_slider/carousel_slider.dart';
import 'package:intl/intl.dart';
import 'package:rupay/essential/Essential.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rupay/models/company/CompanyModel.dart';
import 'package:rupay/models/dashboard/DashboardModel.dart';
import 'package:rupay/providers/DashboardProvider.dart';
import 'package:rupay/repositories/DashboardRepository.dart';
import 'package:rupay/services/networking/ApiConstants.dart';
import 'package:rupay/services/networking/ApiService.dart';

class DashboardController extends GetxController {
  DashboardController();

  final storage = GetStorage();

  final DashboardRepository dashboardRepository = Get.put(DashboardRepository(Get.put(ApiService(Get.find()), permanent: true)));
  late DashboardProvider dashboardProvider;

  late CompanyModel company;
  DashboardModel? dashboard;

  GlobalKey<CarouselSliderState> sliderKey = GlobalKey();
  DateTime sync = DateTime.now();
  late bool load;
  bool init = false;

  @override
  void onInit() {
    super.onInit();
    init = true;
    company = storage.read("company");
    dashboardProvider = Get.put(DashboardProvider(dashboardRepository));
    load = false;
    print("init getDashboard");
    start();
  }
  start() {
    print("start getDashboard");
    getDashboard();
  }

  Future<void> getDashboard() async {
    print("getDashboard");
    // DateTime date = DateTime.now();
    // int year = 0;
    // if(date.month<4) {
    //   year = 1;
    // }
    // DateTime finDate = DateTime(date.year-year, 4);
    // DateTime endFinDate = DateTime(date.year+1-year, 3, 31);

    List<String> years = company.YEAR.split("-");

    DateTime finDate = DateTime(int.parse(years[0]), 4);
    DateTime endFinDate = DateTime(int.parse(years[1]), 3, 31);

    Map<String, dynamic> data = {
      ApiConstants.start_date : DateFormat("yyyy-MM-dd").format(finDate),
      ApiConstants.end_date : DateFormat("yyyy-MM-dd").format(endFinDate),
    };

    print(data);

    await dashboardProvider.fetch(storage.read("access"), data).then((response) async {
      print(response.toJson());
      if(response.code==1) {
        company = response.data??company;
        storage.write("company", response.data??company);
        dashboard = response.dashboard;
        load = true;
        update();
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


  void goto(String path, {dynamic arguments}) {
    print(path);
    Get.toNamed(path, arguments: arguments);
  }
}
