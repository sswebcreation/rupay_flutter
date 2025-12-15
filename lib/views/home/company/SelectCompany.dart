import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rupay/colors/MyColors.dart';
import 'package:rupay/controllers/company/SelectCompanyController.dart';
import 'package:rupay/models/company/CompanyModel.dart';

class SelectCompany extends StatelessWidget {
  SelectCompany({ Key? key }) : super(key: key);

  final SelectCompanyController selectCompanyController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SelectCompanyController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              selectCompanyController.title,
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
                  print(selectCompanyController.selected);
                  Get.back(result: selectCompanyController.selected);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
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
          body: selectCompanyController.load ?
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: TextFormField(
                    onChanged: (value) {
                      selectCompanyController.searchCompany();
                    },
                    controller: selectCompanyController.search,
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
                        hintText: "Search ${selectCompanyController.title.substring(0, selectCompanyController.title.length-1)}",
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        prefixIcon: const Icon(
                          Icons.search
                        )
                    ),
                  ),
                ),
                ListView.separated(
                  itemCount: selectCompanyController.show.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  separatorBuilder: (BuildContext buildContext, int index) {
                    return const SizedBox(
                      height: 3,
                    );
                  },
                  itemBuilder: (BuildContext buildContext, int index) {
                    return getCompanyDesign(selectCompanyController.show[index]);
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

  Widget getCompanyDesign(CompanyModel company) {
    return GestureDetector(
      onTap: () {
        selectCompanyController.manageCompany(!selectCompanyController.selected.contains(company), company);
        // selectCompanyController.goto("/product", arguments: Company);
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
                value: selectCompanyController.selected.contains(company),
                onChanged: (bool? value) {
                  selectCompanyController.manageCompany(value, company);
                },
              ),
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      company.NAME,
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
                      "FIN. YEAR:  ${company.YEAR}",
                      textAlign: TextAlign.start,
                      style: GoogleFonts.manrope(
                        fontSize: 12.0,
                        color: MyColors.black,
                        letterSpacing: 0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "${company.ADD1??""}${company.ADD2??""}, ${company.CITY??""} - ${company.PINCODE}",
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
              //       company.NAME + company.NAME,
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