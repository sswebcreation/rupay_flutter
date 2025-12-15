import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rupay/colors/MyColors.dart';
import 'package:rupay/controllers/sales/MultiLISalesPDFController.dart';

class MultiLISalesPDF extends StatelessWidget {
  MultiLISalesPDF({ Key? key }) : super(key: key);

  final MultiLISalesPDFController multiLISalesPDFController =  Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MultiLISalesPDFController>(
      builder: (controller) {
        return Scaffold(
            appBar: AppBar(
              title: GestureDetector(
                onTap: () {
                  multiLISalesPDFController.processPDF();
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
                    multiLISalesPDFController.shareFile();
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
            body: multiLISalesPDFController.load ?
            PDFView(
              filePath: multiLISalesPDFController.file!.path,
              enableSwipe: true,
              swipeHorizontal: false,
              autoSpacing: false,
              pageFling: false,
              pageSnap: false,
              defaultPage: multiLISalesPDFController.currentPage!,
              fitPolicy: FitPolicy.BOTH,
              preventLinkNavigation:
              false, // if set to true the link is handled in flutter
              onRender: (_pages) {
                // setState(() {
                  multiLISalesPDFController.pages = _pages;
                  multiLISalesPDFController.isReady = true;
                  multiLISalesPDFController.update();
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
                multiLISalesPDFController.controller.complete(pdfViewController);
              },
              onLinkHandler: (String? uri) {
                print('goto uri: $uri');
              },
              onPageChanged: (int? page, int? total) {
                print('page change: $page/$total');
                // setState(() {
                multiLISalesPDFController.currentPage = page;
                multiLISalesPDFController.update();
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
