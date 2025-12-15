import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rupay/colors/MyColors.dart';
import 'package:rupay/controllers/bottomSheets/SelectOptionDoneController.dart';
class SelectOptionDone extends StatelessWidget {
  SelectOptionDone(List<String> dateFilter, String? selectedDF, { Key? key }) {
    selectOptionDoneController.dateFilter = dateFilter;
    selectOptionDoneController.selectedDF = selectedDF;
  }

  final SelectOptionDoneController selectOptionDoneController = Get.put<SelectOptionDoneController>(SelectOptionDoneController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SelectOptionDoneController>(
      builder: (controller) {
        return Container(
            height: 350,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
              color: MyColors.white
            ),
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0,),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "SELECT",
                        textAlign: TextAlign.start,
                        style: GoogleFonts.manrope(
                          fontSize: 16.0,
                          color: MyColors.black,
                          letterSpacing: 0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          selectOptionDoneController.select();
                        },
                        child: Text(
                          "DONE",
                          textAlign: TextAlign.start,
                          style: GoogleFonts.manrope(
                            fontSize: 12.0,
                            color: MyColors.colorSecondary,
                            letterSpacing: 0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Flexible(
                  child: ListView.separated(
                    itemCount: selectOptionDoneController.dateFilter.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(horizontal: 10, ),
                    separatorBuilder: (BuildContext buildContext, int index) {
                      return SizedBox(
                        height: 3,
                      );
                    },
                    itemBuilder: (BuildContext buildContext, int index) {
                      return getOptionDesign(selectOptionDoneController.dateFilter[index]);
                    },
                  ),
                ),
              ],
            ),
        );
      },
    );
  }

  Widget getOptionDesign(String option) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Radio(
          groupValue: selectOptionDoneController.selectedDF,
          value: option,
          onChanged: (String? value) {
            selectOptionDoneController.manageSelectOptionDone(value!);
          },
        ),
        Flexible(
          child: Column(
            children: [
              Text(
                option,
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
    );
  }
}