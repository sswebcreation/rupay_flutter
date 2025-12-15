import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rupay/colors/MyColors.dart';
import 'package:rupay/controllers/ledger/MultiLedgerPDFController.dart';

class MultiLedgerPDF extends StatelessWidget {
  MultiLedgerPDF({ Key? key }) : super(key: key);

  final MultiLedgerPDFController multiLedgerPDFController =  Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MultiLedgerPDFController>(
      builder: (controller) {
        return Scaffold(
            appBar: AppBar(
              title: GestureDetector(
                onTap: () {
                  multiLedgerPDFController.processPDF();
                },
                child: Text(
                  "Ledger",
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
                    multiLedgerPDFController.shareFile();
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
            body: multiLedgerPDFController.load ?
            PDFView(
              filePath: multiLedgerPDFController.file!.path,
              enableSwipe: true,
              swipeHorizontal: false,
              autoSpacing: false,
              pageFling: false,
              pageSnap: false,
              defaultPage: multiLedgerPDFController.currentPage!,
              fitPolicy: FitPolicy.BOTH,
              preventLinkNavigation:
              false, // if set to true the link is handled in flutter
              onRender: (_pages) {
                // setState(() {
                  multiLedgerPDFController.pages = _pages;
                  multiLedgerPDFController.isReady = true;
                  multiLedgerPDFController.update();
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
                multiLedgerPDFController.controller.complete(pdfViewController);
              },
              onLinkHandler: (String? uri) {
                print('goto uri: $uri');
              },
              onPageChanged: (int? page, int? total) {
                print('page change: $page/$total');
                // setState(() {
                multiLedgerPDFController.currentPage = page;
                multiLedgerPDFController.update();
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
