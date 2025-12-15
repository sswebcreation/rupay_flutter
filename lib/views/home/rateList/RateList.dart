import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rupay/colors/MyColors.dart';
import 'package:rupay/controllers/rateList/RateListController.dart';

class RateList extends StatelessWidget {
  RateList({ Key? key }) : super(key: key);

  final RateListController rateListController =  Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RateListController>(
      builder: (controller) {
        return Scaffold(
            appBar: AppBar(
              title: Text(
                "Rate List",
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
              actions: [
                GestureDetector(
                  onTap: () {
                    rateListController.shareFile();
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Icon(
                      Icons.share
                    ),
                  ),
                )
              ],
            ),
            backgroundColor: MyColors.white,
            body: rateListController.load ?
            PDFView(
              filePath: rateListController.file!.path,
              enableSwipe: true,
              swipeHorizontal: false,
              autoSpacing: false,
              pageFling: false,
              pageSnap: false,
              defaultPage: rateListController.currentPage!,
              fitPolicy: FitPolicy.BOTH,
              preventLinkNavigation:
              false, // if set to true the link is handled in flutter
              onRender: (_pages) {
                // setState(() {
                  rateListController.pages = _pages;
                  rateListController.isReady = true;
                  rateListController.update();
                // });
              },
              onError: (error) {
                // setState(() {
                //   errorMessage = error.toString();
                // });
                print(error.toString());
              },
              onPageError: (page, error) {
                // setState(() {
                //   errorMessage = '$page: ${error.toString()}';
                // });
                print('$page: ${error.toString()}');
              },
              onViewCreated: (PDFViewController pdfViewController) {
                rateListController.controller.complete(pdfViewController);
              },
              onLinkHandler: (String? uri) {
                print('goto uri: $uri');
              },
              onPageChanged: (int? page, int? total) {
                print('page change: $page/$total');
                // setState(() {
                rateListController.currentPage = page;
                rateListController.update();
                // });
              },
            )
            : Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                color: MyColors.colorPrimary,
              ),
            )
        );
      },
    );
  }
}
