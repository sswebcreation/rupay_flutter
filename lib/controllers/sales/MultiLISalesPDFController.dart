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
import 'package:rupay/models/lineItem/LineItemModel.dart';
import 'package:rupay/models/sales/SalesModel.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:path_provider/path_provider.dart';


class MultiLISalesPDFController extends GetxController {
  MultiLISalesPDFController();

  final storage = GetStorage();



  // late SalesModel sales;
  late List<SalesModel> temp;
  late List<SalesModel> sales;
  late int id;
  late bool load;
  File? file;
  final Completer<PDFViewController> controller =
  Completer<PDFViewController>();
  int? pages = 0;
  int? currentPage = 0;
  bool isReady = false;
  String errorMessage = '';

  late double pcs, cut, mts, rate, amount, taxable;
  late ByteData fontData;
  late Font light, regular, medium, semiBold, bold;
  late DateTime sd, ed;

  int size = 25;
  late CompanyModel company;

  @override
  void onInit() {
    super.onInit();
    temp = Get.arguments['sales'];
    sales = [];
    sd = Get.arguments['sd'];
    ed = Get.arguments['ed'];
    // id = Get.arguments;
    pcs = cut = mts = rate = amount = taxable = 0.0;
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
    createSalesList();
    if (await Essential.requestPermission().isGranted) {
      load = false;
      update();
    final Uint8List pdfBytes = await generatePDF();
    final directory = await getTemporaryDirectory();
    // final directory = await getTemporaryDirectory();

    // Create a new temporary file with a unique name
    String name = "US-Sales-"+DateFormat("dd MMM, yyyy").format(sd)+" - "+DateFormat("dd MMM, yyyy").format(ed);
    file = File('${directory?.path}/${name}.pdf');

    await file!.writeAsBytes(pdfBytes);
    }
    load = true;

    update();
  }

  createSalesList() {
    sales = [];
    double pcs = 0;
    double ppcs = 0;
    double gpcs = 0;
    double gst = 0;
    double pgst = 0;
    double ggst = 0;
    double amount = 0;
    double pamount = 0;
    double gamount = 0;

    for(int i=0; i<temp.length; i++) {
      if(i!=0) {
        DateTime d1 = DateTime.parse(temp[i-1].TXNDATE??"");
        DateTime d2 = DateTime.parse(temp[i].TXNDATE??"");
        
        if(d1.compareTo(d2)!=0) {
          // sales.add(SalesModel(ID: -1, ACCOUNTCODE: temp[i].ACCOUNTCODE, item: LineItemModel(SCREENNAME: "Total", QTY1: pcs), GST: gst, NETAMOUNT: amount));
          sales.add(temp[i-1].copyWith(ID: -1, ACCOUNTCODE: temp[i-1].ACCOUNTCODE, DOCNUMBER: "", item: LineItemModel(SCREENNAME: "Total", QTY1: pcs), GST: gst, NETAMOUNT: amount));
          pcs = 0;
          gst = 0;
          amount = 0;
        }
        if(temp[i].ACCOUNTCODE!=temp[i-1].ACCOUNTCODE) {
          // sales.add(SalesModel(ID: -1, ACCOUNTCODE: temp[i].ACCOUNTCODE, item: LineItemModel(SCREENNAME: "Party Total", QTY1: ppcs), GST: pgst, NETAMOUNT: pamount));
          sales.add(temp[i-1].copyWith(ID: -1, ACCOUNTCODE: temp[i-1].ACCOUNTCODE, DOCNUMBER: "", item: LineItemModel(SCREENNAME: "Party Total", QTY1: ppcs), GST: pgst, NETAMOUNT: pamount));
          ppcs = 0;
          pgst = 0;
          pamount = 0;
        }
      }
      try {
        List<dynamic> li = json.decode(temp[i].LINEITEM ?? "");
        for (var ele in li) {
          LineItemModel item = LineItemModel.fromJson(ele);
          sales.add(temp[i].copyWith(item: item));
          pcs+=item.QTY1??0;
          gst+=temp[i].GST??0;
          amount+=temp[i].NETAMOUNT??0;
          ppcs+=item.QTY1??0;
          pgst+=temp[i].GST??0;
          pamount+=temp[i].NETAMOUNT??0;
          gpcs+=item.QTY1??0;
          ggst+=temp[i].GST??0;
          gamount+=temp[i].NETAMOUNT??0;
        }


        if(i==temp.length-1) {
          // sales.add(SalesModel(ID: -1, ACCOUNTCODE: temp[i].ACCOUNTCODE, item: LineItemModel(SCREENNAME: "Party Total", QTY1: ppcs), GST: pgst, NETAMOUNT: pamount));
          sales.add(temp[i].copyWith(ID: -1, ACCOUNTCODE: temp[i].ACCOUNTCODE, DOCNUMBER: "", item: LineItemModel(SCREENNAME: "Party Total", QTY1: ppcs), GST: pgst, NETAMOUNT: pamount));
          ppcs = 0;
          pgst = 0;
          pamount = 0;
          // sales.add(SalesModel(ID: -1, ACCOUNTCODE: temp[i].ACCOUNTCODE, item: LineItemModel(SCREENNAME: "Grand Total", QTY1: gpcs), GST: ggst, NETAMOUNT: gamount));
          sales.add(temp[i].copyWith(ID: -1, ACCOUNTCODE: temp[i].ACCOUNTCODE, DOCNUMBER: "", item: LineItemModel(SCREENNAME: "Grand Total", QTY1: gpcs), GST: ggst, NETAMOUNT: gamount));
          gpcs = 0;
          ggst = 0;
          gamount = 0;
        }
      }
      catch(e) {
        continue;
      }
    }

    print(sales.length);
    update();
  }

