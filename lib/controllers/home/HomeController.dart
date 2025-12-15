import 'package:rupay/essential/Essential.dart';
// import 'package:rupay/shared/widgets/bottomNavigation/BottomNavigation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rupay/shared/widgets/bottomNavigation/BottomNavigation.dart';
import 'package:rupay/views/home/customer/Customer.dart';
import 'package:rupay/views/home/dashboard/Dashboard.dart';
import 'package:rupay/views/home/dashboard/NewDashboard.dart';
import 'package:rupay/views/home/ledger/Ledger.dart';
import 'package:rupay/views/home/settings/Settings.dart';
import 'package:rupay/views/home/voucher/Voucher.dart';

class HomeController extends GetxController {
  HomeController();

  final storage = GetStorage();

  int current = 0;
  late int size;
  late List<BottomNavItem> items;

  late List<Widget> screens;

  @override
  void onInit() {
    super.onInit();
    size = 4;

    items = [
      const BottomNavItem(
          icon: "assets/home/dashboard",
          text: "Home"
      ),
      const BottomNavItem(
          icon: "assets/home/ledger",
          text: "Ledger"
      ),
      const BottomNavItem(
          icon: "assets/home/add",
          text: "New"
      ),
      // BottomNavItem(
      //     icon: "assets/home/voucher",
      //     text: "Voucher"
      // ),
      const BottomNavItem(
          icon: "assets/home/customer",
          text: "Customer"
      ),
      const BottomNavItem(
          icon: "assets/home/account",
          text: "Profile"
      ),
    ];
    screens = [
      Dashboard(),
      Container(),
      Container(),
      Container(),
      Container(),
    ];
  }

  @override
  void dispose() {
    super.dispose();
  }

  void changeTab(int index) {
    if(index==0) {
      screens[0] = Dashboard();
    }
    else if(index==1) {
      screens[1] = Ledger();
    }
    else if(index==2) {
      screens[2] = NewDashboard();
    }
    else if(index==3) {
      screens[3] = Customer();
    }
    else {
      screens[index] = Settings();
    }
    current = index;
    update();
  }

  confirmDialog() async {
    return await Essential.popUp("Are you sure you want to exit?", "Yes", "No");
  }
}
