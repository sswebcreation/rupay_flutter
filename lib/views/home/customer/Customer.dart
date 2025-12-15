import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rupay/colors/MyColors.dart';
import 'package:rupay/controllers/customer/CustomerController.dart';
import 'package:rupay/models/account/AccountModel.dart';

class Customer extends StatelessWidget {
  Customer({ Key? key }) {
    customerController.onInit();
  }

  final CustomerController customerController = Get.put<CustomerController>(CustomerController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CustomerController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Customer",
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
          ),
          backgroundColor: MyColors.white,
          body: customerController.load ?
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: TextFormField(
                    onChanged: (value) {
                      customerController.searchCustomer();
                    },
                    controller: customerController.search,
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
                        hintText: "Search Customer",
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        prefixIcon: Icon(
                          Icons.search
                        )
                    ),
                  ),
                ),
                ListView.separated(
                  itemCount: customerController.show.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  separatorBuilder: (BuildContext buildContext, int index) {
                    return SizedBox(
                      height: 3,
                    );
                  },
                  itemBuilder: (BuildContext buildContext, int index) {
                    return getCustomerDesign(context, customerController.show[index]);
                  },
                ),
              ],
            ),
          )
          : Center(
            child: CircularProgressIndicator(
              color: MyColors.colorPrimary,
            ),
          ),
        );
      },
    );
  }

  Widget getCustomerDesign(BuildContext context, AccountModel customer) {
    return GestureDetector(
      onTap: () {
        customerController.chooseOption(context, customer);
      },
      child: Card(
        elevation: 10,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      customer.NAME,
                      textAlign: TextAlign.start,
                      style: GoogleFonts.manrope(
                        fontSize: 12.0,
                        color: MyColors.black,
                        letterSpacing: 0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      customer.ADD1+customer.ADD2+", "+customer.CITY+" - "+customer.PINCODE,
                      textAlign: TextAlign.start,
                      style: GoogleFonts.manrope(
                        fontSize: 12.0,
                        color: MyColors.black,
                        letterSpacing: 0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if(customer.MOBILE.isNotEmpty)
                      Column(
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          customer.MOBILE,
                          textAlign: TextAlign.start,
                          style: GoogleFonts.manrope(
                            fontSize: 12.0,
                            color: MyColors.black,
                            letterSpacing: 0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      customer.GSTIN,
                      textAlign: TextAlign.start,
                      style: GoogleFonts.manrope(
                        fontSize: 12.0,
                        color: MyColors.black,
                        letterSpacing: 0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              )
              // Column(
              //   children: [
              //     Text(
              //       customer.NAME + customer.NAME,
              //       textAlign: TextAlign.start,
              //       maxLines: 3,
              //       style: GoogleFonts.manrope(
              //         fontSize: 12.0,
              //         color: MyColors.black,
              //         letterSpacing: 0,
              //         fontWeight: FontWeight.w600,
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}