  Future<Uint8List> generatePDF() async {
    print("generate");
    final Document doc = Document(pageMode: PdfPageMode.fullscreen);

    int len = sales.length;
    bool change = true;
    int max = 1;

    while(change) {
      doc.addPage(
        MultiPage(
          pageFormat: PdfPageFormat.letter,
          maxPages: max,
          margin: EdgeInsets.all(20),
          header: (context) {
            return getHeader(context.pageNumber);
          },
          footer: (context) {
            max+=1;
            return Container();
          },
          build: (Context context) {
            change = false;
            return getSales(len);
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
        Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(company.NAME??"",
                  style: TextStyle(
                    font: bold,
                    fontSize: 12,
                  )
              ),
              Text(
                  "${company.ADD1??""}${(company.ADD1??"").isNotEmpty && ((company.ADD1??"").endsWith(", ") || (company.ADD1??"").endsWith(",")) ? ", " : ""}${company.ADD2??""}${(company.ADD2??"").isNotEmpty && ((company.ADD2??"").endsWith(", ") || (company.ADD2??"").endsWith(",")) ? ", " : ""}${company.ADD3??""}, ${company.CITY??""} - ${company.PINCODE??""}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    font: regular,
                    fontSize: 8,
                  )
              ),
              if((company.GSTIN??"").isNotEmpty)
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
                    Text('Sales Register - Partywise With Item Detail',
                        style: TextStyle(
                          font: bold,
                          fontSize: 10,
                        )
                    ),
                    Text('Page #: ${page.toString()}',
                        style: TextStyle(
                          font: medium,
                          fontSize: 8,
                        )
                    ),
                  ]
              ),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Daybooks: SALES INVOICE B2B (GSTIN CUSTOMERS)",
                      style: TextStyle(
                          fontSize: 9,
                          font: regular
                      ),
                    ),
                    Text(
                      "Period: ${DateFormat("dd/MM/yyyy").format(sd)} TO ${DateFormat("dd/MM/yyyy").format(ed)}",
                      style: TextStyle(
                          fontSize: 9,
                          font: regular
                      ),
                    ),
                    Text(
                      "Checked Style: (All)",
                      style: TextStyle(
                          fontSize: 9,
                          font: regular
                      ),
                    ),
                  ]
              ),
            ]
        ),
        Divider(
          thickness: 1,
          height: 0
        ),
      ]
    );
  }

  List<Widget> getSales(int len) {
    return List.generate(len, (index)  {
        int ind = index;
        index = index;
        bool old = true;
        bool repeat = false;
        if(ind==0) {
          old = false;
        }
        else if(sales[index].ACCOUNTCODE!=sales[index-1].ACCOUNTCODE) {
          old = false;
        }
        else if((sales[index].DOCNUMBER??"").trim()==(sales[index-1].DOCNUMBER??"").trim()) {
          repeat = true;
        }

        return old ? repeat ? getRepeatSale(sales[index]) : getSale(sales[index]) : getPartySales(sales[index]);
      },
    );
  }

  // Widget getTableInfo() {
  //   return Table(
  //     children: List.generate(sales.length, (index) => () {
  //       return TableRow(children: children)
  //     })
  //   );
  // }
  //
  // Widget getTableInfo() {
  //   return Table(
  //     children: List.generate(sales.length, (index) => () {
  //       return TableRow(children: children)
  //     })
  //   );
  // }

  Widget getPartySales(SalesModel sales) {
    print((sales.ID??""));
    print((sales.DOCNUMBER??"").trim());
    String screen = (sales.item?.SCREENNAME??"").trim();
    if(screen.isEmpty) {
      screen = (sales.item?.ITEMNAME??"").trim();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(
            thickness: 1,
            height: 0
        ),
        RichText(
          text: TextSpan(
              text: "Party: ",
              style: TextStyle(
                  fontSize: 9,
                  font: regular
              ),
              children: [
                TextSpan(
                  text: sales.ACCOUNTNAME,
                  style: TextStyle(
                      fontSize: 9,
                      font: bold
                  ),
                ),
              ]
          ),
        ),
        Text(
          "Address: ${sales.ADD1??""}${(sales.ADD1??"").isNotEmpty && ((sales.ADD1??"").endsWith(", ") || (sales.ADD1??"").endsWith(",")) ? ", " : ""}${sales.ADD2??""}, ${sales.CITY??""} - ${sales.PINCODE??""}",
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
            columnWidths: {
              0: FlexColumnWidth(1.1), // First column takes up 1/3 of the available width
              1: FlexColumnWidth(0.6),
              2: FlexColumnWidth(2.5),
              3: FlexColumnWidth(0.9),
              4: FlexColumnWidth(1),
              5: FlexColumnWidth(1.1),
              6: FlexColumnWidth(1.5),
              7: FlexColumnWidth(1.2),
              8: FlexColumnWidth(1.2),
              9: FlexColumnWidth(2.5),
            },
            children: [
              TableRow(
                  children: [
                    getTitle("Bill Date"),
                    getTitle("Bill No."),
                    getTitle("Screen", padding: EdgeInsets.only(left: 10)),
                    getTitle("PCS", textAlign: TextAlign.right),
                    getTitle("Rate", textAlign: TextAlign.right),
                    getTitle("GST", textAlign: TextAlign.right),
                    getTitle("Amount", textAlign: TextAlign.right),
                    getTitle("LR No.", padding: EdgeInsets.only(left: 10)),
                    getTitle("LR Date"),
                    getTitle("Transport"),
                  ]
              ),
            ]
        ),
        Divider(
          thickness: 1,
          height: 0,
        ),
        Table(
            columnWidths: {
              0: FlexColumnWidth(1.1), // First column takes up 1/3 of the available width
              1: FlexColumnWidth(0.6),
              2: FlexColumnWidth(2.5),
              3: FlexColumnWidth(0.9),
              4: FlexColumnWidth(1),
              5: FlexColumnWidth(1.1),
              6: FlexColumnWidth(1.5),
              7: FlexColumnWidth(1.2),
              8: FlexColumnWidth(1.2),
              9: FlexColumnWidth(2.5),
            },
            children: [
              sales.ID==-1 ?
              TableRow(
                  children: [
                    getTitle(""),
                    getTitle(""),
                    getTitle(screen, padding: EdgeInsets.only(left: 10), textAlign: TextAlign.right),
                    getTitle(screen.contains("Total") ? (sales.item?.QTY1??0).toStringAsFixed(2) : (sales.item?.QTY1??0).toStringAsFixed(2), textAlign: TextAlign.right),
                    getTitle(""),
                    getTitle(screen.contains("Total") ? (sales.GST??0).toStringAsFixed(2) : (sales.GST??0).toStringAsFixed(2), textAlign: TextAlign.right),
                    getTitle(screen.contains("Total") ? (sales.NETAMOUNT??0).toStringAsFixed(2) : (sales.NETAMOUNT??0).toStringAsFixed(2), textAlign: TextAlign.right),
                    getTitle(""),
                    getTitle(""),
                    getTitle(""),
                  ]
              )
              : TableRow(
                  children: [
                    getInfo(DateFormat("dd/MM/yyyy").format(DateTime.parse(sales.TXNDATE??""))),
                    getInfo((sales.DOCNUMBER??"").trim()),
                    getInfo(screen, padding: EdgeInsets.only(left: 10)),
                    getInfo((sales.item?.QTY1??0).toStringAsFixed(2), textAlign: TextAlign.right),
                    getInfo((sales.item?.ITEMRATE??0).toStringAsFixed(2), textAlign: TextAlign.right),
                    getInfo((sales.GST??0).toStringAsFixed(2), textAlign: TextAlign.right),
                    getInfo((sales.NETAMOUNT??0).toStringAsFixed(2), textAlign: TextAlign.right),
                    getInfo(sales.LRNO??"", padding: EdgeInsets.only(left: 10)),
                    getInfo(sales.LRDate??""),
                    getInfo(sales.TRANSPORT??""),
                  ]
              )
            ]
        ),
        if(sales.ID==-1)
          Divider(
            thickness: 1,
            height: 0,
          ),
      ]
    );
  }

  Widget getSale(SalesModel sales) {
    String screen = (sales.item?.SCREENNAME??"").trim();
    if(screen.isEmpty) {
      screen = (sales.item?.ITEMNAME??"").trim();
    }

    return Column(
      children: [
        if(sales.ID==-1)
          Divider(
            thickness: 1,
            height: 0,
          ),
        Table(
          columnWidths: {
            0: FlexColumnWidth(1.1), // First column takes up 1/3 of the available width
            1: FlexColumnWidth(0.6),
            2: FlexColumnWidth(2.5),
            3: FlexColumnWidth(0.9),
            4: FlexColumnWidth(1),
            5: FlexColumnWidth(1.1),
            6: FlexColumnWidth(1.5),
            7: FlexColumnWidth(1.2),
            8: FlexColumnWidth(1.2),
            9: FlexColumnWidth(2.5),
          },
          children: [
              sales.ID==-1 ?
              TableRow(
                  children: [
                    getTitle(""),
                    getTitle(""),
                    getTitle(screen, padding: EdgeInsets.only(left: 10), textAlign: TextAlign.right),
                    getTitle(screen.contains("Total") ? (sales.item?.QTY1??0).toStringAsFixed(2) : (sales.item?.QTY1??0).toStringAsFixed(2), textAlign: TextAlign.right),
                    getTitle(""),
                    getTitle(screen.contains("Total") ? (sales.GST??0).toStringAsFixed(2) : (sales.GST??0).toStringAsFixed(2), textAlign: TextAlign.right),
                    getTitle(screen.contains("Total") ? (sales.NETAMOUNT??0).toStringAsFixed(2) : (sales.NETAMOUNT??0).toStringAsFixed(2), textAlign: TextAlign.right),
                    getTitle(""),
                    getTitle(""),
                    getTitle(""),
                  ]
              )
                  : TableRow(
                  children: [
                    getInfo(DateFormat("dd/MM/yyyy").format(DateTime.parse(sales.TXNDATE??""))),
                    getInfo((sales.DOCNUMBER??"").trim()),
                    getInfo(screen, padding: EdgeInsets.only(left: 10)),
                    getInfo((sales.item?.QTY1??0).toStringAsFixed(2), textAlign: TextAlign.right),
                    getInfo((sales.item?.ITEMRATE??0).toStringAsFixed(2), textAlign: TextAlign.right),
                    getInfo((sales.GST??0).toStringAsFixed(2), textAlign: TextAlign.right),
                    getInfo((sales.NETAMOUNT??0).toStringAsFixed(2), textAlign: TextAlign.right),
                    getInfo(sales.LRNO??"", padding: EdgeInsets.only(left: 10)),
                    getInfo(sales.LRDate??""),
                    getInfo(sales.TRANSPORT??""),
                  ]
              )
            ]
        ),
        if(sales.ID==-1)
          Divider(
            thickness: 1,
            height: 0,
          ),
      ]
    );
  }

  Widget getRepeatSale(SalesModel sales) {
    String screen = (sales.item?.SCREENNAME??"").trim();
    if(screen.isEmpty) {
      screen = (sales.item?.ITEMNAME??"").trim();
    }

    return Column(
      children: [
        if(sales.ID==-1)
          Divider(
            thickness: 1,
            height: 0,
          ),
        Table(
          columnWidths: {
            0: FlexColumnWidth(1.1), // First column takes up 1/3 of the available width
            1: FlexColumnWidth(0.6),
            2: FlexColumnWidth(2.5),
            3: FlexColumnWidth(0.9),
            4: FlexColumnWidth(1),
            5: FlexColumnWidth(1.1),
            6: FlexColumnWidth(1.5),
            7: FlexColumnWidth(1.2),
            8: FlexColumnWidth(1.2),
            9: FlexColumnWidth(2.5),
          },
          children: [
            sales.ID==-1 ?
            TableRow(
                children: [
                  getTitle(""),
                  getTitle(""),
                  getTitle(screen, padding: EdgeInsets.only(left: 10), textAlign: TextAlign.right),
                  getTitle(screen.contains("Total") ? (sales.item?.QTY1??0).toStringAsFixed(2) : (sales.item?.QTY1??0).toStringAsFixed(2), textAlign: TextAlign.right),
                  getTitle(""),
                  getTitle(screen.contains("Total") ? (sales.GST??0).toStringAsFixed(2) : (sales.GST??0).toStringAsFixed(2), textAlign: TextAlign.right),
                  getTitle(screen.contains("Total") ? (sales.NETAMOUNT??0).toStringAsFixed(2) : (sales.NETAMOUNT??0).toStringAsFixed(2), textAlign: TextAlign.right),
                  getTitle(""),
                  getTitle(""),
                  getTitle(""),
                ]
            )
            : TableRow(
                children: [
                  getInfo(""),
                  getInfo(""),
                  getInfo(screen, padding: EdgeInsets.only(left: 10)),
                  getInfo((sales.item?.QTY1??0).toStringAsFixed(2), textAlign: TextAlign.right),
                  getInfo((sales.item?.ITEMRATE??0).toStringAsFixed(2), textAlign: TextAlign.right),
                  getInfo((sales.GST??0).toStringAsFixed(2), textAlign: TextAlign.right),
                  getInfo((sales.NETAMOUNT??0).toStringAsFixed(2), textAlign: TextAlign.right),
                  getInfo(sales.LRNO??"", padding: EdgeInsets.only(left: 10)),
                  getInfo(sales.LRDate??""),
                  getInfo(sales.TRANSPORT??""),
                ]
            )
          ]
        ),
        if(sales.ID==-1)
          Divider(
            thickness: 1,
            height: 0,
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
                  Text('For\t\t\t\t${company.NAME}',
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

  Widget getTitle(String data, {EdgeInsets? padding, TextAlign? textAlign}) {
    return Padding(
        padding: padding??EdgeInsets.zero,
        child: Text(
          data,
          textAlign: textAlign??TextAlign.left,
          style: TextStyle(
              fontSize: 8,
              font: bold
          ),
        )
    );
  }

  Widget getInfo(String data, {EdgeInsets? padding, TextAlign? textAlign}) {
    return Padding(
        padding: padding??EdgeInsets.zero,
        child: Text(
          data,
          textAlign: textAlign??TextAlign.left,
          style: TextStyle(
              fontSize: 8,
              font: medium
          ),
        )
    );
  }

  void shareFile() {
    XFile xFile =  XFile(file!.path);
    Essential.shareFile([xFile], "Sales Bill :  ${sd.toString()}");
  }

}
