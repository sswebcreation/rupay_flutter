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
import 'package:rupay/controllers/bank/BankController.dart';
import 'package:rupay/designer/button/Button.dart';
import 'package:rupay/models/bank/BankModel.dart';
import 'package:rupay/services/networking/ApiConstants.dart';
import 'package:rupay/shared/widgets/CommonWidgets.dart';

class Bank extends StatelessWidget {
  Bank({ Key? key }) {
    bankController.onInit();
  }

  final BankController bankController =  Get.put<BankController>(BankController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BankController>(
      builder: (controller) {
        return Scaffold(
            appBar: AppBar(
              title: Text(
                "Bank",
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

                if(bankController.selected_banks.isNotEmpty)
                  GestureDetector(
                    onTap: () {
                      bankController.changeSelectAll();
                    },
                    child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          bankController.selected_banks.length==bankController.bank_temp.length ? "DESELECT ALL" : "SELECT ALL",
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
                    bankController.goto("/multiBankPDF", arguments: {"bank" : bankController.banks, "sd" : bankController.sd, "ed" : bankController.ed});
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Icon(
                        Icons.picture_as_pdf
                    ),
                  ),
                ),
                bankController.selected_banks.isEmpty
                    ?
                GestureDetector(
                  onTap: () {
                    bankController.chooseType();
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Icon(
                        Icons.add
                    ),
                  ),
                ) : GestureDetector(
                  onTap: () {
                    bankController.confirmDelete();
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
                  bankController.getShowUpdate(bankController.show.length);
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
                          getDaybooks(context),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              bankController.getBanks();
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
                          if(bankController.banks.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: TextFormField(
                                onChanged: (value) {
                                  bankController.searchBank();
                                },
                                controller: bankController.search,
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
                                    hintText: "Search Bank",
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                                    prefixIcon: Icon(
                                        Icons.search
                                    )
                                ),
                              ),
                            ),
                          getBanks()
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
              bankController.chooseDateFilter(context);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Row(
                children: [
                  Text(
                    bankController.selectedDF,
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
                      if(bankController.selectedDF=="Custom") {

                        BottomPicker.date(
                          initialDateTime: bankController.sd,
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
                              bankController.setDate(value, "sd");
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
                            bankController.getDateText(bankController.sd),
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
                      if(bankController.selectedDF=="Custom") {
                        BottomPicker.date(
                          initialDateTime: bankController.ed,
                          minDateTime: bankController.sd,
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
                              bankController.setDate(value, "ed");
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
                            bankController.getDateText(bankController.ed),
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
      children: List<Widget>.generate(bankController.filters.length, (int index) {
        return ChoiceChip(
          label: Text(bankController.filters[index]),
          labelStyle: GoogleFonts.manrope(
              color: MyColors.colorPrimary,
              fontSize: 14,
              fontWeight: FontWeight.w600
          ),
          padding: EdgeInsets.symmetric(horizontal: 5),
          backgroundColor: MyColors.colorPrimary.withOpacity(0.3),
          selected: false,
          onSelected: (bool selected) {
            if(bankController.filters[index]=="Daybook") {
              bankController.goto("/daybook", arguments: {"list": bankController.getDaybookList(index), "endpoint" : ApiConstants.bankAPI});
            }
          },
        );
      }),
    );
  }

  Widget getDaybooks(BuildContext context) {
    return Wrap(
      spacing: 5,
      children: List<Widget>.generate(bankController.daybooks.length, (int index) {
        return ChoiceChip(
          label: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(bankController.daybooks[index].DAYBOOK),
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
            bankController.removeDaybook(bankController.daybooks[index]);
          },
        );
      }),
    );
  }
  
  Widget getBanks() {
    double amount = 0;
    return bankController.load ?
    bankController.loaded==false || bankController.show.isNotEmpty ? ListView.separated(
      itemCount: bankController.show.length,
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

        BankModel led = bankController.show[index];
        if(index==0) {
          amount = 0;
        }
        else if(led.ACCOUNTNAME!=bankController.show[index-1].ACCOUNTNAME) {
          amount = 0;
        }

        if(led.Amount?.isNegative==true) {
          amount += (led.Amount??0).abs();
        }
        else {
          amount -= (led.Amount??0).abs();
        }
        return getBankDesign(index, led, amount);
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

  Widget getBankDesign(int index, BankModel bank, double amount) {
    return GestureDetector(
      onTap: () {
        if(bankController.selected_banks.isEmpty) {
          // bankController.goto("/singleBankPDF", arguments: {"id" : bank.ID, "type" : "S", "entryType" : bankController.type});
        }
        else {
          bankController.changeSelectedBank(bank);
        }
      },
      onLongPress: () {
        bankController.changeSelectedBank(bank);
      },
      child: Card(
        elevation: 10,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          decoration: BoxDecoration(
            color: bankController.selected_banks.contains(bank) ? MyColors.colorLightSecondary.withOpacity(0.5) : MyColors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          foregroundDecoration: RotatedCornerDecoration.withColor(
            color: bank.Amount?.isNegative==true ? MyColors.colorClear : MyColors.colorPending,
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
                            "PARTY: ${bank.ContraAccountName??""}",
                            style: GoogleFonts.manrope(
                                color: MyColors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w600
                            ),
                          ),
                          Text(
                            "CHEQUE NO.: "+(bank.ChequeNo??""),
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
                          "DOC: #"+(bank.DOCNUMBER??"").trim(),
                          style: GoogleFonts.manrope(
                              color: MyColors.colorGrey,
                              fontSize: 12,
                              fontWeight: FontWeight.w600
                          ),
                        ),
                        Text(
                          (bank.DOCNUMBER.toString().trim()!="0") ? DateFormat("dd MMM, yyyy").format(DateTime.parse(bank.TXNDATE??"")) : "Opening Balance",
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
                          bank.Amount?.isNegative==true ? (bank.Amount??0).abs().toStringAsFixed(2) : "",
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
                          bank.Amount?.isNegative==true ? "" : (bank.Amount??0).abs().toStringAsFixed(2),
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