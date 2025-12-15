import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rupay/colors/MyColors.dart';
import 'package:rupay/controllers/bank/MultiBankPDFController.dart';

class MultiBankPDF extends StatelessWidget {
  MultiBankPDF({ Key? key }) : super(key: key);

  final MultiBankPDFController multiBankPDFController =  Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MultiBankPDFController>(
      builder: (controller) {
        return Scaffold(
            appBar: AppBar(
              title: GestureDetector(
                onTap: () {
                  multiBankPDFController.processPDF();
                },
                child: Text(
                  "Bank",
                  style: GoogleFonts.manrope(
                    fontSize: 16.0,
                    color: MyColors.white,
                    fontWeight: FontWeight.w600,
                  ),
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
                    multiBankPDFController.shareFile();
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
            body: multiBankPDFController.load ?
            PDFView(
              filePath: multiBankPDFController.file!.path,
              enableSwipe: true,
              swipeHorizontal: false,
              autoSpacing: false,
              pageFling: false,
              pageSnap: false,
              defaultPage: multiBankPDFController.currentPage!,
              fitPolicy: FitPolicy.BOTH,
              preventLinkNavigation:
              false, // if set to true the link is handled in flutter
              onRender: (_pages) {
                // setState(() {
                  multiBankPDFController.pages = _pages;
                  multiBankPDFController.isReady = true;
                  multiBankPDFController.update();
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
                multiBankPDFController.controller.complete(pdfViewController);
              },
              onLinkHandler: (String? uri) {
                print('goto uri: $uri');
              },
              onPageChanged: (int? page, int? total) {
                print('page change: $page/$total');
                // setState(() {
                multiBankPDFController.currentPage = page;
                multiBankPDFController.update();
                // });
              },
            )
            : Container(
              padding: EdgeInsets.only(top: 20),
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
