import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rupay/colors/MyColors.dart';
import 'package:rupay/controllers/bottomSheets/SelectOptionController.dart';
class SelectOption extends StatelessWidget {
  SelectOption(List<String> dateFilter, String? selectedDF, { Key? key }) {
    selectOptionController.dateFilter = dateFilter;
    selectOptionController.selectedDF = selectedDF;
  }

  final SelectOptionController selectOptionController = Get.put<SelectOptionController>(SelectOptionController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SelectOptionController>(
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
                    mainAxisAlignment: MainAxisAlignment.start,
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
                      // GestureDetector(
                      //   onTap: () {
                      //     selectOptionController.select();
                      //   },
                      //   child: Text(
                      //     "DONE",
                      //     textAlign: TextAlign.start,
                      //     style: GoogleFonts.manrope(
                      //       fontSize: 12.0,
                      //       color: MyColors.colorSecondary,
                      //       letterSpacing: 0,
                      //       fontWeight: FontWeight.w600,
                      //     ),
                      //   ),
                      // )
                    ],
                  ),
                ),
                Flexible(
                  child: ListView.separated(
                    itemCount: selectOptionController.dateFilter.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(horizontal: 10, ),
                    separatorBuilder: (BuildContext buildContext, int index) {
                      return SizedBox(
                        height: 3,
                      );
                    },
                    itemBuilder: (BuildContext buildContext, int index) {
                      return getOptionDesign(selectOptionController.dateFilter[index]);
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
          groupValue: selectOptionController.selectedDF,
          value: option,
          onChanged: (String? value) {
            selectOptionController.manageSelectOption(value!);
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