import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rupay/constants/CommonConstants.dart';
import 'package:rupay/essential/Essential.dart';
import 'package:rupay/models/company/CompanyModel.dart';
import 'package:rupay/models/outstanding/OutstandingModel.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:path_provider/path_provider.dart';


class MultiOSPDFController1 extends GetxController {
  MultiOSPDFController1();

  final storage = GetStorage();


  late List<OutstandingModel> outstandings;
  late int id;
  late bool load;
  File? file;
  final Completer<PDFViewController> controller =
  Completer<PDFViewController>();
  int? pages = 0;
  int? currentPage = 0;
  bool isReady = false;
  String errorMessage = '';

  late CompanyModel company;

  late ByteData fontData;
  late Font light, regular, medium, semiBold, bold;
  late DateTime sd, ed;

  int size = 20;

  @override
  void onInit() {
    super.onInit();
    outstandings = [];
    outstandings.addAll(Get.arguments['outstandings']);
    outstandings.addAll(Get.arguments['outstandings']);
    sd = Get.arguments['sd'];
    ed = Get.arguments['ed'];
    // id = Get.arguments;
    load = false;
    company = storage.read("company");
    // items = [];
    start();
  }

  Future<void> start() async {
    fontData = await rootBundle.load('assets/fonts/OpenSans-Light.ttf');
    light = Font.ttf(fontData.buffer.asByteData());
    fontData = await rootBundle.load('assets/fonts/OpenSans-Regular.ttf');
    regular = Font.ttf(fontData.buffer.asByteData());
    fontData = await rootBundle.load('assets/fonts/OpenSans-Medium.ttf');
    medium = Font.ttf(fontData.buffer.asByteData());
    fontData = await rootBundle.load('assets/fonts/OpenSans-SemiBold.ttf');
    semiBold = Font.ttf(fontData.buffer.asByteData());
    fontData = await rootBundle.load('assets/fonts/OpenSans-Bold.ttf');
    bold = Font.ttf(fontData.buffer.asByteData());
    update();
    processPDF();
  }

  processPDF() async {
    print(outstandings.length);
    if (await Essential.requestPermission().isGranted) {
      load = false;
      update();
      final Uint8List pdfBytes = await generatePDFF();
      final directory = await getTemporaryDirectory();
      // final directory = await getTemporaryDirectory();

      // Create a new temporary file with a unique name
      // print('${directory?.path}/hello.pdf');
      // print(DateFormat("dd MMM, yyyy").format(sd));
      // print(DateFormat("dd MMM, yyyy").format(ed));
      String name = "US-OS-"+DateFormat("dd MMM, yyyy").format(sd)+" - "+DateFormat("dd MMM, yyyy").format(ed);
      file = File('${directory?.path}/${name}.pdf');

      await file!.writeAsBytes(pdfBytes);
    }
    load = true;

    update();
  }

  double os = 0;
  double rec = 0;
  double orec = 0;
  double net = 0;

  double gos = 0;
  double grec = 0;
  double gorec = 0;
  double gnet = 0;

  Future<Uint8List> generatePDFF() async {
    os = 0;
    rec = 0;
    orec = 0;
    net = 0;
    gos = 0;
    grec = 0;
    gorec = 0;
    gnet = 0;
    update();

    final Document doc = Document(pageMode: PdfPageMode.fullscreen);


    int len = (outstandings.length/size).ceil();
    int pages = 1;
    int max = 1;
    int i = 0;
    bool change = true;

    while(i<2) {
      int start = i*size;
      if(change) {
        doc.addPage(
          MultiPage(
            pageFormat: PdfPageFormat.letter,
            maxPages: max,
            // orientation: PageOrientation.landscape,
            margin: EdgeInsets.all(20),
            header: (context) {
              return getHeader(context.pageNumber);
            },
            footer: (context) {
              max+=1;
              return Container();
            },
            build: (Context context) {
              return change ? getOutstandingss(
                  start, i != len - 1 ? size : outstandings.length - start) : [];
              // return [
              //   Container(
              //       padding: EdgeInsets.symmetric(vertical: 5),
              //       child: Column(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             Column(
              //                 children: [
              //                   getHeader(i+1),
              //                   getOutstandingss(start, i!=len-1 ? size : outstandings.length - start)
              //                 ]
              //             ),
              //             // getFooter()
              //           ]
              //       )
              //   )
              // ];
            },
          ),
        );
        i++;
      }
      else {
        change = true;
      }
    }

    return doc.save();
  }


