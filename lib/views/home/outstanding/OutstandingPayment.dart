import 'package:bottom_picker/bottom_picker.dart';
import 'package:bottom_picker/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:rotated_corner_decoration/rotated_corner_decoration.dart';
import 'package:rupay/colors/MyColors.dart';
import 'package:rupay/constants/CommonConstants.dart';
import 'package:rupay/controllers/outstanding/OutstandingPaymentController.dart';
import 'package:rupay/designer/button/Button.dart';
import 'package:rupay/models/outstanding/OutstandingModel.dart';
import 'package:rupay/services/networking/ApiConstants.dart';
import 'package:rupay/shared/widgets/CommonWidgets.dart';

class OutstandingPayment extends StatelessWidget {
  OutstandingPayment({ Key? key }) : super(key: key);

  final OutstandingPaymentController outstandingPaymentController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OutstandingPaymentController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "${outstandingPaymentController.type} Outstanding Payment",
              style: GoogleFonts.manrope(
                fontSize: 16.0,
                color: MyColors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            centerTitle: true,
            backgroundColor: MyColors.colorPrimary,
            iconTheme: IconThemeData(
              color: MyColors.white
            ),
            elevation: 0,
            actions: [
              GestureDetector(
                onTap: () {
                  outstandingPaymentController.goto("/multiOSPDF", arguments: {"outstandings" : outstandingPaymentController.outstandings, "sd" : outstandingPaymentController.sd, "ed" : outstandingPaymentController.ed});
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
          body: NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
                  print("hello");
                  outstandingPaymentController.getShowUpdate(outstandingPaymentController.show.length);
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
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              outstandingPaymentController.getOutstandings();
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
                          if(outstandingPaymentController.outstandings.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: TextFormField(
                                onChanged: (value) {
                                  outstandingPaymentController.searchOutstanding();
                                },
                                controller: outstandingPaymentController.search,
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
                                    hintText: "Search Oustandings",
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                                    prefixIcon: Icon(
                                        Icons.search
                                    )
                                ),
                              ),
                            ),
                          getOutstandings()
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

  Widget getTotalDesign() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          getTotalCard("Total Amount", CommonConstants.rupee+outstandingPaymentController.amount.toStringAsFixed(2)),
          SizedBox(
            width: 20,
          ),
          getTotalCard("Total Outstanding", CommonConstants.rupee+outstandingPaymentController.os.toStringAsFixed(2)),
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
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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

  Widget getOutstandings() {
    return outstandingPaymentController.load ?
    outstandingPaymentController.loaded==false || outstandingPaymentController.show.isNotEmpty ? ListView.separated(
      itemCount: outstandingPaymentController.show.length,
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
        return getOutstandingDesign(index, outstandingPaymentController.show[index]);
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
      padding: EdgeInsets.only(top: 40),
      alignment: Alignment.center,
      child: CircularProgressIndicator(
        color: MyColors.colorPrimary,
      ),
    );
  }

  Widget getOutstandingDesign(int index, OutstandingModel outstanding) {
    return GestureDetector(
      onTap: () {
        // outstandingPaymentController.goto("/singleoutstandingPDF", arguments: outstanding.ID);
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
            color: outstanding.NetAmount==outstanding.NetOSAmount ? MyColors.colorPending : outstanding.NetOSAmount!>0 ? MyColors.colorPartial : MyColors.colorClear,
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
                            "Txn Days: "+(outstanding.TxnDays??"").toString(),
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
                          "V NO.: #"+(outstanding.DocNumber??"").trim(),
                          style: GoogleFonts.manrope(
                              color: MyColors.colorGrey,
                              fontSize: 12,
                              fontWeight: FontWeight.w600
                          ),
                        ),
                        Text(
                          DateFormat("dd MMM, yyyy").format(DateTime.parse(outstanding.TxnDate??"")),
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
                          "Net Amount",
                          style: GoogleFonts.manrope(
                              color: MyColors.colorGrey,
                              fontSize: 12,
                              fontWeight: FontWeight.w600
                          ),
                        ),
                        Text(
                          (outstanding.NetAmount??0).toStringAsFixed(2),
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
                          "Ret. Amount",
                          style: GoogleFonts.manrope(
                              color: MyColors.colorGrey,
                              fontSize: 12,
                              fontWeight: FontWeight.w600
                          ),
                        ),
                        Text(
                          (outstanding.AdjustedAmount??0).toStringAsFixed(2),
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
                          "OS. Amount",
                          style: GoogleFonts.manrope(
                              color: MyColors.colorGrey,
                              fontSize: 12,
                              fontWeight: FontWeight.w600
                          ),
                        ),
                        Text(
                          (outstanding.NetOSAmount??0).toStringAsFixed(2),
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

  Widget getDates(BuildContext context) {
    return SizedBox(
      height: 45,
      child: Row(
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              outstandingPaymentController.chooseDateFilter(context);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Row(
                children: [
                  Text(
                    outstandingPaymentController.selectedDF,
                    style: GoogleFonts.manrope(
                      fontSize: 14.0,
                      color: MyColors.colorSecondary,
                      letterSpacing: 0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    width: 5,
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
                      if(outstandingPaymentController.selectedDF=="Custom") {
                        BottomPicker.date(
                          initialDateTime: outstandingPaymentController.sd,
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
                              outstandingPaymentController.setDate(value, "sd");
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
                          Icon(
                            Icons.calendar_month,
                            size: 18,
                          ),
                          Text(
                            outstandingPaymentController.getDateText(outstandingPaymentController.sd),
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
                      if(outstandingPaymentController.selectedDF=="Custom") {
                        BottomPicker.date(
                          initialDateTime: outstandingPaymentController.ed,
                          minDateTime: outstandingPaymentController.sd,
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
                              outstandingPaymentController.setDate(value, "ed");
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
                          Icon(
                            Icons.calendar_month,
                            size: 18,
                          ),
                          Text(
                            outstandingPaymentController.getDateText(outstandingPaymentController.ed),
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
      children: List<Widget>.generate(outstandingPaymentController.filters.length, (int index) {
        return ChoiceChip(
          label: Text(outstandingPaymentController.filters[index]),
          labelStyle: GoogleFonts.manrope(
            color: MyColors.colorPrimary,
            fontSize: 14,
            fontWeight: FontWeight.w600
          ),
          padding: EdgeInsets.symmetric(horizontal: 5),
          backgroundColor: MyColors.colorPrimary.withOpacity(0.3),
          selected: false,
          onSelected: (bool selected) {
            print(outstandingPaymentController.getList(index));
            outstandingPaymentController.goto("/account",
                arguments: {"title" : outstandingPaymentController.filters[index],
                  "list" : outstandingPaymentController.getList(index),
                  "type" : outstandingPaymentController.type.toLowerCase()=="sales" ? ApiConstants.salesType : ApiConstants.purchaseType,
                  "title" : outstandingPaymentController.type.toLowerCase()=="sales" ? 'Customers' : 'Vendors'
            }
            );
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
      children: List<Widget>.generate(outstandingPaymentController.customers.length, (int index) {
        return ChoiceChip(
          label: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(outstandingPaymentController.customers[index].NAME),
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
            fontSize: 10,
            fontWeight: FontWeight.w700
          ),
          padding: EdgeInsets.symmetric(horizontal: 1),
          backgroundColor: MyColors.colorSecondary.withOpacity(0.3),
          selected: false,
          onSelected: (bool selected) {
            outstandingPaymentController.removeCustomer(outstandingPaymentController.customers[index]);
          },
        );
      }),
    );
  }

  Widget getOutstandingPaymentDesign(int index, OutstandingModel outstanding) {
    return GestureDetector(
                    behavior: HitTestBehavior.opaque,
      onTap: () {
        // outstandingPaymentController.goto("/subOutstandingPayment", arguments: outstanding);
      },
      child: Container(
        padding: EdgeInsets.only(top: 30, left: 10, right: 10),
        decoration: BoxDecoration(
          color: MyColors.white
        ),
        alignment: Alignment.center,
      ),
    );
  }

}