import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rupay/colors/MyColors.dart';
import 'package:rupay/controllers/purchase/SinglePurchaseReturnPDFController.dart';

class SinglePurchaseReturnPDF extends StatelessWidget {
  SinglePurchaseReturnPDF({ Key? key }) : super(key: key);

  final SinglePurchaseReturnPDFController singlePurchaseReturnPDFController =  Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SinglePurchaseReturnPDFController>(
      builder: (controller) {
        return Scaffold(
            appBar: AppBar(
              title: GestureDetector(
                onTap: () {
                  singlePurchaseReturnPDFController.processPDF();
                },
                child: Text(
                  "Purchase Return",
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
                    singlePurchaseReturnPDFController.shareFile();
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
            body: singlePurchaseReturnPDFController.load ?
            singlePurchaseReturnPDFController.file!=null ?
              PDFView(
              filePath: singlePurchaseReturnPDFController.file!.path,
              enableSwipe: true,
              swipeHorizontal: false,
              autoSpacing: false,
              pageFling: false,
              pageSnap: false,
              defaultPage: singlePurchaseReturnPDFController.currentPage!,
              fitPolicy: FitPolicy.BOTH,
              preventLinkNavigation:
              false, // if set to true the link is handled in flutter
              onRender: (_pages) {
                // setState(() {
                  singlePurchaseReturnPDFController.pages = _pages;
                  singlePurchaseReturnPDFController.isReady = true;
                  singlePurchaseReturnPDFController.update();
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
                singlePurchaseReturnPDFController.controller.complete(pdfViewController);
              },
              onLinkHandler: (String? uri) {
                print('goto uri: $uri');
              },
              onPageChanged: (int? page, int? total) {
                print('page change: $page/$total');
                // setState(() {
                singlePurchaseReturnPDFController.currentPage = page;
                singlePurchaseReturnPDFController.update();
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
