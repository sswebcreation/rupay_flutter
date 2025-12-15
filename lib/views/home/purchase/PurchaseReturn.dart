import 'dart:convert';

import 'package:bottom_picker/bottom_picker.dart';
import 'package:bottom_picker/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:rotated_corner_decoration/rotated_corner_decoration.dart';
import 'package:rupay/colors/MyColors.dart';
import 'package:rupay/constants/CommonConstants.dart';
import 'package:rupay/controllers/purchase/PurchaseReturnController.dart';
import 'package:rupay/designer/button/Button.dart';
import 'package:rupay/essential/Essential.dart';
import 'package:rupay/models/purchase/PurchaseModel.dart';
import 'package:rupay/services/networking/ApiConstants.dart';
import 'package:rupay/shared/widgets/CommonWidgets.dart';

class PurchaseReturn extends StatelessWidget {
  PurchaseReturn({ Key? key }) : super(key: key);

  final PurchaseReturnController purchaseReturnController =  Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PurchaseReturnController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Purchase Return",
              style: GoogleFonts.manrope(
                fontSize: 16.0,
                color: MyColors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            centerTitle: true,
            backgroundColor: MyColors.colorSecondary,
            iconTheme: IconThemeData(
                color: MyColors.white
            ),
            elevation: 0,
            actions: [

              if(purchaseReturnController.selected_purchases.isNotEmpty)
                GestureDetector(
                  onTap: () {
                    purchaseReturnController.changeSelectAll();
                  },
                  child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        purchaseReturnController.selected_purchases.length==purchaseReturnController.purchases_temp.length ? "DESELECT ALL" : "SELECT ALL",
                        style: GoogleFonts.manrope(
                          fontSize: 14.0,
                          color: MyColors.white,
                          letterSpacing: 0,
                          fontWeight: FontWeight.w700,
                        ),
                      )
                  ),
                ),
              GestureDetector(
                onTap: () {
                  purchaseReturnController.choosePDFType(context);
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(
                      Icons.picture_as_pdf
                  ),
                ),
              ),
            ],
          ),
          backgroundColor: MyColors.white,
          body: NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
                  print("hello");
                  purchaseReturnController.getShowUpdate(purchaseReturnController.show.length);
                }
                return true;
              },
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getDates(context),
                    horizontalDivider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          getFilters(context),
                          getCustomers(context),
                          getDaybooks(context),
                          getStatus(context)
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              purchaseReturnController.getPurchase();
                            },
                            child: standardButton(
                              context: context,
                              backgroundColor: MyColors.colorPrimary,
                              borderColor: MyColors.colorPrimary,
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: Center(
                                child: Text(
                                  'SHOW',
                                  style: GoogleFonts.manrope(
                                    fontSize: 16.0,
                                    color: MyColors.white,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          getTotalDesign(),
                          if(purchaseReturnController.purchases.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: TextFormField(
                                onChanged: (value) {
                                  purchaseReturnController.searchPurchase();
                                },
                                controller: purchaseReturnController.search,
                                style: GoogleFonts.manrope(
                                  fontSize: 16.0,
                                  color: MyColors.black,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w400,
                                ),
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: MyColors.colorButton,
                                      ),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    hintText: "Search Purchase",
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                                    prefixIcon: const Icon(
                                        Icons.search
                                    )
                                ),
                              ),
                            ),
                          getPurchase()
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
        );
      },
    );
  }


  Widget getDates(BuildContext context) {
    return SizedBox(
      height: 45,
      child: Row(
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              purchaseReturnController.chooseDateFilter(context);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Row(
                children: [
                  Text(
                    purchaseReturnController.selectedDF,
                    style: GoogleFonts.manrope(
                      fontSize: 14.0,
                      color: MyColors.colorSecondary,
                      letterSpacing: 0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Icon(
                    Icons.keyboard_arrow_down,
                    size: 22,
                  )
                ],
              ),
            ),
          ),
          verticalDivider(),
          Flexible(
            child: Row(
              children: [
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      if(purchaseReturnController.selectedDF=="Custom") {
                        BottomPicker.date(
                          initialDateTime: purchaseReturnController.sd,
                          maxDateTime: DateTime.now(),
                          pickerTitle: Text(
                            "Select Start Date",
                            style: GoogleFonts.manrope(
                              fontSize: 16.0,
                              color: MyColors.colorSecondary,
                              letterSpacing: 0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          onSubmit: (value) {
                            if (value != null) {
                              purchaseReturnController.setDate(value, "sd");
                            }
                          },
                          bottomPickerTheme: BottomPickerTheme.plumPlate,
                          
                          buttonContent: Text(
                            "Done",
                            style: GoogleFonts.manrope(
                              fontSize: 16.0,
                              color: MyColors.black,
                              letterSpacing: 0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          buttonSingleColor: Colors.transparent,
                          displaySubmitButton: true,
                        ).show(context);
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(
                            Icons.calendar_month,
                            size: 18,
                          ),
                          Text(
                            purchaseReturnController.getDateText(purchaseReturnController.sd),
                            style: GoogleFonts.manrope(
                              fontSize: 14.0,
                              color: MyColors.black,
                              letterSpacing: 0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                verticalDivider(),
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      if(purchaseReturnController.selectedDF=="Custom") {
                        BottomPicker.date(
                          initialDateTime: purchaseReturnController.ed,
                          minDateTime: purchaseReturnController.sd,
                          pickerTitle: Text(
                            "Select End Date",
                            style: GoogleFonts.manrope(
                              fontSize: 16.0,
                              color: MyColors.colorSecondary,
                              letterSpacing: 0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          onSubmit: (value) {
                            if (value != null) {
                              purchaseReturnController.setDate(value, "ed");
                            }
                          },
                          bottomPickerTheme: BottomPickerTheme.plumPlate,
                          
                          buttonContent: Text(
                            "Done",
                            style: GoogleFonts.manrope(
                              fontSize: 16.0,
                              color: MyColors.black,
                              letterSpacing: 0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          buttonSingleColor: Colors.transparent,
                          displaySubmitButton: true,
                        ).show(context);
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(
                            Icons.calendar_month,
                            size: 18,
                          ),
                          Text(
                            purchaseReturnController.getDateText(purchaseReturnController.ed),
                            style: GoogleFonts.manrope(
                              fontSize: 14.0,
                              color: MyColors.black,
                              letterSpacing: 0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget getFilters(BuildContext context) {
    return Wrap(
      spacing: 5,
      children: List<Widget>.generate(purchaseReturnController.filters.length, (int index) {
        return ChoiceChip(
          label: Text(purchaseReturnController.filters[index]),
          labelStyle: GoogleFonts.manrope(
              color: MyColors.colorPrimary,
              fontSize: 14,
              fontWeight: FontWeight.w600
          ),
          padding: const EdgeInsets.symmetric(horizontal: 5),
          backgroundColor: MyColors.colorPrimary.withOpacity(0.3),
          selected: false,
          onSelected: (bool selected) {
            if(purchaseReturnController.filters[index]=="Status") {
              purchaseReturnController.chooseStatus(context);
            }
            else if(purchaseReturnController.filters[index]=="Daybook") {
              purchaseReturnController.goto("/daybook", arguments: {"list": purchaseReturnController.getDaybookList(index), "endpoint" : ApiConstants.purchaseReturnAPI});
            }
            else {
              purchaseReturnController.goto("/account", arguments: {
                "list": purchaseReturnController.getList(index),
                "type": ApiConstants.purchaseType,
                'title' : "Vendors"
              });
            }
            // setState(() {
            //   isSelected[index] = selected;
            // });
          },
        );
      }),
    );
  }

  Widget getCustomers(BuildContext context) {
    return Wrap(
      spacing: 5,
      children: List<Widget>.generate(purchaseReturnController.customers.length, (int index) {
        return ChoiceChip(
          label: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(purchaseReturnController.customers[index].NAME),
              const SizedBox(
                width: 3,
              ),
              Icon(
                Icons.close,
                size: 16,
                color: MyColors.colorDarkSecondary,
              )
            ],
          ),
          labelStyle: GoogleFonts.manrope(
              color: MyColors.colorSecondary,
              fontSize: 12,
              fontWeight: FontWeight.w700
          ),
          padding: const EdgeInsets.symmetric(horizontal: 1),
          backgroundColor: MyColors.colorSecondary.withOpacity(0.3),
          selected: false,
          onSelected: (bool selected) {
            purchaseReturnController.removeCustomer(purchaseReturnController.customers[index]);
          },
        );
      }),
    );
  }

  Widget getDaybooks(BuildContext context) {
    return Wrap(
      spacing: 5,
      children: List<Widget>.generate(purchaseReturnController.daybooks.length, (int index) {
        return ChoiceChip(
          label: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(purchaseReturnController.daybooks[index].DAYBOOK),
              const SizedBox(
                width: 3,
              ),
              Icon(
                Icons.close,
                size: 16,
                color: MyColors.colorDarkSecondary,
              )
            ],
          ),
          labelStyle: GoogleFonts.manrope(
              color: MyColors.colorSecondary,
              fontSize: 12,
              fontWeight: FontWeight.w700
          ),
          padding: const EdgeInsets.symmetric(horizontal: 1),
          backgroundColor: MyColors.colorSecondary.withOpacity(0.3),
          selected: false,
          onSelected: (bool selected) {
            purchaseReturnController.removeDaybook(purchaseReturnController.daybooks[index]);
          },
        );
      }),
    );
  }
  
  Widget getStatus(BuildContext context) {
    return Wrap(
      spacing: 5,
      children: List<Widget>.generate(purchaseReturnController.status.length, (int index) {
        return ChoiceChip(
          label: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(purchaseReturnController.status[index]),
              const SizedBox(
                width: 3,
              ),
              Icon(
                Icons.close,
                size: 16,
                color: MyColors.colorDarkSecondary,
              )
            ],
          ),
          labelStyle: GoogleFonts.manrope(
              color: MyColors.colorSecondary,
              fontSize: 12,
              fontWeight: FontWeight.w700
          ),
          padding: const EdgeInsets.symmetric(horizontal: 1),
          backgroundColor: MyColors.colorSecondary.withOpacity(0.3),
          selected: false,
          onSelected: (bool selected) {
            purchaseReturnController.removeStatus(purchaseReturnController.status[index]);
          },
        );
      }),
    );
  }

  Widget getTotalDesign() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          getTotalCard("No. of Bills", purchaseReturnController.purchases_temp.length.toString()),
          const SizedBox(
            width: 20,
          ),
          getTotalCard("Total Purchase", CommonConstants.rupee+purchaseReturnController.amount.toStringAsFixed(2)),
        ],
      ),
    );
  }

  Widget getTotalCard(String title, String data) {
    return Flexible(
      flex: 1,
      fit: FlexFit.tight,
      child: Container(
        height: 70,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
            color: MyColors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: MyColors.colorSecondary)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              maxLines: 1,
              style: GoogleFonts.manrope(
                  color: MyColors.colorGrey,
                  fontSize: 14,
                  fontWeight: FontWeight.w600
              ),
            ),
            Flexible(
              child: Text(
                data,
                style: GoogleFonts.manrope(
                    color: MyColors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w600
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getPurchase() {
    return purchaseReturnController.load ?
    purchaseReturnController.loaded==false || purchaseReturnController.show.isNotEmpty ? ListView.separated(
      itemCount: purchaseReturnController.show.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 10),
      separatorBuilder: (BuildContext buildContext, int index) {
        return const SizedBox(
          height: 3,
        );
      },
      itemBuilder: (BuildContext buildContext, int index) {
        return getPurchaseDesign(index, purchaseReturnController.show[index]);
      },
    ) : Container(
      padding: EdgeInsets.only(top: 40),
      alignment: Alignment.center,
      child: Text(
        "No Bills Found",
        style: GoogleFonts.manrope(
            color: MyColors.black,
            fontSize: 16,
            fontWeight: FontWeight.w600
        ),
      ),
    )
    : Container(
      padding: EdgeInsets.only(top: 40),
      alignment: Alignment.center,
      child: CircularProgressIndicator(
        color: MyColors.colorPrimary,
      ),
    );
  }

  Widget getPurchaseDesign(int index, PurchaseModel purchase) {

    print("purchasessss");
    print(purchase);
    print(purchase.ITEMS);
    DateTime date = DateTime.now();
    date = DateTime(date.year, date.month, date.day);
    int dueDays = (purchase.DUEDAYS??0).toInt();
    DateTime due = DateTime.parse(purchase.TXNDATE??"").add(Duration(days: dueDays));

    return GestureDetector(
      onTap: () {
        if(purchaseReturnController.selected_purchases.isEmpty) {
          purchaseReturnController.goto("/singlePurchaseReturnPDF", arguments: {"id" : purchase.ID, "type" : "S"});
        }
        else {
          purchaseReturnController.changeSelectedPurchase(purchase);
        }
      },
      onLongPress: () {
       purchaseReturnController.changeSelectedPurchase(purchase);
      },
      child: Card(
        elevation: 10,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          decoration: BoxDecoration(
            color: purchaseReturnController.selected_purchases.contains(purchase) ? MyColors.colorLightSecondary.withOpacity(0.5) : MyColors.white,
            borderRadius: BorderRadius.circular(5),
            border: purchase.PendingStatus=="FULL PENDING" && due.difference(date).isNegative ?
            Border.all(
              color: MyColors.colorPending
            )
            : null
          ),
          foregroundDecoration: RotatedCornerDecoration.withColor(
            color: purchase.PendingStatus=="CLEAR" ? MyColors.colorClear : purchase.PendingStatus=="FULL PENDING"  ? MyColors.colorPending : MyColors.colorPartial,
            // spanBaselineShift: 4,
            badgeSize: const Size(30, 25),
            badgeCornerRadius: const Radius.circular(5),
            badgePosition: BadgePosition.topStart,
            // textSpan: TextSpan(
            //   text: 'OMG',
            //   style: TextStyle(
            //     color: Colors.white,
            //     fontSize: 12,
            //     letterSpacing: 1,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "BILL: #"+(purchase.DOCNUMBER??"").trim(),
                          style: GoogleFonts.manrope(
                              color: MyColors.colorGrey,
                              fontSize: 12,
                              fontWeight: FontWeight.w600
                          ),
                        ),
                        Text(
                          DateFormat("dd MMM, yyyy").format(DateTime.parse(purchase.TXNDATE??"")),
                          style: GoogleFonts.manrope(
                              color: MyColors.colorGrey,
                              fontSize: 12,
                              fontWeight: FontWeight.w600
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, top: 2),
                child: Text(
                  "PARTY: ${purchase.ACCOUNTNAME??""}",
                  style: GoogleFonts.manrope(
                      color: MyColors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w600
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text(
                  "ITEMS: ${Essential.getItems(purchase.ITEMS??"")}",
                  style: GoogleFonts.manrope(
                    color: MyColors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w600
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if((purchaseReturnController.company.Q1??"").isNotEmpty)
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            purchaseReturnController.company.Q1??"",
                            style: GoogleFonts.manrope(
                                color: MyColors.colorGrey,
                                fontSize: 12,
                                fontWeight: FontWeight.w600
                            ),
                          ),
                          Text(
                            Essential.getQuantity(purchase.Q1??""),
                            style: GoogleFonts.manrope(
                                color: MyColors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w600
                            ),
                          )
                        ],
                      ),
                    ),

                  if((purchaseReturnController.company.Q2??"").isNotEmpty)
                    const SizedBox(
                      width: 5,
                    ),
                  if((purchaseReturnController.company.Q2??"").isNotEmpty)
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            purchaseReturnController.company.Q2??"",
                            style: GoogleFonts.manrope(
                                color: MyColors.colorGrey,
                                fontSize: 12,
                                fontWeight: FontWeight.w600
                            ),
                          ),
                          Text(
                            Essential.getQuantity(purchase.Q2??""),
                            style: GoogleFonts.manrope(
                                color: MyColors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w600
                            ),
                          )
                        ],
                      ),
                    ),

                  if((purchaseReturnController.company.Q3??"").isNotEmpty)
                    const SizedBox(
                      width: 5,
                    ),
                  if((purchaseReturnController.company.Q3??"").isNotEmpty)
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            purchaseReturnController.company.Q3??"",
                            style: GoogleFonts.manrope(
                                color: MyColors.colorGrey,
                                fontSize: 12,
                                fontWeight: FontWeight.w600
                            ),
                          ),
                          Text(
                            Essential.getQuantity(purchase.Q3??""),
                            style: GoogleFonts.manrope(
                                color: MyColors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w600
                            ),
                          )
                        ],
                      ),
                    ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "TAXABLE",
                          style: GoogleFonts.manrope(
                              color: MyColors.colorGrey,
                              fontSize: 12,
                              fontWeight: FontWeight.w600
                          ),
                        ),
                        Text(
                          CommonConstants.rupee+(purchase.TAXABLEAMT??0).toStringAsFixed(2),
                          style: GoogleFonts.manrope(
                              color: MyColors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w600
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "GST",
                          style: GoogleFonts.manrope(
                              color: MyColors.colorGrey,
                              fontSize: 12,
                              fontWeight: FontWeight.w600
                          ),
                        ),
                        Text(
                          CommonConstants.rupee+(purchase.GST??0).toStringAsFixed(2),
                          style: GoogleFonts.manrope(
                              color: MyColors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w600
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "NET",
                          style: GoogleFonts.manrope(
                              color: MyColors.colorGrey,
                              fontSize: 12,
                              fontWeight: FontWeight.w600
                          ),
                        ),
                        Text(
                          CommonConstants.rupee+(purchase.NETAMOUNT??0).toStringAsFixed(2),
                          style: GoogleFonts.manrope(
                              color: MyColors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w600
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              if((purchase.PendingStatus??"").contains("PART PENDING"))
                getPendingDesign(purchase.PendingStatus??"")
            ],
          ),
        ),
      ),
    );
  }

  getPendingDesign(String desc) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Flexible(
              child: Container(
                color: MyColors.colorPartial,
                padding: const EdgeInsets.all(5),
                alignment: Alignment.center,
                child: Text(
                  desc,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.manrope(
                      color: MyColors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

}