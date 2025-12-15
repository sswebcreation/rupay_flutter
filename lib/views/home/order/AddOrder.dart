import 'package:bottom_picker/bottom_picker.dart';
import 'package:bottom_picker/resources/arrays.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rupay/colors/MyColors.dart';
import 'package:rupay/controllers/order/AddOrderController.dart';
import 'package:rupay/designer/button/Button.dart';
import 'package:rupay/models/screenCode/ScreenCodeModel.dart';
import 'package:rupay/size/MySize.dart';
import 'package:rupay/size/Spacing.dart';

class AddOrder extends StatelessWidget {
  AddOrder({ Key? key }) : super(key: key);

  final AddOrderController addOrderController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddOrderController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Add Order",
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
              key: addOrderController.formKey,
              child: Container(
                padding: const EdgeInsets.all(20),
                margin: EdgeInsets.only(top: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'Order Date',
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
                        controller: addOrderController.orderDate,
                        onTap: () {
                          BottomPicker.date(
                            initialDateTime: addOrderController.date,
                            maxDateTime: DateTime.now(),
                            pickerTitle: Text(
                              "Select Order Date",
                              style: GoogleFonts.manrope(
                                fontSize: 16.0,
                                color: MyColors.colorSecondary,
                                letterSpacing: 0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            onSubmit: (value) {
                              if (value != null) {
                                addOrderController.setDate(value);
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
                            hintText: "Enter Order Date",
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                            prefixIcon: Icon(
                              Icons.date_range
                            )
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, top: 20),
                      child: Text(
                        'Order Items',
                        style: GoogleFonts.manrope(
                          fontSize: 16.0,
                          color: MyColors.black,
                          letterSpacing: 0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    ListView.separated(
                      itemCount: addOrderController.pcs.length,
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
                        return getAddOrderDesign(index, context);
                      },
                    ),
                    Row(
                      children: [
                        if(addOrderController.pcs.isNotEmpty)
                          Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child:
                          GestureDetector(
                            onTap: () {
                              addOrderController.addOrder();
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
                                      'ADD  ORDER',
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
                        if(addOrderController.pcs.isNotEmpty)
                          SizedBox(
                          width: 20,
                        ),
                        Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child:
                          GestureDetector(
                            onTap: () {
                              addOrderController.addItem();
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

  Widget getAddOrderDesign(int index, BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child:  DropdownSearch<ScreenCodeModel>(
                  popupProps:  const PopupProps.menu(
                      showSearchBox: true,
                      searchFieldProps: TextFieldProps(
                        decoration: InputDecoration(
                          hintText: "Search Screen Names",
                        ),
                      )
                  ),
                  itemAsString: (ScreenCodeModel screenCode) => screenCode.name,
                  items: addOrderController.screen_codes,
                  selectedItem: addOrderController.codes[index],
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
                          hintText: "Enter Screen Name",
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
                    addOrderController.changeScreenCode(value, index);
                  },
                ),
              ),
              Container(
                width: MySize.size25(context),
                padding: EdgeInsets.symmetric(horizontal: 7),
                child: TextFormField(
                  controller: addOrderController.pcs[index],
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
                      hintText: "PCS",
                      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
                  ),
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            addOrderController.removeItem(index);
          },
          child: Icon(
            Icons.remove_circle,
            color: MyColors.colorInactive,
            size: 30,
          ),
        )
      ],
    );
  }
}