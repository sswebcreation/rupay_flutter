import 'package:bottom_picker/bottom_picker.dart';
import 'package:bottom_picker/resources/arrays.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rupay/colors/MyColors.dart';
import 'package:rupay/controllers/purchase/AddPurchaseController.dart';
import 'package:rupay/designer/button/Button.dart';
import 'package:rupay/models/account/AccountModel.dart';
import 'package:rupay/models/daybook/DaybookModel.dart';
import 'package:rupay/models/item/ItemModel.dart';
import 'package:rupay/size/Spacing.dart';

class AddPurchase extends StatelessWidget {
  AddPurchase({ Key? key }) : super(key: key);

  final AddPurchaseController addPurchaseController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddPurchaseController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Add Purchase",
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
              key: addPurchaseController.formKey,
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
                            items: addPurchaseController.daybooks,
                            selectedItem: addPurchaseController.daybook,
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
                              addPurchaseController.changeDaybook(value);
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
                            'Party Bill No.',
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
                            controller: addPurchaseController.billNo,
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
                                hintText: "Enter Bill No.",
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
                            controller: addPurchaseController.billDate,
                            onTap: () {
                              BottomPicker.date(
                                initialDateTime: addPurchaseController.bdate,
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
                                    addPurchaseController.setDate(value);
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
                            items: addPurchaseController.accounts,
                            selectedItem: addPurchaseController.account,
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
                              addPurchaseController.changeAccount(value);
                            },
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, top: 20),
                      child: Text(
                        'Purchase Items',
                        style: GoogleFonts.manrope(
                          fontSize: 16.0,
                          color: MyColors.black,
                          letterSpacing: 0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    ListView.separated(
                      itemCount: addPurchaseController.pcs.length,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(vertical: 10),
                      separatorBuilder: (BuildContext buildContext, int index) {
                        return SizedBox(
                          height: 15,
                        );
                      },
                      itemBuilder: (BuildContext buildContext, int index) {
                        return getAddPurchaseDesign(index, context);
                      },
                    ),
                    Row(
                      children: [
                        if(addPurchaseController.pcs.isNotEmpty)
                          Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child:
                          GestureDetector(
                            onTap: () {
                              addPurchaseController.addPurchase();
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
                                      'ADD  Purchase',
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
                        if(addPurchaseController.pcs.isNotEmpty)
                          SizedBox(
                          width: 20,
                        ),
                        Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child:
                          GestureDetector(
                            onTap: () {
                              addPurchaseController.addItem();
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
                                      'ADD  ITEM',
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
                        )
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

  Widget getAddPurchaseDesign(int index, BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          color: MyColors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: ExpansionTile(
          title: Text(
            "Item ${index+1}"
          ),
          maintainState: true,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  addPurchaseController.removeItem(index);
                },
                child: Icon(
                  Icons.remove_circle,
                  color: MyColors.colorInactive,
                  size: 30,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    'Item Name',
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
                  child: DropdownSearch<ItemModel>(
                    popupProps:  const PopupProps.menu(
                        showSearchBox: true,
                        searchFieldProps: TextFieldProps(
                          decoration: InputDecoration(
                            hintText: "Search Item",
                          ),
                        )
                    ),
                    itemAsString: (ItemModel item) => item.NAME,
                    items: addPurchaseController.items,
                    selectedItem: addPurchaseController.item[index],
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
                          hintText: "Enter Item",
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
                      addPurchaseController.changeItem(value, index);
                    },
                  ),
                )
              ],
            ),
            if((addPurchaseController.company.Q1??"").isNotEmpty)
              Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    addPurchaseController.company.Q1??"",
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
                    onChanged: (value) {
                      addPurchaseController.calculate(index);
                    },
                    controller: addPurchaseController.pcs[index],
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly
                    ],
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
                        if(addPurchaseController.cut[index].text.isEmpty && addPurchaseController.mts[index].text.isEmpty) {
                          return "* Required";
                        }
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: MyColors.colorButton,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      hintText: addPurchaseController.company.Q1??"",
                      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
                    ),
                  ),
                )
              ],
            ),
            if((addPurchaseController.company.Q2??"").isNotEmpty)
              Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    addPurchaseController.company.Q2??"",
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
                    onChanged: (value) {
                      addPurchaseController.calculate(index);
                    },
                    controller: addPurchaseController.cut[index],
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
                        if(addPurchaseController.pcs[index].text.isEmpty && addPurchaseController.mts[index].text.isEmpty) {
                          return "* Required";
                        }
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: MyColors.colorButton,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      hintText: addPurchaseController.company.Q2??"",
                      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
                    ),
                  ),
                )
              ],
            ),
            if((addPurchaseController.company.Q3??"").isNotEmpty)
              Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    addPurchaseController.company.Q3??"",
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
                    onChanged: (value) {
                      addPurchaseController.calculate(index);
                    },
                    controller: addPurchaseController.mts[index],
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
                        if(addPurchaseController.pcs[index].text.isEmpty && addPurchaseController.cut[index].text.isEmpty) {
                          return "* Required";
                        }
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: MyColors.colorButton,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      hintText: addPurchaseController.company.Q3??"",
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
                    'Rate',
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
                    onChanged: (value) {
                      addPurchaseController.calculate(index);
                    },
                    controller: addPurchaseController.rate[index],
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
                      hintText: "Rate",
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
                    'Gross Amount',
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
                    controller: addPurchaseController.gross[index],
                    enabled: false,
                    readOnly: true,
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
                      hintText: "Gross Amount",
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
                    'GST Amount',
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
                    controller: addPurchaseController.gstAmount[index],
                    enabled: false,
                    readOnly: true,
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
                      hintText: "GST Amount",
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
                    'Net Amount',
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
                    controller: addPurchaseController.amount[index],
                    enabled: false,
                    readOnly: true,
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
                      hintText: "Net Amount",
                      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}