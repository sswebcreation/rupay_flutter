import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rupay/colors/MyColors.dart';
import 'package:rupay/constants/CommonConstants.dart';
import 'package:rupay/controllers/dashboard/NewDashboardController.dart';
import 'package:rupay/services/networking/ApiConstants.dart';
import 'package:rupay/shared/widgets/CustomClipPath.dart';
import 'package:rupay/size/MySize.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class NewDashboard extends StatelessWidget {
  NewDashboard({ Key? key }) {
    newDashboardController.onInit();
  }

  final NewDashboardController newDashboardController = Get.put<NewDashboardController>(NewDashboardController());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GetBuilder<NewDashboardController>(
      builder: (controller) {
        return Scaffold(
          body: newDashboardController.load ? getBody(context) : Center(
            child: CircularProgressIndicator(
              color: MyColors.colorPrimary,
            ),
          )
        );
      },
    );
  }

  Widget  getBody(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: SizedBox(
        height: (Platform.isIOS ? 350 : 300) + (140 * 4) + (20 * 4),
        child: Stack(
          children: [
            getUpperBG(context),
            Positioned(
              top: Platform.isIOS ? 300 : 250,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                width: MySize.size100(context),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Flexible(
                          flex: 1,
                          child: getCard("sales.png", "Total Sales", "${CommonConstants.rupee}${(newDashboardController.dashboard?.SALES??0).toStringAsFixed(2)}"),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Flexible(
                          flex: 1,
                          child: getCard("purchase.png", "Total Purchase", "${CommonConstants.rupee}${(newDashboardController.dashboard?.PURCHASE??0).toStringAsFixed(2)}"),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Flexible(
                          flex: 1,
                          child: getCard("cash.png", "Cash", "${CommonConstants.rupee}${(newDashboardController.dashboard?.CASH??0).abs().toStringAsFixed(2)}"),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Flexible(
                          flex: 1,
                          child: getCard("bank.png", "Bank", "${CommonConstants.rupee}${(newDashboardController.dashboard?.BANK??0).abs().toStringAsFixed(2)}"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  Widget getBody1(BuildContext context) {
    return Container(
      height: MySize.sizeh100(context),
      child: Column(
        children: [
          Flexible(
            child: SingleChildScrollView(
              child: Container(
                height: MySize.sizeh100(context),
                child: Column(
                  children: [
                    Container(
                      height: MySize.sizeh100(context),
                      child: Stack(
                        children: [
                          getUpperBG(context),

                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getUpperBG(BuildContext context) {
    return Positioned(
      top: 0,
      child: Container(
        height: Platform.isIOS ? 350 : 300,
        width: MySize.size100(context),
        child: ClipPath(
          clipper: CustomClipPath(),
          child: Container(
            decoration: BoxDecoration(
              color: MyColors.colorSecondary,
            ),
            child: SafeArea(
              child: newDashboardController.load ? Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(),
                        Text(
                          "NEW ENTRIES",
                          // "SS WEB CREATION",
                          style: GoogleFonts.manrope(
                            fontSize: 18.0,
                            color: MyColors.white,
                            letterSpacing: 0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () {
                              newDashboardController.goto("/company", arguments: {"back" : true});
                            },
                            child: Image.asset(
                              "assets/settings/change.png",
                              height: 25,
                              color: MyColors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      newDashboardController.company.NAME,
                      // "SS WEB CREATION",
                      style: GoogleFonts.manrope(
                        fontSize: 25.0,
                        color: MyColors.white,
                        letterSpacing: 0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Text(
                    "FIN. YEAR:  ${newDashboardController.company.YEAR}",
                    // "SS WEB CREATION",
                    style: GoogleFonts.manrope(
                      fontSize: 16.0,
                      color: MyColors.white,
                      letterSpacing: 0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  (newDashboardController.company.LOGO??"").isNotEmpty ?
                  CircleAvatar(
                    radius: Platform.isIOS ? 50 : 40,
                    backgroundColor: MyColors.white,
                    backgroundImage: NetworkImage(
                      ApiConstants.assetUrl+(newDashboardController.company.LOGO??"")
                    ),
                  )
                  : CircleAvatar(
                    radius: Platform.isIOS ? 50 : 40,
                    backgroundColor: MyColors.white,
                    child: Image.asset(
                      "assets/app_icon/icon.png",
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 8,
                        backgroundColor: MyColors.white,
                        child: Icon(
                          Icons.sync,
                          color: MyColors.colorSecondary,
                          size: 12,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        newDashboardController.company.LASTSYNCDATE,
                        style: GoogleFonts.manrope(
                          fontSize: 14.0,
                          color: MyColors.white,
                          letterSpacing: 0,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                      // RichText(
                      //   text: TextSpan(
                      //       text: 'Last Sync:\t',
                      //       style: GoogleFonts.manrope(
                      //         fontSize: 14.0,
                      //         color: MyColors.white,
                      //         letterSpacing: 0,
                      //         fontWeight: FontWeight.w600,
                      //       ),
                      //       children: [
                      //         TextSpan(
                      //           text: DateFormat("dd MMM, yyyy hh:mm a").format(newDashboardController.sync),
                      //           style: GoogleFonts.manrope(
                      //             fontSize: 14.0,
                      //             color: MyColors.white,
                      //             letterSpacing: 0,
                      //             fontWeight: FontWeight.w600,
                      //           ),
                      //         )
                      //       ]
                      //   ),
                      // )
                    ],
                  )
                ],
              )
              : Container(),
            ),
          ),
        ),
      ),
    );
  }

  Widget getCard(String icon, String title, String info) {
    return GestureDetector(
      onTap: () {
        if(title.contains("Sales Return")) {
          newDashboardController.goto("/salesReturn");
        }
        else if( title.contains("Purchase Return")) {
          newDashboardController.goto("/purchaseReturn");
        }
        else if(title.contains("Total Sales")) {
          newDashboardController.goto("/sales", arguments: {'type' : ApiConstants.latest});
        }
        else if( title.contains("Total Purchase")) {
          newDashboardController.goto("/purchase", arguments: {'type' : ApiConstants.latest});
        }
        else if(title.contains("Outstanding")) {
          newDashboardController.goto("/outstandingPayment", arguments: {"type" : title.substring(0, title.indexOf(" "))});
        }
        else if(title.contains("Orders")) {
          newDashboardController.goto("/order");
        }
        else if(title.contains("Rate List")) {
          newDashboardController.goto("/rateList");
        }
        else if(title.contains("Cash")) {
          newDashboardController.goto("/cash", arguments: {'type' : ApiConstants.latest});
        }
        else if(title.contains("Bank")) {
          newDashboardController.goto("/bank", arguments: {'type' : ApiConstants.latest});
        }
      },
      child: Card(
        elevation: 10,
        child: Container(
          height: 140,
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          decoration: BoxDecoration(
            color: MyColors.white,
            borderRadius: BorderRadius.circular(10)
          ),
          child: Column(
            children: [
              Image.asset(
                "assets/dashboard/$icon",
                height: 30,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                title,
                textAlign: TextAlign.center,
                style: GoogleFonts.manrope(
                  fontSize: 14.0,
                  color: MyColors.colorPrimary,
                  letterSpacing: 0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                info,
                textAlign: TextAlign.center,
                style: GoogleFonts.manrope(
                  fontSize: 15.0,
                  color: MyColors.colorPrimary,
                  letterSpacing: 0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}