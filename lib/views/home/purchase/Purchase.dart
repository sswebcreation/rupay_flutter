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
import 'package:rupay/controllers/purchase/PurchaseController.dart';
import 'package:rupay/designer/button/Button.dart';
import 'package:rupay/essential/Essential.dart';
import 'package:rupay/models/purchase/PurchaseModel.dart';
import 'package:rupay/services/networking/ApiConstants.dart';
import 'package:rupay/shared/widgets/CommonWidgets.dart';

class Purchase extends StatelessWidget {
  Purchase({ Key? key }) : super(key: key);

  final PurchaseController purchaseController =  Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PurchaseController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Purchase",
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

              if(purchaseController.selected_purchases.isNotEmpty)
                GestureDetector(
                  onTap: () {
                    purchaseController.changeSelectAll();
                  },
                  child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        purchaseController.selected_purchases.length==purchaseController.purchases_temp.length ? "DESELECT ALL" : "SELECT ALL",
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
                  purchaseController.choosePDFType(context);
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(
                      Icons.picture_as_pdf
                  ),
                ),
              ),
              purchaseController.selected_purchases.isEmpty
                ? GestureDetector(
                  onTap: () {
                    purchaseController.goto("/addPurchase");
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Icon(
                        Icons.add
                    ),
                  ),
                )
                  : GestureDetector(
                onTap: () {
                  purchaseController.confirmDelete();
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(
                      Icons.delete
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
                  purchaseController.getShowUpdate(purchaseController.show.length);
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
                              purchaseController.getPurchase();
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
                          if(purchaseController.purchases.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: TextFormField(
                                onChanged: (value) {
                                  purchaseController.searchPurchase();
                                },
                                controller: purchaseController.search,
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
              purchaseController.chooseDateFilter(context);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Row(
                children: [
                  Text(
                    purchaseController.selectedDF,
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
                      if(purchaseController.selectedDF=="Custom") {
                        BottomPicker.date(
                          initialDateTime: purchaseController.sd,
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
                              purchaseController.setDate(value, "sd");
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
                            purchaseController.getDateText(purchaseController.sd),
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
                      if(purchaseController.selectedDF=="Custom") {
                        BottomPicker.date(
                          initialDateTime: purchaseController.ed,
                          minDateTime: purchaseController.sd,
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
                              purchaseController.setDate(value, "ed");
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
                            purchaseController.getDateText(purchaseController.ed),
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
      children: List<Widget>.generate(purchaseController.filters.length, (int index) {
        return ChoiceChip(
          label: Text(purchaseController.filters[index]),
          labelStyle: GoogleFonts.manrope(
              color: MyColors.colorPrimary,
              fontSize: 14,
              fontWeight: FontWeight.w600
          ),
          padding: const EdgeInsets.symmetric(horizontal: 5),
          backgroundColor: MyColors.colorPrimary.withOpacity(0.3),
          selected: false,
          onSelected: (bool selected) {
            if(purchaseController.filters[index]=="Status") {
              purchaseController.chooseStatus(context);
            }
            else if(purchaseController.filters[index]=="Daybook") {
              purchaseController.goto("/daybook", arguments: {"list": purchaseController.getDaybookList(index), "endpoint" : ApiConstants.purchaseAPI});
            }
            else {
              purchaseController.goto("/account", arguments: {
                "list": purchaseController.getList(index),
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
      children: List<Widget>.generate(purchaseController.customers.length, (int index) {
        return ChoiceChip(
          label: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(purchaseController.customers[index].NAME),
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
            purchaseController.removeCustomer(purchaseController.customers[index]);
          },
        );
      }),
    );
  }

  Widget getDaybooks(BuildContext context) {
    return Wrap(
      spacing: 5,
      children: List<Widget>.generate(purchaseController.daybooks.length, (int index) {
        return ChoiceChip(
          label: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(purchaseController.daybooks[index].DAYBOOK),
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
            purchaseController.removeDaybook(purchaseController.daybooks[index]);
          },
        );
      }),
    );
  }
  
  Widget getStatus(BuildContext context) {
    return Wrap(
      spacing: 5,
      children: List<Widget>.generate(purchaseController.status.length, (int index) {
        return ChoiceChip(
          label: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(purchaseController.status[index]),
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
            purchaseController.removeStatus(purchaseController.status[index]);
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
          getTotalCard("No. of Bills", purchaseController.purchases_temp.length.toString()),
          const SizedBox(
            width: 20,
          ),
          getTotalCard("Total Purchase", CommonConstants.rupee+purchaseController.amount.toStringAsFixed(2)),
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
    return purchaseController.load ?
    purchaseController.loaded==false || purchaseController.show.isNotEmpty ? ListView.separated(
      itemCount: purchaseController.show.length,
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
        return getPurchaseDesign(index, purchaseController.show[index]);
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
        if(purchaseController.selected_purchases.isEmpty) {
          purchaseController.goto("/singlePurchasePDF", arguments: {"id" : purchase.ID, "type" : "S", "entryType" : purchaseController.type});
        }
        else {
          purchaseController.changeSelectedPurchase(purchase);
        }
      },
      onLongPress: () {
       purchaseController.changeSelectedPurchase(purchase);
      },
      child: Card(
        elevation: 10,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          decoration: BoxDecoration(
            color: purchaseController.selected_purchases.contains(purchase) ? MyColors.colorLightSecondary.withOpacity(0.5) : MyColors.white,
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
                          "BILL: #${(purchase.PARTYBILLNO??"").trim()}",
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
                  if((purchaseController.company.Q1??"").isNotEmpty)
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            purchaseController.company.Q1??"",
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

                  if((purchaseController.company.Q2??"").isNotEmpty)
                    const SizedBox(
                      width: 5,
                    ),
                  if((purchaseController.company.Q2??"").isNotEmpty)
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            purchaseController.company.Q2??"",
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

                  if((purchaseController.company.Q3??"").isNotEmpty)
                    const SizedBox(
                      width: 5,
                    ),
                  if((purchaseController.company.Q3??"").isNotEmpty)
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            purchaseController.company.Q3??"",
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