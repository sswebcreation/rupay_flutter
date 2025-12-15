import 'package:bottom_picker/bottom_picker.dart';
import 'package:bottom_picker/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:rotated_corner_decoration/rotated_corner_decoration.dart';
import 'package:rupay/cache_manager/CacheManager.dart';
import 'package:rupay/colors/MyColors.dart';
import 'package:rupay/constants/CommonConstants.dart';
import 'package:rupay/controllers/ledger/LedgerController.dart';
import 'package:rupay/designer/button/Button.dart';
import 'package:rupay/models/ledger/LedgerModel.dart';
import 'package:rupay/services/networking/ApiConstants.dart';
import 'package:rupay/shared/widgets/CommonWidgets.dart';

class Ledger extends StatelessWidget {
  Ledger({ Key? key }) {
    ledgerController.onInit();
  }

  final LedgerController ledgerController =  Get.put<LedgerController>(LedgerController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LedgerController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Ledger",
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
              GestureDetector(
                onTap: () {
                  ledgerController.goto("/multiLedgerPDF", arguments: {"ledger" : ledgerController.ledgers, "sd" : ledgerController.sd, "ed" : ledgerController.ed});
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(
                      Icons.picture_as_pdf
                  ),
                ),
              )
            ],
          ),
          backgroundColor: MyColors.white,
          body: NotificationListener(
            onNotification: (ScrollNotification scrollInfo) {
              if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
                print("hello");
                ledgerController.getShowUpdate(ledgerController.show.length);
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
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        getFilters(context),
                        getCustomers(context),
                        // getStatus(context)
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            ledgerController.getLedgers();
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
                        // getTotalDesign(),
                        if(ledgerController.ledgers.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: TextFormField(
                              onChanged: (value) {
                                ledgerController.searchLedger();
                              },
                              controller: ledgerController.search,
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
                                  hintText: "Search Ledger",
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                                  prefixIcon: Icon(
                                      Icons.search
                                  )
                              ),
                            ),
                          ),
                        getLedgers()
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
              ledgerController.chooseDateFilter(context);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Row(
                children: [
                  Text(
                    ledgerController.selectedDF,
                    style: GoogleFonts.manrope(
                      fontSize: 14.0,
                      color: MyColors.colorSecondary,
                      letterSpacing: 0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Icon(
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
                      if(ledgerController.selectedDF=="Custom") {

                        BottomPicker.date(
                          initialDateTime: ledgerController.sd,
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
                              ledgerController.setDate(value, "sd");
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
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.calendar_month,
                            size: 18,
                          ),
                          Text(
                            ledgerController.getDateText(ledgerController.sd),
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
                      if(ledgerController.selectedDF=="Custom") {
                        BottomPicker.date(
                          initialDateTime: ledgerController.ed,
                          minDateTime: ledgerController.sd,
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
                              ledgerController.setDate(value, "ed");
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
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.calendar_month,
                            size: 18,
                          ),
                          Text(
                            ledgerController.getDateText(ledgerController.ed),
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
      children: List<Widget>.generate(ledgerController.filters.length, (int index) {
        return ChoiceChip(
          label: Text(ledgerController.filters[index]),
          labelStyle: GoogleFonts.manrope(
            color: MyColors.colorPrimary,
            fontSize: 14,
            fontWeight: FontWeight.w600
          ),
          padding: EdgeInsets.symmetric(horizontal: 5),
          backgroundColor: MyColors.colorPrimary.withOpacity(0.3),
          selected: false,
          onSelected: (bool selected) {
            if(ledgerController.filters[index]=="Account") {
              print(ledgerController.getCustomerList(index));
              ledgerController.goto("/account", arguments: {
                  "title": ledgerController.filters[index] + "s",
                  "list": ledgerController.getCustomerList(index),
                  "type": ApiConstants.allType
                }
              );
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
      children: List<Widget>.generate(ledgerController.customers.length, (int index) {
        return ChoiceChip(
          label: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(ledgerController.customers[index].NAME),
              SizedBox(
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
          padding: EdgeInsets.symmetric(horizontal: 1),
          backgroundColor: MyColors.colorSecondary.withOpacity(0.3),
          selected: false,
          onSelected: (bool selected) {
            ledgerController.removeCustomer(ledgerController.customers[index]);
          },
        );
      }),
    );
  }

  Widget getLedgers() {
    double amount = 0;
    return ledgerController.load ?
    ledgerController.loaded==false || ledgerController.show.isNotEmpty ? ListView.separated(
      itemCount: ledgerController.show.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(vertical: 10),
      separatorBuilder: (BuildContext buildContext, int index) {
        return SizedBox(
          height: 3,
        );
      },
      itemBuilder: (BuildContext buildContext, int index) {

        LedgerModel led = ledgerController.show[index];
        if(index==0) {
          amount = 0;
        }
        else if(led.ACCOUNTCODE!=ledgerController.show[index-1].ACCOUNTCODE) {
          amount = 0;
        }

        if(led.Amount?.isNegative==true) {
          amount += (led.Amount??0).abs();
        }
        else {
          amount -= (led.Amount??0).abs();
        }
        return getLedgerDesign(index, led, amount);
      },
    ) : Container(
      padding: EdgeInsets.only(top: 40),
      alignment: Alignment.center,
      child: Text(
        "No Records Found",
        style: GoogleFonts.manrope(
            color: MyColors.black,
            fontSize: 16,
            fontWeight: FontWeight.w600
        ),
      ),
    )
    : Container(
      padding: EdgeInsets.only(top: 20),
      alignment: Alignment.center,
      child: CircularProgressIndicator(
        color: MyColors.colorPrimary,
      ),
    );
  }

  Widget getLedgerDesign(int index, LedgerModel ledger, double amount) {
    return GestureDetector(
      onTap: () {
        // ledgerController.goto("/singleledgerPDF", arguments: ledger.ID);
      },
      child: Card(
        elevation: 10,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          decoration: BoxDecoration(
            color: MyColors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          foregroundDecoration: RotatedCornerDecoration.withColor(
            color: ledger.Amount?.isNegative==true ? MyColors.colorClear : MyColors.colorPending,
            // spanBaselineShift: 4,
            badgeSize: Size(30, 25),
            badgeCornerRadius: Radius.circular(5),
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
                            "PARTY: ${ledger.ACCOUNTNAME??""}",
                            style: GoogleFonts.manrope(
                                color: MyColors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w600
                            ),
                          ),
                          Text(
                            "CHEQUE NO.: "+(ledger.ChequeNo??""),
                            style: GoogleFonts.manrope(
                                color: MyColors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w600
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "DOC: #"+(ledger.DOCNUMBER??"").trim(),
                          style: GoogleFonts.manrope(
                              color: MyColors.colorGrey,
                              fontSize: 12,
                              fontWeight: FontWeight.w600
                          ),
                        ),
                        Text(
                          (ledger.DOCNUMBER.toString().trim()!="0") ? DateFormat("dd MMM, yyyy").format(DateTime.parse(ledger.TXNDATE??"")) : "Opening Balance",
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
              SizedBox(
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
                          "DEBIT",
                          style: GoogleFonts.manrope(
                              color: MyColors.colorGrey,
                              fontSize: 12,
                              fontWeight: FontWeight.w600
                          ),
                        ),
                        Text(
                          ledger.Amount?.isNegative==true ? (ledger.Amount??0).abs().toString() : "",
                          style: GoogleFonts.manrope(
                              color: MyColors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w600
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "CREDIT",
                          style: GoogleFonts.manrope(
                              color: MyColors.colorGrey,
                              fontSize: 12,
                              fontWeight: FontWeight.w600
                          ),
                        ),
                        Text(
                          ledger.Amount?.isNegative==true ? "" : (ledger.Amount??0).abs().toString(),
                          style: GoogleFonts.manrope(
                              color: MyColors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w600
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "BALANCE",
                          style: GoogleFonts.manrope(
                              color: MyColors.colorGrey,
                              fontSize: 12,
                              fontWeight: FontWeight.w600
                          ),
                        ),
                        Text(
                          amount.abs().toString(),
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
            ],
          ),
        ),
      ),
    );
  }


}