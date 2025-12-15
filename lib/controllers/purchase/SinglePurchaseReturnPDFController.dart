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
import 'package:rupay/models/purchase/PurchaseModel.dart';
import 'package:rupay/providers/PurchaseProvider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rupay/providers/PurchaseReturnProvider.dart';
import 'package:rupay/services/networking/ApiConstants.dart';
import 'package:rupay/shared/helpers/extensions/StringExtension.dart';


class SinglePurchaseReturnPDFController extends GetxController {
  SinglePurchaseReturnPDFController();

  final storage = GetStorage();

  final PurchaseReturnProvider purchaseReturnProvider = Get.find();


  // late PurchaseModel purchase;
  // late List<LineItemModel> items;
  // late List<BillTermModel> terms;
  late int id;
  late List<PurchaseModel> purchase;
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
    purchase = [];
    if(type=="S") {
      id = Get.arguments['id'];
    }
    else {
      purchase = Get.arguments['selected'];
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
      getPurchaseByID();
    }
    else {
      if(purchase.isNotEmpty) {
        getPurchase();
      }
    }
  }

  void getPurchaseByID() {
    purchaseReturnProvider.singleFetch(storage.read("access"), id.toString()).then((response) async {
      print(response.toJson());
      if(response.code==1) {
        purchase = [];
        purchase.add(response.data!);

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

  void getPurchase() {
    Map<String, String> data = {
      "id" : getPurchaseID()
    };
    purchase = [];

    purchaseReturnProvider.fetchByColumn(storage.read("access"), ApiConstants.multiple, data).then((response) async {
      if(response.code==1) {
        purchase = response.data??[];
      //   print(json.decode(purchase.LINEITEM??""));
      //
      //   List<dynamic> temp = json.decode(purchase.LINEITEM??"");
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
      //   if((purchase.BILLTERM??"").isNotEmpty) {
      //     temp = json.decode(purchase.BILLTERM ?? "");
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
      String name = "US-Purchase-${purchase.length==1 ? purchase.first.DOCNUMBER.toString().trim() : DateFormat("dd-MM-yyyy_hh-mm-ss").format(DateTime.now())}";
      file = File('${directory?.path}/${name}.pdf');
      // print('${directory?.path}/${purchase.DOCNUMBER.toString().trim()}.pdf');
      // file = File('${directory?.path}/${purchase.DOCNUMBER.toString().trim()}.pdf');

      await file!.writeAsBytes(pdfBytes);
    }
    load = true;

    update();
  }

  Future<Uint8List> generatePDF() async {
    final Document doc = Document(pageMode: PdfPageMode.fullscreen);

    int cnt = 0;

    for (var element in purchase) {

      print(cnt++);
      print(element.toJson());

      List<LineItemModel> items = [];
      List<BillTermModel> terms = [];
      double pcs, cut, mts, rate, amount, taxable;
      pcs = cut = mts = rate = amount = taxable = 0.0;

      List<dynamic> temp = [];

      if((element.LINEITEM??"").isNotEmpty) {
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
                                getItemsTotal(
                                    pcs, cut, mts, rate, amount, (element
                                    .DUEDAYS ?? 30).toInt()),
                                Divider(
                                    thickness: 1,
                                    height: 0
                                ),
                                SizedBox(height: 20),
                                Divider(
                                    thickness: 1,
                                    height: 0
                                ),
                                getPaymentDetails(
                                    element, amount, taxable, terms),
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('!! ** Shree Ganeshay Namah ** !!',
                  style: TextStyle(
                    font: bold,
                    fontSize: 8,
                  )
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
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
              ),
              Text('!! ** Shree Ganeshay Namah ** !!',
                  style: TextStyle(
                    font: bold,
                    fontSize: 8,
                  )
              )
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

  Widget getHeading(PurchaseModel purchase) {
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
                "PURCHASE RETURN/DEBIT NOTE",
                textAlign: TextAlign.center,
                style: TextStyle(
                  font: semiBold,
                  fontSize: 12,
                )
            ),
          ),
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Text(
                "Place of Supply - ${purchase.StateOfSupply} - ${purchase.STATENAME}",
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

  Widget getBillDetails(PurchaseModel purchase) {
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
              getLeftBillDetails(purchase),
              getRightBillDetails(purchase),
            ],
          ),
        ]
      )
    );
  }

  Widget getLeftBillDetails(PurchaseModel purchase) {
    print(purchase.toJson());
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
              purchase.ACCOUNTNAME??"",
              textAlign: TextAlign.center,
              style: TextStyle(
                font: semiBold,
                fontSize: 12,
              )
            ),
            Text(
              "${purchase.ADD1??""}${(purchase.ADD1??"").isNotEmpty && ((purchase.ADD1??"").endsWith(", ") || (purchase.ADD1??"").endsWith(",")) ? ", " : ""}${purchase.ADD2??""}, ${purchase.CITY??""} - ${purchase.PINCODE??""}",
              textAlign: TextAlign.center,
              style: TextStyle(
                font: regular,
                fontSize: 10,
              )
            ),
            if((purchase.GSTIN??"").isNotEmpty)
              Text(
                "GSTIN: ${purchase.GSTIN??""}",
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

  Widget getRightBillDetails(PurchaseModel purchase) {
    return Container(
        padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
      decoration: const BoxDecoration(
          border: Border(left: BorderSide(color: PdfColors.black, width: 0.5))
      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            getInfoCombo("Note No.", (purchase.DOCNUMBER??"").trim()),
            SizedBox(
                height: 2
            ),
            getInfoCombo("Note Date", DateFormat("dd-MM-yyyy").format(DateTime.parse(purchase.TXNDATE??""))),
            SizedBox(
                height: 2
            ),
            getInfoCombo("Original Bill No.", (purchase.ORIGINALBILLNO??"").trim()),
            SizedBox(
                height: 2
            ),
            getInfoCombo("Original Bill Date", (purchase.ORIGINALBILLDT??"").isNotEmpty ? DateFormat("dd-MM-yyyy").format(DateTime.parse(purchase.ORIGINALBILLDT??"")) : ""),
          ]
      )
    );
  }

  Widget getDeliveryDetails(PurchaseModel purchase) {
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
                  getLeftDeliveryDetails(purchase),
                  getRightDeliveryDetails(purchase),
                ],
              ),
            ]
        )
    );
  }

  Widget getLeftDeliveryDetails(PurchaseModel purchase) {
    print(purchase.toJson());
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
                  purchase.DNAME??"",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    font: semiBold,
                    fontSize: 12,
                  )
              ),
              Text(
                  "${purchase.DADD1??""}${(purchase.DADD1??"").isNotEmpty && ((purchase.DADD1??"").endsWith(", ") || (purchase.DADD1??"").endsWith(",")) ? ", " : ""}${purchase.DADD2??""}, ${purchase.DCITY??""} - ${purchase.DPINCODE??""}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    font: regular,
                    fontSize: 10,
                  )
              ),
              if((purchase.DGSTIN??"").isNotEmpty)
                Text(
                  "GSTIN: ${purchase.DGSTIN??""}",
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

  Widget getRightDeliveryDetails(PurchaseModel purchase) {
    return Container(
        padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
        decoration: const BoxDecoration(
            border: Border(left: BorderSide(color: PdfColors.black, width: 0.5))
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              getInfoCombo("Station", purchase.DCITY??"", flex1: 1, flex2: 2),
              SizedBox(
                  height: 2
              ),
              getInfoCombo("Case No", "${(purchase.DOCNUMBER??"").trim()}", flex1: 1, flex2: 2),
            ]
        )
    );
  }

  Widget getAgentDetails(PurchaseModel purchase) {
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
                    child: getInfoCombo("Agent", purchase.BROKERNAME??"", flex1: 1, flex2: 7),
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

  Widget getBillHeading(PurchaseModel purchase) {
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
          padding: const EdgeInsets.only(left: 5,),
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

  Widget getPaymentDetails(PurchaseModel purchase, double amount,  double taxable, List<BillTermModel> terms) {
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
                  getTaxableDesign(purchase, taxable)
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
            SizedBox(
                height: 2
            ),
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
      // itemCount: purchase.length,
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

  getTaxableDesign(PurchaseModel purchase, double taxable) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        children: [
          if(taxable>0)
            getInfoComboBold("Taxable Value", taxable.toStringAsFixed(2), crossAxisAlignment: CrossAxisAlignment.end, textAlign: TextAlign.right),

          if((taxable>0) && (purchase.GST??0)>0)
            SizedBox(
              height: 10
            ),

          if((purchase.GST??0)>0)
            Align(
              alignment: Alignment.centerRight,
              child: getInfo("ADD IGST   5.000 %        ${purchase.GST}")
            )
        ]
      )
    );
  }

  Widget getNetAmount(PurchaseModel purchase) {
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
                        text: Essential.getRupeeWords((purchase.NETAMOUNT??0).toInt()).toTitleCase(),
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
                child: getInfoComboBold("Net Amount Rs.", (purchase.NETAMOUNT??0).toStringAsFixed(2), crossAxisAlignment: CrossAxisAlignment.end, textAlign: TextAlign.right, mediator: ""),
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
    Essential.shareFile([xFile], "Purchase Bill :  ${purchase.length==1 ? purchase.first.DOCNUMBER.toString().trim() : DateTime.now().toString()}");
  }

  String getPurchaseID() {
    String id = "";
    for (var element in purchase) {
      id+=",${element.ID}";
    }
    return id.substring(1);
  }

}
