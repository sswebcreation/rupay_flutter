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
import 'package:rupay/models/billTerm/BillTermModel.dart';
import 'package:rupay/models/company/CompanyModel.dart';
import 'package:rupay/models/lineItem/LineItemModel.dart';
import 'package:rupay/models/sales/SalesModel.dart';
import 'package:rupay/providers/SalesProvider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rupay/services/networking/ApiConstants.dart';
import 'package:rupay/shared/helpers/extensions/StringExtension.dart';


class SingleSalesPDFController extends GetxController {
  SingleSalesPDFController();

  final storage = GetStorage();

  final SalesProvider salesProvider = Get.find();


  // late SalesModel sales;
  // late List<LineItemModel> items;
  // late List<BillTermModel> terms;
  late int id;
  late String entryType;
  late List<SalesModel> sales;
  late bool load;
  File? file;
  final Completer<PDFViewController> controller =
  Completer<PDFViewController>();
  int? pages = 0;
  int? currentPage = 0;
  bool isReady = false;
  String errorMessage = '';

  // late double pcs, cut, mts, rate, amount, taxable;
  late ByteData fontData;
  late Font light, regular, medium, semiBold, bold;
  late CompanyModel company;
  late String type;

  @override
  void onInit() {
    super.onInit();
    type = Get.arguments['type'];
    entryType = Get.arguments?['entryType']??"";
    sales = [];
    if(type=="S") {
      id = Get.arguments['id'];
    }
    else {
      sales = Get.arguments['selected'];
    }
    // pcs = cut = mts = rate = amount = taxable = 0.0;
    load = false;
    // items = [];
    // terms = [];
    company = storage.read("company");
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
    if(type=="S") {
      getSalesByID();
    }
    else {
      if(sales.isNotEmpty) {
        getSales();
      }
    }
  }

  void getSalesByID() {
    salesProvider.singleFetch(storage.read("access"), entryType+id.toString()).then((response) async {
      print(response.toJson());
      if(response.code==1) {
        sales = [];
        sales.add(response.data!);

        update();
        processPDF();

      }
      // else if(response.code==-1) {
      //   await Essential.getNewAccessToken();
      // }
      else {
        Essential.showSnackBar(response.message);
      }
    });
  }

  void getSales() {
    Map<String, String> data = {
      "id" : getSalesID()
    };
    sales = [];

    salesProvider.fetchByColumn(storage.read("access"), ApiConstants.multiple, data).then((response) async {
      if(response.code==1) {
        sales = response.data??[];
      //   print(json.decode(sales.LINEITEM??""));
      //
      //   List<dynamic> temp = json.decode(sales.LINEITEM??"");
      //
      //   for (var element in temp) {
      //     LineItemModel item = LineItemModel.fromJson(element);
      //     pcs += item.QTY1??0;
      //     cut += item.QTY2??0;
      //     mts += item.QTY3??0;
      //     rate += item.ITEMRATE??0;
      //     amount += item.AMOUNT??0;
      //     taxable += item.TAXABLEVALUE??0;
      //     items.add(item);
      //   }
      //
      //
      //   if((sales.BILLTERM??"").isNotEmpty) {
      //     temp = json.decode(sales.BILLTERM ?? "");
      //
      //     for (var element in temp) {
      //       BillTermModel term = BillTermModel.fromJson(element);
      //       terms.add(term);
      //     }
      //
      //     terms.sort((a, b) => (a.Ordinal ?? 0).compareTo(b.Ordinal ?? 0));
      //   }
      //
        update();
      //   print(terms);
        processPDF();

      }
      // else if(response.code==-1) {
      //   await Essential.getNewAccessToken();
      // }
      else {
        Essential.showSnackBar(response.message);
      }
    });
  }