  Future<Uint8List> generatePDF() async {
    os = 0;
    rec = 0;
    orec = 0;
    net = 0;
    gos = 0;
    grec = 0;
    gorec = 0;
    gnet = 0;
    update();

    final Document doc = Document(pageMode: PdfPageMode.fullscreen);


    int len = (outstandings.length/size).ceil();
    int pages = 1;

    for(int i=0; i<len; i++) {
      print("iiiiiiii");
      print(i);
      print("eeeeeeee");
      int start = i*size;
      doc.addPage(
        MultiPage(
          pageFormat: PdfPageFormat.letter,
          // orientation: PageOrientation.landscape,
          margin: EdgeInsets.all(20),
          header: (context) {
            return getHeader(context.pageNumber);
          },
          build: (Context context) {
            return getOutstandingss(start, i!=len-1 ? size : outstandings.length - start);
            // return [
            //   Container(
            //       padding: EdgeInsets.symmetric(vertical: 5),
            //       child: Column(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [
            //             Column(
            //                 children: [
            //                   getHeader(i+1),
            //                   getOutstandingss(start, i!=len-1 ? size : outstandings.length - start)
            //                 ]
            //             ),
            //             // getFooter()
            //           ]
            //       )
            //   )
            // ];
          },
        ),
      );
    }

    return doc.save();
  }




  @override
  void dispose() {
    super.dispose();
  }

