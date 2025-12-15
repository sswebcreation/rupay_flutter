import 'package:bottom_picker/bottom_picker.dart';
import 'package:bottom_picker/resources/arrays.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rupay/colors/MyColors.dart';
import 'package:rupay/controllers/bank/AddBankController.dart';
import 'package:rupay/designer/button/Button.dart';
import 'package:rupay/models/account/AccountModel.dart';
import 'package:rupay/models/daybook/DaybookModel.dart';
import 'package:rupay/models/item/ItemModel.dart';
import 'package:rupay/size/Spacing.dart';

class AddBank extends StatelessWidget {
  AddBank({ Key? key }) : super(key: key);

  final AddBankController addBankController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddBankController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Add Bank",
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
              key: addBankController.formKey,
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
                            items: addBankController.daybooks,
                            selectedItem: addBankController.daybook,
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
                              addBankController.changeDaybook(value);
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
                            controller: addBankController.billNo,
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
                            controller: addBankController.chequeDate,
                            onTap: () {
                              BottomPicker.date(
                                initialDateTime: addBankController.bdate,
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
                                    addBankController.setDate(value);
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
                            items: addBankController.accounts,
                            selectedItem: addBankController.account,
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
                              addBankController.changeAccount(value);
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
                            'Cheque No.',
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
                            controller: addBankController.chequeNo,
                            maxLength: 16,
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
                              hintText: "Enter Cheque No.",
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
                            'Cheque Date',
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
                            controller: addBankController.chequeDate,
                            readOnly: true,
                            onTap: () {
                              BottomPicker.date(
                                initialDateTime: addBankController.cdate,
                                maxDateTime: DateTime.now(),
                                pickerTitle: Text(
                                  "Select Cheque Date",
                                  style: GoogleFonts.manrope(
                                    fontSize: 16.0,
                                    color: MyColors.colorSecondary,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                onSubmit: (value) {
                                  if (value != null) {
                                    addBankController.setCDate(value);
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
                                hintText: "Enter Cheque Date",
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
                            controller: addBankController.amount,
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
                            controller: addBankController.notes,
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
                              addBankController.addBank();
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
                                      'ADD  Bank',
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