  processPDF() async {
    if (await Essential.requestPermission().isGranted) {
      load = false;
      update();
      final Uint8List pdfBytes = await generatePDF();
      final directory = await getTemporaryDirectory();
      // final directory = await getTemporaryDirectory();

      // Create a new temporary file with a unique name
      String name = ("US-Sales-${sales.length==1 ? sales.first.DOCNUMBER.toString().trim() : DateFormat("dd-MM-yyyy_hh-mm-ss").format(DateTime.now())}").replaceAll("/", "_");

      print(name);
      file = File('${directory?.path}/${name}.pdf');
      // print('${directory?.path}/${sales.DOCNUMBER.toString().trim()}.pdf');
      // file = File('${directory?.path}/${sales.DOCNUMBER.toString().trim()}.pdf');

      await file!.writeAsBytes(pdfBytes);
    }
    load = true;

    update();
  }

  Future<Uint8List> generatePDF() async {
    final Document doc = Document(pageMode: PdfPageMode.fullscreen);

    int cnt = 0;

    for (var element in sales) {

      print(cnt++);
      print(element.toJson());

      List<LineItemModel> items = [];
      List<BillTermModel> terms = [];
      double pcs, cut, mts, rate, amount, taxable;
      pcs = cut = mts = rate = amount = taxable = 0.0;

      List<dynamic> temp = [];

      if((element.LINEITEM??"").isNotEmpty) {
        print("LINE ------------------ ITEMS");
        Essential.logPrint(element.LINEITEM??"");
        print("LINE ---------END--------- ITEMS");
        temp = json.decode(element.LINEITEM ?? "");

        for (var element in temp) {
          LineItemModel item = LineItemModel.fromJson(element);
          pcs += item.QTY1 ?? 0;
          cut += item.QTY2 ?? 0;
          mts += item.QTY3 ?? 0;
          rate += item.ITEMRATE ?? 0;
          amount += item.AMOUNT ?? 0;
          taxable += item.TAXABLEVALUE ?? 0;
          items.add(item);
        }
      }


      if((element.BILLTERM??"").isNotEmpty) {
        temp = json.decode(element.BILLTERM ?? "");

        for (var element in temp) {
          BillTermModel term = BillTermModel.fromJson(element);
          terms.add(term);
        }

        terms.sort((a, b) => (a.Ordinal ?? 0).compareTo(b.Ordinal ?? 0));
      }

      int i = 0;
      int inc = 14;
      int len = items.length>=inc ? inc : items.length;

      while(i<items.length) {
        print("i: ${i}");
        print("len: ${len}");
        doc.addPage(
          MultiPage(
            pageFormat: PdfPageFormat.letter,
            margin: const EdgeInsets.all(20),
            build: (Context context) {
              return [
                Container(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: PdfColors.black
                        )
                    ),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                              children: [
                                getHeader(),
                                Divider(
                                    thickness: 1,
                                    height: 0
                                ),
                                getHeading(element),
                                Divider(
                                    thickness: 1,
                                    height: 0
                                ),
                                getBillDetails(element),
                                Divider(
                                    thickness: 1,
                                    height: 0
                                ),
                                getDeliveryDetails(element),
                                Divider(
                                    thickness: 1,
                                    height: 0
                                ),
                                getAgentDetails(element),
                                Divider(
                                    thickness: 1,
                                    height: 0
                                ),
                                getBillHeading(element),
                                Divider(
                                    thickness: 1,
                                    height: 0
                                ),
                                getItems(items, i, len),
                                Divider(
                                    thickness: 1,
                                    height: 0
                                ),
                                getItemsTotal(pcs, cut, mts, rate, amount, (element.DUEDAYS??30).toInt()),
                                Divider(
                                    thickness: 1,
                                    height: 0
                                ),
                                SizedBox(height: 20),
                                Divider(
                                    thickness: 1,
                                    height: 0
                                ),
                                getPaymentDetails(element, amount, taxable, terms),
                                Divider(
                                    thickness: 1,
                                    height: 0
                                ),
                                getNetAmount(element),
                                Divider(
                                    thickness: 1,
                                    height: 0
                                ),
                              ]
                          ),
                          getFooter()
                        ]
                    )
                )
              ];
            },
          ),
        );
        i+=len;
        len = items.length>=(i+inc)? inc : items.length-(i);
      }
    }

    return doc.save();
  }




  @override
  void dispose() {
    super.dispose();
  }

  Widget getHeader() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text('!! ** Shree Ganeshay Namah ** !!',
              //     style: TextStyle(
              //       font: bold,
              //       fontSize: 8,
              //     )
              // ),
              Flexible(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                          company.NAME??"",
                          style: TextStyle(
                            font: semiBold,
                            fontSize: 26,
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
                      Text(
                          "Email: ${company.EMAIL}, ${company.MOBILE1} (Mo):${company.MOBILE2}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            font: regular,
                            fontSize: 10,
                          )
                      ),
                      if((company.GSTIN??"").isNotEmpty)
                        Text('GSTIN : ${company.GSTIN}',
                          style: TextStyle(
                            font: semiBold,
                            fontSize: 12,
                          )
                      ),
                    ]
                ),
              ),
              // Text('!! ** Shree Ganeshay Namah ** !!',
              //     style: TextStyle(
              //       font: bold,
              //       fontSize: 8,
              //     )
              // )
            ]
        )
    );
  }

  Widget getFooter() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('TERMS & CONDITIONS',
                          style: TextStyle(
                            font: semiBold,
                            fontSize: 14,
                          )
                      ),

                      Text(company.TNC??"",
                          style: TextStyle(
                            font: regular,
                            fontSize: 10,
                          )
                      ),
                      // Text('1.\t\t24% Interest will be charge from due date.\n2.\t\tYour risk & responsibility ceases after the goods dispatched from our shop.\n3.\t\tSubject to SURAT Jurisdiction Only.',
                      //   style: TextStyle(
                      //     font: regular,
                      //     fontSize: 10,
                      //   )
                      // ),
                    ]
                ),
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

  Widget getHeading(SalesModel sales) {
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
                "Place of Supply - ${sales.StateOfSupply} - ${sales.StateName}",
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

  Widget getBillDetails(SalesModel sales) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Table(
        columnWidths: {
          0: const FlexColumnWidth(5), 
          1: const FlexColumnWidth(3), 
        },
        children: [
          TableRow(
            children: [
              getLeftBillDetails(sales),
              getRightBillDetails(sales),
            ],
          ),
        ]
      )
    );
  }

  Widget getLeftBillDetails(SalesModel sales) {
    print(sales.toJson());
    return Container(
        padding: const EdgeInsets.only(right: 10, top: 5, bottom: 5),
      decoration: const BoxDecoration(
        border: Border(right: BorderSide(color: PdfColors.black, width: 0.5))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
            Text(
                "Billed to (Customer):",
                textAlign: TextAlign.center,
                style: TextStyle(
                  font: regular,
                  fontSize: 10,
                )
            ),
            Text(
              sales.ACCOUNTNAME??"",
              textAlign: TextAlign.center,
              style: TextStyle(
                font: semiBold,
                fontSize: 12,
              )
            ),
            Text(
              "${sales.ADD1??""}${(sales.ADD1??"").isNotEmpty && ((sales.ADD1??"").endsWith(", ") || (sales.ADD1??"").endsWith(",")) ? ", " : ""}${sales.ADD2??""}, ${sales.CITY??""} - ${sales.PINCODE??""}",
              textAlign: TextAlign.center,
              style: TextStyle(
                font: regular,
                fontSize: 10,
              )
            ),
            if((sales.GSTIN??"").isNotEmpty)
              Text(
                "GSTIN: ${sales.GSTIN??""}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  font: semiBold,
                  fontSize: 12,
                )
              ),
          ]
      )
    );
  }

  Widget getRightBillDetails(SalesModel sales) {
    return Container(
        padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
      decoration: const BoxDecoration(
          border: Border(left: BorderSide(color: PdfColors.black, width: 0.5))
      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            getInfoCombo("Invoice No.", (sales.DOCNUMBER??"").trim()),
            
            getInfoCombo("Invoice Date", DateFormat("dd-MM-yyyy").format(DateTime.parse(sales.TXNDATE??""))),
            
            getInfoCombo("Challan No.", (sales.DOCNUMBER??"").trim()),
            
            getInfoCombo("Due Date", DateFormat("dd-MM-yyyy").format(DateTime.parse(sales.TXNDATE??"").add(Duration(days: (sales.DUEDAYS??0).toInt())))),

            if((sales.EWayBillNO??"").trim().isNotEmpty)
              getInfoCombo("EWay Bill No.", (sales.EWayBillNO??"").trim()),
          ]
      )
    );
  }

  Widget getDeliveryDetails(SalesModel sales) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Table(
            columnWidths: {
              0: const FlexColumnWidth(5), 
              1: const FlexColumnWidth(3), 
            },
            children: [
              TableRow(
                children: [
                  getLeftDeliveryDetails(sales),
                  getRightDeliveryDetails(sales),
                ],
              ),
            ]
        )
    );
  }

  Widget getLeftDeliveryDetails(SalesModel sales) {
    print(sales.toJson());
    return Container(
        padding: const EdgeInsets.only(right: 10, top: 5, bottom: 5),
        decoration: const BoxDecoration(
            border: Border(right: BorderSide(color: PdfColors.black, width: 0.5))
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                  "Shipped to (Customer):",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    font: regular,
                    fontSize: 10,
                  )
              ),
              Text(
                  sales.DNAME??"",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    font: semiBold,
                    fontSize: 12,
                  )
              ),
              Text(
                  "${sales.DADD1??""}${(sales.DADD1??"").isNotEmpty && ((sales.DADD1??"").endsWith(", ") || (sales.DADD1??"").endsWith(",")) ? ", " : ""}${sales.DADD2??""}, ${sales.DCITY??""} - ${sales.DPINCODE??""}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    font: regular,
                    fontSize: 10,
                  )
              ),
              if((sales.DGSTIN??"").isNotEmpty)
                Text(
                    "GSTIN: ${sales.DGSTIN??""}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      font: semiBold,
                      fontSize: 12,
                    )
                ),
            ]
        )
    );
  }

  Widget getRightDeliveryDetails(SalesModel sales) {
    return Container(
        padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
        decoration: const BoxDecoration(
            border: Border(left: BorderSide(color: PdfColors.black, width: 0.5))
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              getInfoCombo("Transport", (sales.TRANSPORT??"").trim(), flex1: 1, flex2: 2),
              
              getInfoCombo("Station", sales.DCITY??"", flex1: 1, flex2: 2),
              
              getInfoCombo("LR No.", (sales.LRNO??"").trim(), flex1: 1, flex2: 2),
              
              getInfoCombo("LR Date", (sales.LRDate??""), flex1: 1, flex2: 2),
              
              getInfoCombo("Case No", "${(sales.DOCNUMBER??"").trim()} X ${(sales.NoOfParcel??"").trim()}", flex1: 1, flex2: 2),
            ]
        )
    );
  }

  Widget getAgentDetails(SalesModel sales) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Table(
            columnWidths: {
              0: const FlexColumnWidth(5), 
              1: const FlexColumnWidth(3), 
            },
            children: [
              TableRow(
                children: [
                  Container(
                    padding: const EdgeInsets.only(right: 10, top: 5, bottom: 5),
                    decoration: const BoxDecoration(
                        border: Border(right: BorderSide(color: PdfColors.black, width: 0.5))
                    ),
                    child: getInfoCombo("Agent", sales.BROKERNAME??"", flex1: 1, flex2: 7),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
                    decoration: const BoxDecoration(
                        border: Border(left: BorderSide(color: PdfColors.black, width: 0.5))
                    ),
                    child: getInfoCombo("Haste", "", flex1: 1, flex2: 4),
                  ),
                ],
              ),
            ]
        )
    );
  }

  Widget getBillHeading(SalesModel sales) {
    int i = 0;
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Table(
            columnWidths: {
              i++: const FlexColumnWidth(1),
              i++: const FlexColumnWidth(13),
              i++: const FlexColumnWidth(2),
              if((company.Q1??"").isNotEmpty)
                i++: const FlexColumnWidth(2),
              if((company.Q2??"").isNotEmpty)
                i++: const FlexColumnWidth(2),
              if((company.Q3??"").isNotEmpty)
                i++: const FlexColumnWidth(2),
              i++: const FlexColumnWidth(2),
              i++: const FlexColumnWidth(3),
            },
            border: const TableBorder(horizontalInside: BorderSide(color: PdfColors.black), verticalInside: BorderSide(color: PdfColors.black)),
            children: [
              TableRow(
                children: [
                  Container(
                    padding: const EdgeInsets.only( left: 2, right: 2),
                    alignment: Alignment.center,
                    child: getTitle("Sr"),
                  ),
                  Container(
                    padding: const EdgeInsets.only( left: 5, right: 5),
                    alignment: Alignment.centerLeft,
                    child: getTitle("Description of Goods"),
                  ),
                  Container(
                    padding: const EdgeInsets.only( left: 2, right: 2),
                    alignment: Alignment.center,
                    child: getTitle("HSN"),
                  ),
                  if((company.Q1??"").isNotEmpty)
                    Container(
                      padding: const EdgeInsets.only( left: 2, right: 2),
                      alignment: Alignment.center,
                      child: getTitle((company.Q1??"").toUpperCase()),
                    ),
                  if((company.Q2??"").isNotEmpty)
                    Container(
                      padding: const EdgeInsets.only( left: 2, right: 2),
                      alignment: Alignment.center,
                      child: getTitle((company.Q2??"").toUpperCase()),
                    ),
                  if((company.Q3??"").isNotEmpty)
                    Container(
                      padding: const EdgeInsets.only( left: 2, right: 2),
                      alignment: Alignment.center,
                      child: getTitle((company.Q3??"").toUpperCase()),
                    ),
                  Container(
                    padding: const EdgeInsets.only( left: 2, right: 2),
                    alignment: Alignment.center,
                    child: getTitle("Rate"),
                  ),
                  Container(
                    padding: const EdgeInsets.only( left: 2, right: 2),
                    alignment: Alignment.center,
                    child: getTitle("Amount Rs."),
                  ),
                ],
              ),
            ]
        )
    );
  }

  Widget getItems(List<LineItemModel> items, int start, int len) {
    print("start");
    print(start);
    print(len);
    int i = 0;
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Table(
          columnWidths: {
            i++: const FlexColumnWidth(1),
            i++: const FlexColumnWidth(13),
            i++: const FlexColumnWidth(2),
            if((company.Q1??"").isNotEmpty)
              i++: const FlexColumnWidth(2),
            if((company.Q2??"").isNotEmpty)
              i++: const FlexColumnWidth(2),
            if((company.Q3??"").isNotEmpty)
              i++: const FlexColumnWidth(2),
            i++: const FlexColumnWidth(2),
            i++: const FlexColumnWidth(3),
          },
          border: const TableBorder(verticalInside: BorderSide(color: PdfColors.black)),
          children: List.generate(len, (index) => getLineItem(start+index, items[start+index]))
        )
    );
  }

  TableRow getLineItem(int index, LineItemModel lineItem) {
    print(lineItem.toJson());
    return TableRow(
      children: [
        Container(
          padding: const EdgeInsets.only( left: 2, right: 2),
          alignment: Alignment.center,
          decoration: const BoxDecoration(
          ),
          child: getTitle((index+1).toString()),
        ),
        Container(
          padding: const EdgeInsets.only(left: 5, ),
          alignment: Alignment.centerLeft,
          child: getInfo("${lineItem.ITEMNAME??""} ${lineItem.Remarks??""}"),
        ),
        Container(
          padding: const EdgeInsets.only( left: 2, right: 2),
          alignment: Alignment.center,
          child: getTitle(lineItem.HSN??""),
        ),
        if((company.Q1??"").isNotEmpty)
          Container(
            padding: const EdgeInsets.only( left: 2, right: 2),
            alignment: Alignment.center,
            child: getTitle((lineItem.QTY1??0).toStringAsFixed(2)),
          ),

        if((company.Q2??"").isNotEmpty)
          Container(
            padding: const EdgeInsets.only( left: 2, right: 2),
            alignment: Alignment.center,
            child: getTitle((lineItem.QTY2??0).toStringAsFixed(2)),
          ),

        if((company.Q3??"").isNotEmpty)
          Container(
            padding: const EdgeInsets.only( left: 2, right: 2),
            alignment: Alignment.center,
            child: getTitle((lineItem.QTY3??0).toStringAsFixed(2)),
          ),
        Container(
          padding: const EdgeInsets.only( left: 2, right: 2),
          alignment: Alignment.center,
          child: getTitle((lineItem.ITEMRATE??0).toStringAsFixed(2)),
        ),
        Container(
          padding: const EdgeInsets.only( left: 2, right: 2),
          alignment: Alignment.center,
          child: getTitle((lineItem.AMOUNT??0).toStringAsFixed(2)),
        ),
      ],
    );
  }

  Widget getItemsTotal(double pcs, double cut, double mts, double rate, double amount, int due) {
    int i = 0;
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Table(
            columnWidths: {
              i++: const FlexColumnWidth(16),
              if((company.Q1??"").isNotEmpty)
                i++: const FlexColumnWidth(2),
              if((company.Q2??"").isNotEmpty)
                i++: const FlexColumnWidth(2),
              if((company.Q3??"").isNotEmpty)
                i++: const FlexColumnWidth(2),
              i++: const FlexColumnWidth(2),
              i++: const FlexColumnWidth(3)
            },
            border: const TableBorder(horizontalInside: BorderSide(color: PdfColors.black), verticalInside: BorderSide(color: PdfColors.black)),
            children: [
              TableRow(
                  children: [
                    Row(
                        children: [
                          Flexible(
                              flex: 3,
                              fit: FlexFit.tight,
                              child: getInfo("Payment within ${due} days", padding: const EdgeInsets.symmetric(vertical: 5))
                          ),
                          Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                              child: getTitle("Total", padding: const EdgeInsets.symmetric(vertical: 5))
                          )
                        ]
                    ),

                    if((company.Q1??"").isNotEmpty)
                      Align(
                          alignment: Alignment.center,
                          child: getTitle(pcs.toStringAsFixed(2), padding: const EdgeInsets.symmetric(vertical: 5))
                      ),
                    if((company.Q2??"").isNotEmpty)
                      Align(
                          alignment: Alignment.center,
                          child: getTitle(cut.toStringAsFixed(2), padding: const EdgeInsets.symmetric(vertical: 5))
                      ),
                    if((company.Q3??"").isNotEmpty)
                      Align(
                          alignment: Alignment.center,
                          child: getTitle(mts.toStringAsFixed(2), padding: const EdgeInsets.symmetric(vertical: 5))
                      ),
                    Align(
                        alignment: Alignment.center,
                        child: getTitle(rate.toStringAsFixed(2), padding: const EdgeInsets.symmetric(vertical: 5))
                    ),
                    Align(
                        alignment: Alignment.center,
                        child: getTitle(amount.toStringAsFixed(2), padding: const EdgeInsets.symmetric(vertical: 5))
                    ),

                  ]
              )
            ]
        )
    );
  }

  Widget getPaymentDetails(SalesModel sales, double amount,  double taxable, List<BillTermModel> terms) {
    return Table(
        columnWidths: {
          0: const FlexColumnWidth(5), 
          1: const FlexColumnWidth(3), 
        },
        border: const TableBorder(verticalInside: BorderSide(color: PdfColors.black)),
        children: [
          TableRow(
            children: [
              getBankDetails(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  getTotalDesign(amount),
                  getBillTerm(terms),
                  getTaxableDesign(sales, taxable)
                ]
              )
            ]
          ),
        ]
    );
  }

  // Widget getPaymentDetails1(double amount, List<BillTermModel> terms) {
  //   return Table(
  //       columnWidths: {
  //         0: const FlexColumnWidth(5),
  //         1: const FlexColumnWidth(3),
  //       },
  //       border: const TableBorder(verticalInside: BorderSide(color: PdfColors.black)),
  //       children: [
  //         TableRow(
  //           children: [
  //             getBankDetails(),
  //             getTotalDesign(amount)
  //           ]
  //         ),
  //         TableRow(
  //           children: [
  //             getBillTerm(terms),
  //             getTaxableDesign()
  //           ]
  //         )
  //       ]
  //   );
  // }

  getBankDetails() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            getUnderlinedInfo("Bank Details for RTGS / NEFT :"),
            
            getTitle("BANK : ${company.BANK1NAME}"),
            SizedBox(
                height: 5
            ),
            getTitle("IFSC CODE : ${company.BANK1IFSC}"),
            SizedBox(
                height: 5
            ),
            getTitle("ACCOUNT NO : ${company.BANK1ACNO}"),
          ]
      )
    );
  }

  getBillTerm(List<BillTermModel> terms) {
    return ListView.builder(
      itemCount: terms.length,
      padding: EdgeInsets.symmetric(horizontal: 5),
      // itemCount: sales.length,
      itemBuilder: (context, index) {
        return getTermDesign(terms[index]);
      },
    );
  }

  getTotalDesign(double amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
      child: Column(
        children: [
          getInfoComboBold("Sub Total", amount.toStringAsFixed(2), crossAxisAlignment: CrossAxisAlignment.end, textAlign: TextAlign.right),
        ]
      )
    );
  }

  getTermDesign(BillTermModel term) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
        child: Column(
            children: [
              getSInfoComboBold((term.TERMDESC??"")+((term.Percentage??0)!=0 ? "(${term.Percentage??0}%)" : ""), (term.Amount??0).toStringAsFixed(2), crossAxisAlignment: CrossAxisAlignment.end, textAlign: TextAlign.right),
            ]
        )
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: RichText(
        text: TextSpan(
          text: term.TERMDESC??"",
          style: TextStyle(
              fontSize: 10,
              font: bold
          ),
          children: [
            if((term.Percentage??0)!=0)
              TextSpan(
                text: "(${term.Percentage??0}%)"
              ),
            TextSpan(
              text: ":  ${term.Amount??""}"
            )
          ]
        )
      )
    );
  }

  getTaxableDesign(SalesModel sales, double taxable) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        children: [
          if(taxable>0)
            getInfoComboBold("Taxable Value", taxable.toStringAsFixed(2), crossAxisAlignment: CrossAxisAlignment.end, textAlign: TextAlign.right),

          if((taxable>0) && (sales.GST??0)>0)
            SizedBox(
                height: 10
            ),

          if((sales.GST??0)>0)
            Align(
              alignment: Alignment.centerRight,
              child: getInfo("ADD IGST   5.000 %        ${sales.GST}")
            )
        ]
      )
    );
  }

  Widget getNetAmount(SalesModel sales) {
    return Table(
        columnWidths: {
          0: const FlexColumnWidth(5), 
          1: const FlexColumnWidth(3), 
        },
        border: const TableBorder(verticalInside: BorderSide(color: PdfColors.black)),
        children: [
          TableRow(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: RichText(
                  text: TextSpan(
                    text: "Rupees.\t\t",
                    style: TextStyle(
                      fontSize: 12,
                      font: medium
                    ),
                    children: [
                      TextSpan(
                        text: Essential.getRupeeWords((sales.NETAMOUNT??0).toInt()).toTitleCase(),
                        style: TextStyle(
                            fontSize: 12,
                            font: semiBold
                        ),
                      )
                    ]
                  )
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: getInfoComboBold("Net Amount Rs.", (sales.NETAMOUNT??0).toStringAsFixed(2), crossAxisAlignment: CrossAxisAlignment.end, textAlign: TextAlign.right, mediator: ""),
              ),
            ]
          ),
        ]
    );
  }

  Widget getTitle(String data, {EdgeInsets? padding}) {
    return Padding(
        padding: padding??EdgeInsets.zero,
        child: Text(
          data,
          style: TextStyle(
              fontSize: 8,
              font: bold
          ),
        )
    );
  }

  Widget getInfo(String data, {EdgeInsets? padding}) {
    return Padding(
        padding: padding??EdgeInsets.zero,
        child: Text(
          data,
          style: TextStyle(
              fontSize: 8,
              font: semiBold
          ),
        )
    );
  }

  Widget getUnderlinedInfo(String data, {EdgeInsets? padding}) {
    return Padding(
        padding: padding??EdgeInsets.zero,
        child: Text(
          data,
          style: TextStyle(
              fontSize: 10,
              decoration: TextDecoration.underline,
              font: bold
          ),
        )
    );
  }

  Widget getInfoCombo(String title, String data, {int? flex1, int? flex2, CrossAxisAlignment? crossAxisAlignment, TextAlign? textAlign, String? mediator}) {
    return Row(
        crossAxisAlignment: crossAxisAlignment??CrossAxisAlignment.start,
        children: [
          Flexible(
              flex: flex1??4,
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
                font: semiBold
            ),
          ),
          Flexible(
              flex: flex2??5,
              fit: FlexFit.tight,
              child: Text(
                data,
                style: TextStyle(
                    fontSize: 12,
                    font: semiBold
                ),
              )
          )
        ]
    );
  }

  Widget getInfoComboBold(String title, String data, {CrossAxisAlignment? crossAxisAlignment, TextAlign? textAlign, String? mediator}) {
    return Row(
        crossAxisAlignment: crossAxisAlignment??CrossAxisAlignment.start,
        children: [
          Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Text(
                title,
                textAlign: textAlign,
                style: TextStyle(
                    fontSize: 10,
                    font: bold
                ),
              )
          ),
          Text(
            mediator??" : ",
            style: TextStyle(
                fontSize: 10,
                font: bold
            ),
          ),
          Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Text(
                data,
                textAlign: textAlign,
                style: TextStyle(
                    fontSize: 10,
                    font: bold
                ),
              )
          )
        ]
    );
  }

  Widget getSInfoComboBold(String title, String data, {CrossAxisAlignment? crossAxisAlignment, TextAlign? textAlign, String? mediator}) {
    return Row(
        crossAxisAlignment: crossAxisAlignment??CrossAxisAlignment.start,
        children: [
          Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Text(
                title,
                textAlign: textAlign,
                style: TextStyle(
                    fontSize: 8,
                    font: bold
                ),
              )
          ),
          Text(
            mediator??" : ",
            style: TextStyle(
                fontSize: 8,
                font: bold
            ),
          ),
          Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Text(
                data,
                textAlign: textAlign,
                style: TextStyle(
                    fontSize: 8,
                    font: bold
                ),
              )
          )
        ]
    );
  }



  void shareFile() {
    XFile xFile =  XFile(file!.path);
    Essential.shareFile([xFile], "Sales Bill :  ${sales.length==1 ? sales.first.DOCNUMBER.toString().trim() : DateTime.now().toString()}");
  }

  String getSalesID() {
    String id = "";
    for (var element in sales) {
      id+=",${element.ID}";
    }
    return id.substring(1);
  }

}
