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
import 'package:rupay/controllers/cash/CashController.dart';
import 'package:rupay/designer/button/Button.dart';
import 'package:rupay/models/cash/CashModel.dart';
import 'package:rupay/services/networking/ApiConstants.dart';
import 'package:rupay/shared/widgets/CommonWidgets.dart';

class Cash extends StatelessWidget {
  Cash({ Key? key }) {
    cashController.onInit();
  }

  final CashController cashController =  Get.put<CashController>(CashController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CashController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Cash",
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

              if(cashController.selected_cashs.isNotEmpty)
                GestureDetector(
                  onTap: () {
                    cashController.changeSelectAll();
                  },
                  child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        cashController.selected_cashs.length==cashController.cash_temp.length ? "DESELECT ALL" : "SELECT ALL",
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
                  cashController.goto("/multiCashPDF", arguments: {"cash" : cashController.cashs, "sd" : cashController.sd, "ed" : cashController.ed});
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(
                      Icons.picture_as_pdf
                  ),
                ),
              ),
              cashController.selected_cashs.isEmpty
                  ?
              GestureDetector(
                onTap: () {
                  cashController.chooseType();
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(
                      Icons.add
                  ),
                ),
              ) : GestureDetector(
                onTap: () {
                  cashController.confirmDelete();
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
          body: NotificationListener(
            onNotification: (ScrollNotification scrollInfo) {
              if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
                print("hello");
                cashController.getShowUpdate(cashController.show.length);
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
                        getDaybooks(context),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            cashController.getCashs();
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
                        if(cashController.cashs.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: TextFormField(
                              onChanged: (value) {
                                cashController.searchCash();
                              },
                              controller: cashController.search,
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
                                  hintText: "Search Cash",
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                                  prefixIcon: const Icon(
                                      Icons.search
                                  )
                              ),
                            ),
                          ),
                        getCashs()
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
              cashController.chooseDateFilter(context);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Row(
                children: [
                  Text(
                    cashController.selectedDF,
                    style: GoogleFonts.manrope(
                      fontSize: 14.0,
                      color: MyColors.colorSecondary,
                      letterSpacing: 0,
                      fontWeight: FontWeight.w600,
                    ),
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
                      if(cashController.selectedDF=="Custom") {

                        BottomPicker.date(
                          initialDateTime: cashController.sd,
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
                              cashController.setDate(value, "sd");
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
                          const Icon(
                            Icons.calendar_month,
                            size: 18,
                          ),
                          Text(
                            cashController.getDateText(cashController.sd),
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
                      if(cashController.selectedDF=="Custom") {
                        BottomPicker.date(
                          initialDateTime: cashController.ed,
                          minDateTime: cashController.sd,
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
                              cashController.setDate(value, "ed");
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
                          const Icon(
                            Icons.calendar_month,
                            size: 18,
                          ),
                          Text(
                            cashController.getDateText(cashController.ed),
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
      children: List<Widget>.generate(cashController.filters.length, (int index) {
        return ChoiceChip(
          label: Text(cashController.filters[index]),
          labelStyle: GoogleFonts.manrope(
            color: MyColors.colorPrimary,
            fontSize: 14,
            fontWeight: FontWeight.w600
          ),
          padding: const EdgeInsets.symmetric(horizontal: 5),
          backgroundColor: MyColors.colorPrimary.withOpacity(0.3),
          selected: false,
          onSelected: (bool selected) {
            if(cashController.filters[index]=="Daybook") {
              cashController.goto("/daybook", arguments: {"list": cashController.getDaybookList(index), "endpoint" : ApiConstants.cashAPI});
            }
          },
        );
      }),
    );
  }

  Widget getDaybooks(BuildContext context) {
    return Wrap(
      spacing: 5,
      children: List<Widget>.generate(cashController.daybooks.length, (int index) {
        return ChoiceChip(
          label: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(cashController.daybooks[index].DAYBOOK),
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
            cashController.removeDaybook(cashController.daybooks[index]);
          },
        );
      }),
    );
  }

  Widget getCashs() {
    double amount = 0;
    return cashController.load ?
    cashController.loaded==false || cashController.show.isNotEmpty ? ListView.separated(
      itemCount: cashController.show.length,
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

        CashModel led = cashController.show[index];
        if(index==0) {
          amount = 0;
        }
        else if(led.ACCOUNTNAME!=cashController.show[index-1].ACCOUNTNAME) {
          amount = 0;
        }

        if(led.Amount?.isNegative==true) {
          amount += (led.Amount??0).abs();
        }
        else {
          amount -= (led.Amount??0).abs();
        }
        return getCashDesign(index, led, amount);
      },
    ) : Container(
      padding: const EdgeInsets.only(top: 40),
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
      padding: const EdgeInsets.only(top: 20),
      alignment: Alignment.center,
      child: CircularProgressIndicator(
        color: MyColors.colorPrimary,
      ),
    );
  }

  Widget getCashDesign(int index, CashModel cash, double amount) {
    return GestureDetector(
      onTap: () {
        if(cashController.selected_cashs.isEmpty) {
          // cashController.goto("/singleCashPDF", arguments: {"id" : cash.ID, "type" : "S", "entryType" : cashController.type});
        }
        else {
          cashController.changeSelectedCash(cash);
        }
      },
      onLongPress: () {
        cashController.changeSelectedCash(cash);
      },
      child: Card(
        elevation: 10,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          decoration: BoxDecoration(
            color: cashController.selected_cashs.contains(cash) ? MyColors.colorLightSecondary.withOpacity(0.5) : MyColors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          foregroundDecoration: RotatedCornerDecoration.withColor(
            color: cash.Amount?.isNegative==true ? MyColors.colorClear : MyColors.colorPending,
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
                            "PARTY: ${cash.ACCOUNTNAME??""}",
                            style: GoogleFonts.manrope(
                                color: MyColors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w600
                            ),
                          ),
                          Text(
                            "CHEQUE NO.: "+(cash.ChequeNo??""),
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
                          "DOC: #"+(cash.DOCNUMBER??"").trim(),
                          style: GoogleFonts.manrope(
                              color: MyColors.colorGrey,
                              fontSize: 12,
                              fontWeight: FontWeight.w600
                          ),
                        ),
                        Text(
                          (cash.DOCNUMBER.toString().trim()!="0") ? DateFormat("dd MMM, yyyy").format(DateTime.parse(cash.TXNDATE??"")) : "Opening Balance",
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
                          cash.Amount?.isNegative==true ? (cash.Amount??0).abs().toStringAsFixed(2) : "",
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
                          "CREDIT",
                          style: GoogleFonts.manrope(
                              color: MyColors.colorGrey,
                              fontSize: 12,
                              fontWeight: FontWeight.w600
                          ),
                        ),
                        Text(
                          cash.Amount?.isNegative==true ? "" : (cash.Amount??0).abs().toStringAsFixed(2),
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
                          "BALANCE",
                          style: GoogleFonts.manrope(
                              color: MyColors.colorGrey,
                              fontSize: 12,
                              fontWeight: FontWeight.w600
                          ),
                        ),
                        Text(
                          amount.abs().toStringAsFixed(2),
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