import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rupay/colors/MyColors.dart';
import 'package:rupay/controllers/account/AccountController.dart';
import 'package:rupay/models/account/AccountModel.dart';

class Account extends StatelessWidget {
  Account({ Key? key }) : super(key: key);

  final AccountController accountController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              accountController.title,
              style: GoogleFonts.manrope(
                fontSize: 16.0,
                color: MyColors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            centerTitle: false,
            backgroundColor: MyColors.colorPrimary,
            iconTheme: IconThemeData(
              color: MyColors.white
            ),
            elevation: 0,
            actions: [
              GestureDetector(
                onTap: () {
                  print(accountController.selected);
                  Get.back(result: accountController.selected);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  alignment: Alignment.center,
                  child: Text(
                    "DONE",
                    style: GoogleFonts.manrope(
                      color: MyColors.white,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                ),
              )
            ],
          ),
          backgroundColor: MyColors.white,
          body: accountController.load ?
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: TextFormField(
                    onChanged: (value) {
                      accountController.searchAccount();
                    },
                    controller: accountController.search,
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
                        hintText: "Search ${accountController.title.substring(0, accountController.title.length-1)}",
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        prefixIcon: Icon(
                          Icons.search
                        )
                    ),
                  ),
                ),
                ListView.separated(
                  itemCount: accountController.show.length,
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
                    return getAccountDesign(accountController.show[index]);
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

  Widget getAccountDesign(AccountModel account) {
    return GestureDetector(
      onTap: () {

        accountController.manageAccount(!accountController.selected.contains(account), account);
        // accountController.goto("/product", arguments: Account);
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
              Checkbox(
                value: accountController.selected.contains(account),
                onChanged: (bool? value) {
                  accountController.manageAccount(value, account);
                },
              ),
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      account.NAME,
                      textAlign: TextAlign.start,
                      style: GoogleFonts.manrope(
                        fontSize: 12.0,
                        color: MyColors.black,
                        letterSpacing: 0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      account.ADD1+account.ADD2+", "+account.CITY+" - "+account.PINCODE,
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
              )
              // Column(
              //   children: [
              //     Text(
              //       account.NAME + account.NAME,
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