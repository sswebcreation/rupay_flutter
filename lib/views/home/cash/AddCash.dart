import 'package:bottom_picker/bottom_picker.dart';
import 'package:bottom_picker/resources/arrays.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rupay/colors/MyColors.dart';
import 'package:rupay/controllers/cash/AddCashController.dart';
import 'package:rupay/designer/button/Button.dart';
import 'package:rupay/models/account/AccountModel.dart';
import 'package:rupay/models/daybook/DaybookModel.dart';
import 'package:rupay/models/item/ItemModel.dart';
import 'package:rupay/size/Spacing.dart';

class AddCash extends StatelessWidget {
  AddCash({ Key? key }) : super(key: key);

  final AddCashController addCashController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddCashController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Add Cash",
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
          ),
          backgroundColor: MyColors.white,
          body: SingleChildScrollView(
            child: Form(
              key: addCashController.formKey,
              child: Container(
                padding: const EdgeInsets.all(20),
                margin: EdgeInsets.only(top: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            'Daybook',
                            style: GoogleFonts.manrope(
                              fontSize: 16.0,
                              color: MyColors.black,
                              letterSpacing: 0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: DropdownSearch<DaybookModel>(
                            popupProps:  const PopupProps.menu(
                                showSearchBox: true,
                                searchFieldProps: TextFieldProps(
                                  decoration: InputDecoration(
                                    hintText: "Search Daybook",
                                  ),
                                )
                            ),
                            itemAsString: (DaybookModel daybook) => daybook.DAYBOOK,
                            items: addCashController.daybooks,
                            selectedItem: addCashController.daybook,
                            dropdownDecoratorProps:  DropDownDecoratorProps(
                                baseStyle: GoogleFonts.manrope(
                                  fontSize: 16.0,
                                  color: MyColors.black,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w400,
                                ),
                                dropdownSearchDecoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: MyColors.colorButton,
                                    ),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  hintText: "Enter Daybook",
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
                                )
                            ),
                            validator: (value) {
                              if (value==null) {
                                return "* Required";
                              }  else {
                                return null;
                              }
                            },
                            onChanged: (value) {
                              addCashController.changeDaybook(value);
                            },
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            'Voucher No.',
                            style: GoogleFonts.manrope(
                              fontSize: 16.0,
                              color: MyColors.black,
                              letterSpacing: 0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: TextFormField(
                            controller: addCashController.billNo,
                            maxLength: 16,
                            style: GoogleFonts.manrope(
                              fontSize: 16.0,
                              color: MyColors.black,
                              letterSpacing: 0,
                              fontWeight: FontWeight.w400,
                            ),
                            validator: (value) {
                              if(value!.isNotEmpty) {
                                return null;
                              }
                              else {
                                return "* Required";
                              }
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: MyColors.colorButton,
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                hintText: "Enter Voucher No.",
                                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            'Bill Date',
                            style: GoogleFonts.manrope(
                              fontSize: 16.0,
                              color: MyColors.black,
                              letterSpacing: 0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: TextFormField(
                            controller: addCashController.billDate,
                            onTap: () {
                              BottomPicker.date(
                                initialDateTime: addCashController.bdate,
                                maxDateTime: DateTime.now(),
                                pickerTitle: Text(
                                  "Select Bill Date",
                                  style: GoogleFonts.manrope(
                                    fontSize: 16.0,
                                    color: MyColors.colorSecondary,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                onSubmit: (value) {
                                  if (value != null) {
                                    addCashController.setDate(value);
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
                            },
                            style: GoogleFonts.manrope(
                              fontSize: 16.0,
                              color: MyColors.black,
                              letterSpacing: 0,
                              fontWeight: FontWeight.w400,
                            ),
                            validator: (value) {
                              if(value!.isNotEmpty) {
                                return null;
                              }
                              else {
                                return "* Required";
                              }
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: MyColors.colorButton,
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                hintText: "Enter Bill Date",
                                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                                prefixIcon: Icon(
                                    Icons.date_range
                                )
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            'Party',
                            style: GoogleFonts.manrope(
                              fontSize: 16.0,
                              color: MyColors.black,
                              letterSpacing: 0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: DropdownSearch<AccountModel>(
                            popupProps:  const PopupProps.menu(
                                showSearchBox: true,
                                searchFieldProps: TextFieldProps(
                                  decoration: InputDecoration(
                                    hintText: "Search Party",
                                  ),
                                )
                            ),
                            itemAsString: (AccountModel account) => account.NAME,
                            items: addCashController.accounts,
                            selectedItem: addCashController.account,
                            dropdownDecoratorProps:  DropDownDecoratorProps(
                                baseStyle: GoogleFonts.manrope(
                                  fontSize: 16.0,
                                  color: MyColors.black,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w400,
                                ),
                                dropdownSearchDecoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: MyColors.colorButton,
                                    ),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  hintText: "Enter Party",
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
                                )
                            ),
                            validator: (value) {
                              if (value==null) {
                                return "* Required";
                              }  else {
                                return null;
                              }
                            },
                            onChanged: (value) {
                              addCashController.changeAccount(value);
                            },
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            'Amount',
                            style: GoogleFonts.manrope(
                              fontSize: 16.0,
                              color: MyColors.black,
                              letterSpacing: 0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: TextFormField(
                            controller: addCashController.amount,
                            keyboardType: TextInputType.number,
                            style: GoogleFonts.manrope(
                              fontSize: 16.0,
                              color: MyColors.black,
                              letterSpacing: 0,
                              fontWeight: FontWeight.w400,
                            ),
                            validator: (value) {
                              if(value!.isNotEmpty) {
                                if(value=="0") {
                                  return "* Invalid Value";
                                }
                                else {
                                  return null;
                                }
                              }
                              else {
                                return "* Required";
                              }
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: MyColors.colorButton,
                                ),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              hintText: "Amount",
                              contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
                            ),
                          ),
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            'Notes',
                            style: GoogleFonts.manrope(
                              fontSize: 16.0,
                              color: MyColors.black,
                              letterSpacing: 0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: TextFormField(
                            controller: addCashController.notes,
                            keyboardType: TextInputType.text,
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
                              hintText: "Notes",
                              contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child:
                          GestureDetector(
                            onTap: () {
                              addCashController.addCash();
                            },
                            child: standardButton(
                              context: context,
                              backgroundColor: MyColors.colorPrimary,
                              borderColor: MyColors.colorPrimary,
                              margin: const EdgeInsets.only(top: 30),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(right: standardHTIS),
                                    child: Text(
                                      'ADD  Cash',
                                      style: GoogleFonts.manrope(
                                        fontSize: 16.0,
                                        color: MyColors.white,
                                        letterSpacing: 0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        );
      },
    );
  }
}