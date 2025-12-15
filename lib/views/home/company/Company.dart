import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rupay/colors/MyColors.dart';
import 'package:rupay/controllers/company/CompanyController.dart';
import 'package:rupay/models/company/CompanyModel.dart';

class Company extends StatelessWidget {
  Company({ Key? key }) : super(key: key);

  final CompanyController companyController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CompanyController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Select Company",
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
              IconButton(
                icon: Icon(
                  Icons.refresh
                ),
                onPressed: () {
                  companyController.startLoad();
                  companyController.getCompanies();
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.logout
                ),
                onPressed: () {
                  companyController.logout();
                },
              )
            ],
          ),
          backgroundColor: MyColors.white,
          body: companyController.load ?
          ListView.separated(
            itemCount: companyController.companies.length,
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            separatorBuilder: (BuildContext buildContext, int index) {
              return SizedBox(
                height: 3,
              );
            },
            itemBuilder: (BuildContext buildContext, int index) {
              return getCompanyDesign(companyController.companies[index]);
            },
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
        companyController.manageCompany(company);
      },
      child: Card(
        elevation: 10,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 6),
          decoration: BoxDecoration(
            color: companyController.company==company ? null : MyColors.white,
            borderRadius: BorderRadius.circular(10)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      company.NAME,
                      textAlign: TextAlign.start,
                      style: GoogleFonts.manrope(
                        fontSize: 14.0,
                        color: MyColors.black,
                        letterSpacing: 0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "FIN. YEAR:  ${company.YEAR}",
                      textAlign: TextAlign.start,
                      style: GoogleFonts.manrope(
                        fontSize: 14.0,
                        color: MyColors.black,
                        letterSpacing: 0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
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
            ],
          ),
        ),
      ),
    );
  }
}