  Widget getHeader(int page) {
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(company.NAME??"",
                      style: TextStyle(
                        font: bold,
                        fontSize: 14,
                      )
                  ),
                  Text(
                      "${company.ADD1??""}${(company.ADD1??"").isNotEmpty && ((company.ADD1??"").endsWith(", ") || (company.ADD1??"").endsWith(",")) ? ", " : ""}${company.ADD2??""}${(company.ADD2??"").isNotEmpty && ((company.ADD2??"").endsWith(", ") || (company.ADD2??"").endsWith(",")) ? ", " : ""}${company.ADD3??""}, ${company.CITY??""} - ${company.PINCODE??""}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        font: regular,
                        fontSize: 10,
                      )
                  ),
                  Text('GSTIN : ${company.GSTIN}',
                      style: TextStyle(
                        font: semiBold,
                        fontSize: 12,
                      )
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(),
                        Text('Multi Company Outstanding (Party Wise)',
                            style: TextStyle(
                              font: bold,
                              fontSize: 12,
                            )
                        ),
                        Text('Page #: ${page.toString()}',
                            style: TextStyle(
                              font: medium,
                              fontSize: 10,
                            )
                        ),
                      ]
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Type: Debtors",
                      style: TextStyle(
                          fontSize: 9,
                          font: regular
                      ),
                    )
                  ),
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Bill Period: ${DateFormat("dd/MM/yyyy").format(sd)} TO ${DateFormat("dd/MM/yyyy").format(sd)}",
                          style: TextStyle(
                              fontSize: 9,
                              font: regular
                          ),
                        ),
                        SizedBox(
                          width: 10
                        ),
                        Text(
                          "Payment Period: ${DateFormat("dd/MM/yyyy").format(ed)} TO ${DateFormat("dd/MM/yyyy").format(sd)}",
                          style: TextStyle(
                              fontSize: 9,
                              font: regular
                          ),
                        ),
                      ]
                  ),
                ]
            )
        )
      ]
    );
  }

  List<Widget> getOutstandingss(int start, int len) {
    return List.generate(len, (index)  {
      int ind = index;
      index = index + start;
      bool old = true;
      bool rold = false;
      bool unt = false;
      bool un = false;

      if(ind==0) {
        old = false;
      }
      else if(outstandings[index].AccountCode!=outstandings[index-1].AccountCode) {
        old = false;
        os = 0;
        orec = 0;
        rec = 0;
        net = 0;
        update();
      }
      else if(outstandings[index].OSType==1) {
        if(outstandings[index-1].OSType!=1) {
          unt = true;
        }
        un = true;
      }
      else {

        if(outstandings[index].DaybookCodeID==outstandings[index-1].DaybookCodeID) {
          rold = true;
        }
      }
      print(rold);
      return old ? un ? getUnadjusted(outstandings[index], index, unt) : rold ? getRepeatOutstanding(outstandings[index], index) : getOutstanding(outstandings[index], index) : getPartyOutstanding(outstandings[index], index);
    },);
  }

  Widget getOutstandings(int start, int len) {
    return ListView.builder(
      itemCount: len,
      padding: EdgeInsets.symmetric(horizontal: 5),
      // itemCount: outstanding.length,
      itemBuilder: (context, index) {
        int ind = index;
        index = index + start;
        bool old = true;
        bool rold = false;
        bool unt = false;
        bool un = false;

        if(ind==0) {
          old = false;
        }
        else if(outstandings[index].AccountCode!=outstandings[index-1].AccountCode) {
          old = false;
          os = 0;
          orec = 0;
          rec = 0;
          net = 0;
          update();
        }
        else if(outstandings[index].OSType==1) {
          if(outstandings[index-1].OSType!=1) {
            unt = true;
          }
          un = true;
        }
        else {

          if(outstandings[index].DaybookCodeID==outstandings[index-1].DaybookCodeID) {
            rold = true;
          }
        }
        print(rold);
        return old ? un ? getUnadjusted(outstandings[index], index, unt) : rold ? getRepeatOutstanding(outstandings[index], index) : getOutstanding(outstandings[index], index) : getPartyOutstanding(outstandings[index], index);
      },
    );
  }


  Widget getPartyOutstanding(OutstandingModel outstanding, int index) {
    net += outstanding.NetAmount??0;
    rec += outstanding.AdjustedAmount??0;
    orec += outstanding.AdjustedAmount??0;
    os += outstanding.NetOSAmount??0;

    gnet += outstanding.NetAmount??0;
    grec += outstanding.AdjustedAmount??0;
    gorec += outstanding.AdjustedAmount??0;
    gos += outstanding.NetOSAmount??0;
    update();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(index!=0)
          getTotalDesign("Party Total"),
        RichText(
          text: TextSpan(
            text: "Party: ",
            style: TextStyle(
              fontSize: 9,
              font: regular
            ),
            children: [
              TextSpan(
                text: outstanding.AccountName,
                style: TextStyle(
                    fontSize: 9,
                    font: bold
                ),
              ),
            ]
          ),
        ),
        Text(
          "Address: "+(outstanding.AccountAddress??""),
          style: TextStyle(
            fontSize: 9,
            font: regular
          ),
        ),
        Divider(
          thickness: 1,
          height: 0
        ),
        Table(
          border: TableBorder(
            horizontalInside: BorderSide()
          ),
          columnWidths: {
            0: FlexColumnWidth(1.7), // First column takes up 1/3 of the available width
            1: FlexColumnWidth(1.2),
            2: FlexColumnWidth(0.8),
            3: FlexColumnWidth(1.2),
            4: FlexColumnWidth(1.5),
            5: FlexColumnWidth(1.5),
            6: FlexColumnWidth(1.7),
            7: FlexColumnWidth(2),
            8: FlexColumnWidth(1.7),
            9: FlexColumnWidth(1.2),
            10: FlexColumnWidth(1.5),
          },
          children: [
            TableRow(
              children: [
                getTitle("Date"),
                getTitle("V No."),
                getTitle("Due Days", textAlign: TextAlign.right),
                getTitle("Txn Days", textAlign: TextAlign.right),
                getTitle("Net Amount", textAlign: TextAlign.right),
                getTitle("Cheque Date", textAlign: TextAlign.right),
                getTitle("Rec. Date", textAlign: TextAlign.right),
                getTitle("Rec. Book", textAlign: TextAlign.right),
                getTitle("Ret. Amt.", textAlign: TextAlign.right),
                getTitle("Oth. Rec. Amt.", textAlign: TextAlign.right),
                getTitle("OS. Amt.", textAlign: TextAlign.right),
              ]
            ),
            TableRow(
              children: [
                getInfo(DateFormat("dd/MM/yyyy").format(DateTime.parse(outstanding.TxnDate??""))),
                getInfo((outstanding.DocNumber??"").trim()),
                getInfo((outstanding.DueDays??"").toString(), textAlign: TextAlign.right),
                getInfo((outstanding.TxnDays??"").toString(), textAlign: TextAlign.right),
                getInfo((outstanding.NetAmount??0).toStringAsFixed(2), textAlign: TextAlign.right),
                getInfo((outstanding.ChequeDate??"").isNotEmpty ? DateFormat("dd/MM/yyyy").format(DateTime.parse(outstanding.ChequeDate??"")) : "", textAlign: TextAlign.right),
                getInfo((outstanding.AdjTxnDate??"").isNotEmpty ? DateFormat("dd/MM/yyyy").format(DateTime.parse(outstanding.AdjTxnDate??"")) : "", textAlign: TextAlign.right),
                getInfo(outstanding.AdjDaybookCode??"", textAlign: TextAlign.right),
                getInfo((outstanding.ReturnAdjAmount??0).toStringAsFixed(2), textAlign: TextAlign.right),
                getInfo((outstanding.OtherTotalAdjAmount??0).toStringAsFixed(2), textAlign: TextAlign.right),
                getInfo((outstanding.BalanceAmount??0).toStringAsFixed(2), textAlign: TextAlign.right),
              ]
            )
          ]
        ),
        if(index==outstandings.length-1)
          Column(
            children: [
              getTotalDesign("Party Total"),
              getTotalDesign("Grand Total")
            ]
          ),
      ]
    );
  }

  Widget getOutstanding(OutstandingModel outstanding, int index) {
    net += outstanding.NetAmount??0;
    rec += outstanding.AdjustedAmount??0;
    orec += outstanding.AdjustedAmount??0;
    os += outstanding.NetOSAmount??0;

    gnet += outstanding.NetAmount??0;
    grec += outstanding.AdjustedAmount??0;
    gorec += outstanding.AdjustedAmount??0;
    gos += outstanding.NetOSAmount??0;
    update();

    return Column(
      children: [
        Table(
            columnWidths: {
              0: FlexColumnWidth(1.7), // First column takes up 1/3 of the available width
              1: FlexColumnWidth(1.2),
              2: FlexColumnWidth(0.8),
              3: FlexColumnWidth(1.2),
              4: FlexColumnWidth(1.5),
              5: FlexColumnWidth(1.5),
              6: FlexColumnWidth(1.7),
              7: FlexColumnWidth(2),
              8: FlexColumnWidth(1.7),
              9: FlexColumnWidth(1.2),
              10: FlexColumnWidth(1.5),
            },
            children: [
              TableRow(
                  children: [
                    getInfo(DateFormat("dd/MM/yyyy").format(DateTime.parse(outstanding.TxnDate??""))),
                    getInfo((outstanding.DocNumber??"").trim()),
                    getInfo((outstanding.DueDays??"").toString(), textAlign: TextAlign.right),
                    getInfo((outstanding.TxnDays??"").toString(), textAlign: TextAlign.right),
                    getInfo((outstanding.NetAmount??0).toStringAsFixed(2), textAlign: TextAlign.right),
                    getInfo((outstanding.ChequeDate??"").isNotEmpty ? DateFormat("dd/MM/yyyy").format(DateTime.parse(outstanding.ChequeDate??"")) : "", textAlign: TextAlign.right),
                    getInfo((outstanding.AdjTxnDate??"").isNotEmpty ? DateFormat("dd/MM/yyyy").format(DateTime.parse(outstanding.AdjTxnDate??"")) : "", textAlign: TextAlign.right),
                    getInfo(outstanding.AdjDaybookCode??"", textAlign: TextAlign.right),
                    getInfo((outstanding.ReturnAdjAmount??0).toStringAsFixed(2), textAlign: TextAlign.right),
                    getInfo((outstanding.OtherAdjAmount??0).toStringAsFixed(2), textAlign: TextAlign.right),
                    getInfo((outstanding.BalanceAmount??0).toStringAsFixed(2), textAlign: TextAlign.right),
                  ]
              )
            ]
        ),
        if(index==outstandings.length-1)
          Column(
              children: [
                getTotalDesign("Party Total"),
                getTotalDesign("Grand Total")
              ]
          ),
      ]
    );
  }

  Widget getRepeatOutstanding(OutstandingModel outstanding, int index) {
    net += outstanding.NetAmount??0;
    rec += outstanding.AdjustedAmount??0;
    orec += outstanding.AdjustedAmount??0;
    os += outstanding.NetOSAmount??0;

    gnet += outstanding.NetAmount??0;
    grec += outstanding.AdjustedAmount??0;
    gorec += outstanding.AdjustedAmount??0;
    gos += outstanding.NetOSAmount??0;
    update();

    return Column(
      children: [
        Table(
            columnWidths: {
              0: FlexColumnWidth(1.7), // First column takes up 1/3 of the available width
              1: FlexColumnWidth(1.2),
              2: FlexColumnWidth(0.8),
              3: FlexColumnWidth(1.2),
              4: FlexColumnWidth(1.5),
              5: FlexColumnWidth(1.5),
              6: FlexColumnWidth(1.7),
              7: FlexColumnWidth(2),
              8: FlexColumnWidth(1.7),
              9: FlexColumnWidth(1.2),
              10: FlexColumnWidth(1.5),
            },
            children: [
              TableRow(
                  children: [
                    getInfo(""),
                    getInfo(""),
                    getInfo(""),
                    getInfo(""),
                    getInfo(""),
                    getInfo((outstanding.ChequeDate??"").isNotEmpty ? DateFormat("dd/MM/yyyy").format(DateTime.parse(outstanding.ChequeDate??"")) : "", textAlign: TextAlign.right),
                    getInfo((outstanding.AdjTxnDate??"").isNotEmpty ? DateFormat("dd/MM/yyyy").format(DateTime.parse(outstanding.AdjTxnDate??"")) : "", textAlign: TextAlign.right),
                    getInfo(outstanding.AdjDaybookCode??"", textAlign: TextAlign.right),
                    getInfo((outstanding.ReturnAdjAmount??0).toStringAsFixed(2), textAlign: TextAlign.right),
                    getInfo((outstanding.OtherAdjAmount??0).toStringAsFixed(2), textAlign: TextAlign.right),
                    getInfo(""),
                  ]
              )
            ]
        ),
        if(index==outstandings.length-1)
          Column(
              children: [
                getTotalDesign("Party Total"),
                getTotalDesign("Grand Total")
              ]
          ),
      ]
    );
  }

  Widget getUnadjusted(OutstandingModel outstanding, int index, bool unt) {
    net += outstanding.NetAmount??0;
    rec += outstanding.AdjustedAmount??0;
    orec += outstanding.AdjustedAmount??0;
    os += outstanding.NetOSAmount??0;

    gnet += outstanding.NetAmount??0;
    grec += outstanding.AdjustedAmount??0;
    gorec += outstanding.AdjustedAmount??0;
    gos += outstanding.NetOSAmount??0;
    update();

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if(unt)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(
                  thickness: 1,
                  height: 0
                ),
                getTotalDesign("Adj. Total"),
                Divider(
                  thickness: 1,
                  height: 0
                ),
                Text(
                  "Unadjusted Entries - "+(outstanding.AccountName??""),
                  style: TextStyle(
                    fontSize: 9,
                    font: bold
                  ),
                ),
              ]
            ),
          Table(
              border: TableBorder(
                  horizontalInside: BorderSide()
              ),
              columnWidths: {
                0: FlexColumnWidth(1.7), // First column takes up 1/3 of the available width
                1: FlexColumnWidth(1.2),
                2: FlexColumnWidth(0.8),
                3: FlexColumnWidth(1.2),
                4: FlexColumnWidth(1.5),
                5: FlexColumnWidth(1.5),
                6: FlexColumnWidth(1.7),
                7: FlexColumnWidth(2),
                8: FlexColumnWidth(1.7),
                9: FlexColumnWidth(1.2),
                10: FlexColumnWidth(1.5),
              },
              children: [
                TableRow(
                    children: [
                      getInfo(DateFormat("dd/MM/yyyy").format(DateTime.parse(outstanding.TxnDate??""))),
                      getInfo((outstanding.DocNumber??"").trim()),
                      getInfo((outstanding.DueDays??"").toString(), textAlign: TextAlign.right),
                      getInfo((outstanding.TxnDays??"").toString(), textAlign: TextAlign.right),
                      getInfo((outstanding.NetAmount??0).toStringAsFixed(2), textAlign: TextAlign.right),
                      getInfo((outstanding.ChequeDate??"").isNotEmpty ? DateFormat("dd/MM/yyyy").format(DateTime.parse(outstanding.ChequeDate??"")) : "", textAlign: TextAlign.right),
                      getInfo((outstanding.AdjTxnDate??"").isNotEmpty ? DateFormat("dd/MM/yyyy").format(DateTime.parse(outstanding.AdjTxnDate??"")) : "", textAlign: TextAlign.right),
                      getInfo(outstanding.AdjDaybookCode??"", textAlign: TextAlign.right),
                      getInfo((outstanding.ReturnAdjAmount??0).toStringAsFixed(2), textAlign: TextAlign.right),
                      getInfo((outstanding.OtherTotalAdjAmount??0).toStringAsFixed(2), textAlign: TextAlign.right),
                      getInfo((outstanding.BalanceAmount??0).toStringAsFixed(2), textAlign: TextAlign.right),
                    ]
                )
              ]
          ),
          if(index==outstandings.length-1)
            Column(
                children: [
                  getTotalDesign("Party Total"),
                  getTotalDesign("Grand Total")
                ]
            ),
        ]
    );
  }

  Widget getTotalDesign(String title) {
    return Column(
      children: [
        if(title.contains("Party"))
          Divider(
            thickness: 1,
            height: 2
          ),
        // Table(
        //   columnWidths: {
        //     0: FlexColumnWidth(1.7), // First column takes up 1/3 of the available width
        //     1: FlexColumnWidth(1.2),
        //     2: FlexColumnWidth(0.8),
        //     3: FlexColumnWidth(1.2),
        //     4: FlexColumnWidth(1.5),
        //     5: FlexColumnWidth(1.5),
        //     6: FlexColumnWidth(1.7),
        //     7: FlexColumnWidth(2),
        //     8: FlexColumnWidth(1.7),
        //     9: FlexColumnWidth(1.2),
        //     10: FlexColumnWidth(1.5),
        //   },
        //   children: [
        //     title.contains("Grand") ?
        //     TableRow(
        //         children: [
        //           getInfo("sh"),
        //           getInfo("ghgv"),
        //           getInfo("gvhg "),
        //           getInfo("${title}:", textAlign: TextAlign.right),
        //           getInfo(gnet.toString(), textAlign: TextAlign.right),
        //           getInfo(""),
        //           getInfo(""),
        //           getInfo(""),
        //           getInfo(""),
        //           getInfo(grec.toString(), textAlign: TextAlign.right),
        //           getInfo(gorec.toString(), textAlign: TextAlign.right),
        //           getInfo(gos.toString(), textAlign: TextAlign.right),
        //         ]
        //     )
        //     : TableRow(
        //         children: [
        //           getInfo(""),
        //           getInfo(""),
        //           getInfo(""),
        //           getInfo("${title}:", textAlign: TextAlign.right),
        //           getInfo(net.toString(), textAlign: TextAlign.right),
        //           getInfo(""),
        //           getInfo(""),
        //           getInfo(""),
        //           getInfo(""),
        //           getInfo(rec.toString(), textAlign: TextAlign.right),
        //           getInfo(orec.toString(), textAlign: TextAlign.right),
        //           getInfo(os.toString(), textAlign: TextAlign.right),
        //         ]
        //     )
        //   ]
        // ),
        Table(
            columnWidths: {
              0: FlexColumnWidth(1.7), // First column takes up 1/3 of the available width
              1: FlexColumnWidth(1.2),
              2: FlexColumnWidth(0.8),
              3: FlexColumnWidth(1.2),
              4: FlexColumnWidth(1.5),
              5: FlexColumnWidth(1.5),
              6: FlexColumnWidth(1.7),
              7: FlexColumnWidth(2),
              8: FlexColumnWidth(1.7),
              9: FlexColumnWidth(1.2),
              10: FlexColumnWidth(1.5),
            },
            children: [
              title.contains("Party") ?
              TableRow(
                  children: [
                    getTitle(""),
                    getTitle(""),
                    getTitle(""),
                    getTitle("${title}:", textAlign: TextAlign.right, size: 9.5),
                    getTitle(net.toStringAsFixed(2), textAlign: TextAlign.right),
                    getTitle(""),
                    getTitle(""),
                    getTitle(""),
                    getTitle(rec.toStringAsFixed(2), textAlign: TextAlign.right),
                    getTitle(orec.toStringAsFixed(2), textAlign: TextAlign.right),
                    getTitle(os.toStringAsFixed(2), textAlign: TextAlign.right),
                  ]
              )
              : TableRow(
                  children: [
                    getTitle(""),
                    getTitle(""),
                    getTitle(""),
                    getTitle("${title}:", textAlign: TextAlign.right, size: 9.5),
                    getTitle(gnet.toStringAsFixed(2), textAlign: TextAlign.right),
                    getTitle(""),
                    getTitle(""),
                    getTitle(""),
                    getTitle(grec.toStringAsFixed(2), textAlign: TextAlign.right),
                    getTitle(gorec.toStringAsFixed(2), textAlign: TextAlign.right),
                    getTitle(gos.toStringAsFixed(2), textAlign: TextAlign.right),
                  ]
              )
            ]
        ),
        Divider(
            thickness: 1,
            height: 2
        ),
      ]
    );
  }

  Widget getFooter() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('TERMS & CONDITIONS',
                    style: TextStyle(
                      font: semiBold,
                      fontSize: 14,
                    )
                  ),
                  Text('1.\t\t24% Interest will be charge from due date.\n2.\t\tYour risk & responsibility ceases after the goods dispatched from our shop.\n3.\t\tSubject to SURAT Jurisdiction Only.',
                    style: TextStyle(
                      font: regular,
                      fontSize: 10,
                    )
                  ),
                ]
              ),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('E. & O.E.',
                    style: TextStyle(
                      font: semiBold,
                      fontSize: 14,
                    )
                  ),
                  Text('For\t\t\t\t${CommonConstants.app_name}',
                    style: TextStyle(
                      font: semiBold,
                      fontSize: 10,
                    )
                  ),
                  SizedBox(
                    height: 30
                  ),
                  Text('Authorised Signatory',
                    style: TextStyle(
                      font: medium,
                      fontSize: 10,
                    )
                  ),
                ]
              )
            ]
        )
    );
  }

  Widget getHeading() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
          Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Container()
          ),
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Text(
                "TAX INVOICE",
                textAlign: TextAlign.center,
                style: TextStyle(
                  font: semiBold,
                  fontSize: 14,
                )
            ),
          ),
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Text(
                "Place of Supply - ",
                textAlign: TextAlign.center,
                style: TextStyle(
                  font: semiBold,
                  fontSize: 10,
                )
            ),
          )
        ]
    );
  }

  Widget getRegularInfoCombo(String title, String data, {int? flex1, int? flex2, CrossAxisAlignment? crossAxisAlignment, TextAlign? textAlign, String? mediator}) {
    return Row(
        crossAxisAlignment: crossAxisAlignment??CrossAxisAlignment.start,
        children: [
          Flexible(
              flex: flex1??2,
              fit: FlexFit.tight,
              child: Text(
                title,
                style: TextStyle(
                    fontSize: 10,
                    font: regular
                ),
              )
          ),
          Text(
            mediator??" : ",
            style: TextStyle(
              fontSize: 10,
              font: regular
            ),
          ),
          Flexible(
              flex: flex2??5,
              fit: FlexFit.tight,
              child: Text(
                data,
                style: TextStyle(
                  fontSize: 10,
                  font: regular
                ),
              )
          )
        ]
    );
  }

  Widget getTitle(String data, {EdgeInsets? padding, TextAlign? textAlign, double? size}) {
    return Padding(
        padding: padding??EdgeInsets.zero,
        child: Text(
          data,
          textAlign: textAlign??TextAlign.left,
          style: TextStyle(
              fontSize: size??10,
              font: bold
          ),
        )
    );
  }

  Widget getInfo(String data, {EdgeInsets? padding, TextAlign? textAlign}) {
    return Padding(
        // color: PdfColors.amber700,
        padding: padding??EdgeInsets.zero,
        child: Text(
          data,
          textAlign: textAlign??TextAlign.left,
          style: TextStyle(
              fontSize: 10,
              font: semiBold
          ),
        )
    );
  }

  void shareFile() {
    XFile xFile =  XFile(file!.path);
    Essential.shareFile([xFile], "outstanding Bill :  ${sd.toString()}");
  }

}
