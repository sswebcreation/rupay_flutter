import 'dart:convert';

import 'package:bottom_picker/bottom_picker.dart';
import 'package:bottom_picker/resources/arrays.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:rotated_corner_decoration/rotated_corner_decoration.dart';
import 'package:rupay/colors/MyColors.dart';
import 'package:rupay/constants/CommonConstants.dart';
import 'package:rupay/controllers/sales/SalesController.dart';
import 'package:rupay/designer/button/Button.dart';
import 'package:rupay/essential/Essential.dart';
import 'package:rupay/models/sales/SalesModel.dart';
import 'package:rupay/services/networking/ApiConstants.dart';
import 'package:rupay/shared/widgets/CommonWidgets.dart';

class Sales extends StatelessWidget {
  Sales({ Key? key }) : super(key: key);

  final SalesController salesController =  Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SalesController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Sales",
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
              if(salesController.selected_sales.isNotEmpty)
                GestureDetector(
                  onTap: () {
                    salesController.changeSelectAll();
                  },
                  child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        salesController.selected_sales.length==salesController.sales_temp.length ? "DESELECT ALL" : "SELECT ALL",
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
                  salesController.choosePDFType(context);
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(
                      Icons.picture_as_pdf
                  ),
                ),
              ),
              salesController.selected_sales.isEmpty
              ? GestureDetector(
                  onTap: () {
                    salesController.goto("/addSales");
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
                    salesController.confirmDelete();
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
                  salesController.getShowUpdate(salesController.show.length);
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
                              salesController.getSales();
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
                          if(salesController.sales.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: TextFormField(
                                onChanged: (value) {
                                  salesController.searchSales();
                                },
                                controller: salesController.search,
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
                                    hintText: "Search Sales",
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                                    prefixIcon: const Icon(
                                        Icons.search
                                    )
                                ),
                              ),
                            ),
                          getSales()
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
              salesController.chooseDateFilter(context);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Row(
                children: [
                  Text(
                    salesController.selectedDF,
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
                      if(salesController.selectedDF=="Custom") {
                        BottomPicker.date(
                          initialDateTime: salesController.sd,
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
                              salesController.setDate(value, "sd");
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
                            salesController.getDateText(salesController.sd),
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
                      if(salesController.selectedDF=="Custom") {
                        BottomPicker.date(
                          initialDateTime: salesController.ed,
                          minDateTime: salesController.sd,
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
                              salesController.setDate(value, "ed");
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
                            salesController.getDateText(salesController.ed),
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
      children: List<Widget>.generate(salesController.filters.length, (int index) {
        return ChoiceChip(
          label: Text(salesController.filters[index]),
          labelStyle: GoogleFonts.manrope(
              color: MyColors.colorPrimary,
              fontSize: 14,
              fontWeight: FontWeight.w600
          ),
          padding: const EdgeInsets.symmetric(horizontal: 5),
          backgroundColor: MyColors.colorPrimary.withOpacity(0.3),
          selected: false,
          onSelected: (bool selected) {
            if(salesController.filters[index]=="Status") {
              salesController.chooseStatus(context);
            }
            else if(salesController.filters[index]=="Daybook") {
              salesController.goto("/daybook", arguments: {"list": salesController.getDaybookList(index), "endpoint" : ApiConstants.salesAPI});
            }
            else {
              salesController.goto("/account", arguments: {"list": salesController.getList(index), "type" : ApiConstants.salesType, 'title' : "Customers"});
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
      children: List<Widget>.generate(salesController.customers.length, (int index) {
        return ChoiceChip(
          label: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(salesController.customers[index].NAME),
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
            salesController.removeCustomer(salesController.customers[index]);
          },
        );
      }),
    );
  }

  Widget getDaybooks(BuildContext context) {
    return Wrap(
      spacing: 5,
      children: List<Widget>.generate(salesController.daybooks.length, (int index) {
        return ChoiceChip(
          label: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(salesController.daybooks[index].DAYBOOK),
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
            salesController.removeDaybook(salesController.daybooks[index]);
          },
        );
      }),
    );
  }

  Widget getStatus(BuildContext context) {
    return Wrap(
      spacing: 5,
      children: List<Widget>.generate(salesController.status.length, (int index) {
        return ChoiceChip(
          label: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(salesController.status[index]),
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
            salesController.removeStatus(salesController.status[index]);
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
          getTotalCard("No. of Bills", salesController.sales_temp.length.toString()),
          const SizedBox(
            width: 20,
          ),
          getTotalCard("Total Sales", CommonConstants.rupee+salesController.amount.toStringAsFixed(2)),
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

  Widget getSales() {
    return salesController.load ?
    salesController.loaded==false || salesController.show.isNotEmpty ? ListView.separated(
      itemCount: salesController.show.length,
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
        return getSalesDesign(index, salesController.show[index]);
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

  Widget getSalesDesign(int index, SalesModel sales) {

    print("salesssss");
    print(sales);
    print(sales.ITEMS);
    DateTime date = DateTime.now();
    date = DateTime(date.year, date.month, date.day);
    int dueDays = (sales.DUEDAYS??0).toInt();
    DateTime due = DateTime.parse(sales.TXNDATE??"").add(Duration(days: dueDays));

    return GestureDetector(
      onTap: () {
        if(salesController.selected_sales.isEmpty) {
          salesController.goto("/singleSalesPDF", arguments: {"id" : sales.ID, "type" : "S", "entryType" : salesController.type});
        }
        else {
          salesController.changeSelectedSales(sales);
        }
      },
      onLongPress: () {
       salesController.changeSelectedSales(sales);
      },
      child: Card(
        elevation: 10,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          decoration: BoxDecoration(
            color: salesController.selected_sales.contains(sales) ? MyColors.colorLightSecondary.withOpacity(0.5) : MyColors.white,
            borderRadius: BorderRadius.circular(5),
            border: sales.PendingStatus=="FULL PENDING" && due.difference(date).isNegative ?
            Border.all(
              color: MyColors.colorPending
            )
            : null
          ),
          foregroundDecoration: RotatedCornerDecoration.withColor(
            color: sales.PendingStatus=="CLEAR" ? MyColors.colorClear : sales.PendingStatus=="FULL PENDING"  ? MyColors.colorPending : MyColors.colorPartial,
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
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "LR NO.: "+(sales.LRNO??""),
                            style: GoogleFonts.manrope(
                              color: MyColors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w600
                            ),
                          ),
                          Text(
                            sales.TRANSPORT??"",
                            maxLines: 2,
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "BILL: #"+(sales.DOCNUMBER??"").trim(),
                          style: GoogleFonts.manrope(
                              color: MyColors.colorGrey,
                              fontSize: 12,
                              fontWeight: FontWeight.w600
                          ),
                        ),
                        Text(
                          DateFormat("dd MMM, yyyy").format(DateTime.parse(sales.TXNDATE??"")),
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
                  "PARTY: ${sales.ACCOUNTNAME??""}",
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
                  "ITEMS: ${Essential.getItems(sales.ITEMS??"")}",
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
                  if((salesController.company.Q1??"").isNotEmpty)
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            salesController.company.Q1??"",
                            style: GoogleFonts.manrope(
                                color: MyColors.colorGrey,
                                fontSize: 12,
                                fontWeight: FontWeight.w600
                            ),
                          ),
                          Text(
                            Essential.getQuantity(sales.Q1??""),
                            style: GoogleFonts.manrope(
                                color: MyColors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w600
                            ),
                          )
                        ],
                      ),
                    ),

                  if((salesController.company.Q2??"").isNotEmpty)
                    const SizedBox(
                      width: 5,
                    ),
                  if((salesController.company.Q2??"").isNotEmpty)
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            salesController.company.Q2??"",
                            style: GoogleFonts.manrope(
                                color: MyColors.colorGrey,
                                fontSize: 12,
                                fontWeight: FontWeight.w600
                            ),
                          ),
                          Text(
                            Essential.getQuantity(sales.Q2??""),
                            style: GoogleFonts.manrope(
                                color: MyColors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w600
                            ),
                          )
                        ],
                      ),
                    ),

                  if((salesController.company.Q3??"").isNotEmpty)
                    const SizedBox(
                      width: 5,
                    ),
                  if((salesController.company.Q3??"").isNotEmpty)
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            salesController.company.Q3??"",
                            style: GoogleFonts.manrope(
                                color: MyColors.colorGrey,
                                fontSize: 12,
                                fontWeight: FontWeight.w600
                            ),
                          ),
                          Text(
                            Essential.getQuantity(sales.Q3??""),
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
                          CommonConstants.rupee+(sales.TAXABLEAMT??0).toStringAsFixed(2),
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
                          CommonConstants.rupee+(sales.GST??0).toStringAsFixed(2),
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
                          CommonConstants.rupee+(sales.NETAMOUNT??0).toStringAsFixed(2),
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
              if((sales.PendingStatus??"").contains("PART PENDING"))
                getPendingDesign(sales.PendingStatus??"")
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