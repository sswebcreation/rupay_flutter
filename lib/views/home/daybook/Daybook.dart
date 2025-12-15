import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rupay/colors/MyColors.dart';
import 'package:rupay/controllers/daybook/DaybookController.dart';
import 'package:rupay/models/daybook/DaybookModel.dart';

class Daybook extends StatelessWidget {
  Daybook({ Key? key }) : super(key: key);

  final DaybookController daybookController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DaybookController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Daybooks",
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
                  print(daybookController.selected);
                  Get.back(result: daybookController.selected);
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
          body: daybookController.load ?
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: TextFormField(
                    onChanged: (value) {
                      daybookController.searchDaybook();
                    },
                    controller: daybookController.search,
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
                        hintText: "Search Daybook",
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        prefixIcon: Icon(
                          Icons.search
                        )
                    ),
                  ),
                ),
                ListView.separated(
                  itemCount: daybookController.show.length,
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
                    return getDaybookDesign(daybookController.show[index]);
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

  Widget getDaybookDesign(DaybookModel daybook) {
    return GestureDetector(
      onTap: () {
        daybookController.manageDaybook(!daybookController.selected.contains(daybook), daybook);
        // daybookController.goto("/product", arguments: Daybook);
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
                value: daybookController.selected.contains(daybook),
                onChanged: (bool? value) {
                  daybookController.manageDaybook(value, daybook);
                },
              ),
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      daybook.DAYBOOK,
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
              //       daybook.NAME + daybook.NAME,
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