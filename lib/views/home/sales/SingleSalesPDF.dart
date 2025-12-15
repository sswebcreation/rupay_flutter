import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rupay/colors/MyColors.dart';
import 'package:rupay/controllers/sales/SingleSalesPDFController.dart';

class SingleSalesPDF extends StatelessWidget {
  SingleSalesPDF({ Key? key }) : super(key: key);

  final SingleSalesPDFController singleSalesPDFController =  Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SingleSalesPDFController>(
      builder: (controller) {
        return Scaffold(
            appBar: AppBar(
              title: GestureDetector(
                onTap: () {
                  singleSalesPDFController.processPDF();
                },
                child: Text(
                  "Sales",
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
                    singleSalesPDFController.shareFile();
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
            body: singleSalesPDFController.load ?
            singleSalesPDFController.file!=null ?
              PDFView(
              filePath: singleSalesPDFController.file!.path,
              enableSwipe: true,
              swipeHorizontal: false,
              autoSpacing: false,
              pageFling: false,
              pageSnap: false,
              defaultPage: singleSalesPDFController.currentPage!,
              fitPolicy: FitPolicy.BOTH,
              preventLinkNavigation:
              false, // if set to true the link is handled in flutter
              onRender: (_pages) {
                // setState(() {
                  singleSalesPDFController.pages = _pages;
                  singleSalesPDFController.isReady = true;
                  singleSalesPDFController.update();
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
                singleSalesPDFController.controller.complete(pdfViewController);
              },
              onLinkHandler: (String? uri) {
                print('goto uri: $uri');
              },
              onPageChanged: (int? page, int? total) {
                print('page change: $page/$total');
                // setState(() {
                singleSalesPDFController.currentPage = page;
                singleSalesPDFController.update();
                // });
              },
            )
            : Container(
              child: Text(
                "Request Permission"
              ),
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
