import 'package:google_fonts/google_fonts.dart';
import 'package:rupay/colors/MyColors.dart';
import 'package:rupay/controllers/home/HomeController.dart';
import 'package:rupay/size/WidgetSize.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget BottomNavigation({required Color backgroundColor, required int current,  required int size, required List<BottomNavItem> items, required HomeController controller}) {
  return BottomAppBar(
    color: MyColors.colorPrimary,
    notchMargin: 0,
    child: SafeArea(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: getItemsList(current, items, controller),
      ),
    ),
  );
}

getItemsList(int current, List<BottomNavItem> items, HomeController controller) {
  List<Widget> bottomItems = [];
  int index = 0;

  for(int i=0; i<items.length; i++) {
    bottomItems.add(bottomItem(current, i, items[i].icon, items[i].text, controller));
    if(i!=items.length-1) {
    }
  }
  return bottomItems;
}

Widget bottomItem(int current, int index, String icon, String text, HomeController controller) {
  return Flexible(
    flex: 1,
    fit: FlexFit.tight,
    child: GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        controller.changeTab(index);
      },
      child: Container(
        height: 60,
        padding: EdgeInsets.only(top: 8),
        child: Column(
          children: [
            Image.asset(
              "${current==index ? "${icon}_filled" : icon}.png",
              color: MyColors.white,
              height: 22,
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              text,
              style: GoogleFonts.manrope(
                fontSize: 12,
                color: MyColors.white,
                letterSpacing: 0,
                fontWeight: current==index ? FontWeight.w700 : FontWeight.w500,
              ),
            )
          ],
        ),
      ),
    ),
  );
}

class BottomNavItem {
  final String icon;
  final String text;

  const BottomNavItem({
    required this.icon,
    required this.text,
  });
}

