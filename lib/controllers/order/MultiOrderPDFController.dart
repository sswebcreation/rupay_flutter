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
import 'package:rupay/models/order/OrderModel.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:path_provider/path_provider.dart';


class MultiOrderPDFController extends GetxController {
  MultiOrderPDFController();

  final storage = GetStorage();


  late List<OrderModel> orders;
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

  int size = 15;

  @override
  void onInit() {
    super.onInit();
    orders = Get.arguments['orders'];
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
    print(orders.length);
    if (await Essential.requestPermission().isGranted) {
      load = false;
      update();
      final Uint8List pdfBytes = await generatePDF();
      final directory = await getTemporaryDirectory();
      // final directory = await getTemporaryDirectory();

      // Create a new temporary file with a unique name
      // print('${directory?.path}/hello.pdf');
      // print(DateFormat("dd MMM, yyyy").format(sd));
      // print(DateFormat("dd MMM, yyyy").format(ed));
      String name = "US-SOrder-"+DateFormat("dd MMM, yyyy").format(sd)+" - "+DateFormat("dd MMM, yyyy").format(ed);
      file = File('${directory?.path}/${name}.pdf');

      await file!.writeAsBytes(pdfBytes);
    }
    load = true;

    update();
  }

  double op = 0;
  double bp = 0;

  double gop = 0;
  double gbp = 0;

  Future<Uint8List> generatePDF() async {
    op = 0;
    bp = 0;
    gop = 0;
    gbp = 0;
    update();

    final Document doc = Document(pageMode: PdfPageMode.fullscreen);


    // int len = (orders.length/size).ceil();
    int len = orders.length;
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
            return getOrders(len);
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
                    Text('Multi Company Order (Party Wise)',
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
                      "Bill Period: ${DateFormat("dd/MM/yyyy").format(sd)} TO ${DateFormat("dd/MM/yyyy").format(ed)}",
                      style: TextStyle(
                          fontSize: 9,
                          font: regular
                      ),
                    ),
                    SizedBox(
                      width: 10
                    ),
                    Text(
                      "Payment Period: ${DateFormat("dd/MM/yyyy").format(sd)} TO ${DateFormat("dd/MM/yyyy").format(ed)}",
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

  List<Widget> getOrders(int len) {
    return List.generate(len, (index)  {
        int ind = index;
        index = index;
        bool old = true;
        bool nold = true;
        bool sold = false;

        if(ind==0) {
          old = false;
          nold = false;
        }
        else if((orders[index].AccountCode??"").trim()!=(orders[index-1].AccountCode??"").trim()) {
          old = false;
          nold = false;
          op = 0;
          bp = 0;
          update();
        }
        else if((orders[index].DocNumber??"").trim()!=(orders[index-1].DocNumber??"").trim()) {
          nold = false;
          update();
        }
        else {
          if(orders[index].ScreenCode!=orders[index-1].ScreenCode) {
            sold = true;
          }
        }
        print(sold);
        op += orders[index].OrdQuantity1??0;
        bp += orders[index].BalanceQuantity1??0;
        gop += orders[index].OrdQuantity1??0;
        gbp += orders[index].BalanceQuantity1??0;
        update();

        print("op");
        print(op);

        return old ? nold ? sold ?  getScreenOrder(orders[index], index) : getInvoiceOrder(orders[index], index) : getNewOrder(orders[index], index) : getPartyOrder(orders[index], index);
      },
    );
  }


  Widget getPartyOrder(OrderModel order, int index) {
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
                text: order.AccountName,
                style: TextStyle(
                    fontSize: 9,
                    font: bold
                ),
              ),
            ]
          ),
        ),
        Text(
          "Address: "+(order.AccountAddress??""),
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
            0: FlexColumnWidth(1.2), // First column takes up 1/3 of the available width
            1: FlexColumnWidth(0.7),
            2: FlexColumnWidth(1.2),
            3: FlexColumnWidth(1.7),
            4: FlexColumnWidth(1.7),
            5: FlexColumnWidth(1.2),
            6: FlexColumnWidth(1),
            7: FlexColumnWidth(1.2),
            8: FlexColumnWidth(0.8),
            9: FlexColumnWidth(2),
            10: FlexColumnWidth(0.8),
            11: FlexColumnWidth(0.8),
          },
          children: [
            TableRow(
              children: [
                getTitle("Date"),
                getTitle("Doc #"),
                getTitle("Broker"),
                getTitle("Transport Name"),
                getTitle("Screen"),
                getTitle("Ord.\nPcs", textAlign: TextAlign.right),
                getTitle("Rate", textAlign: TextAlign.right),
                getTitle("InvDate", textAlign: TextAlign.right),
                getTitle("Inv\nDoc #", textAlign: TextAlign.right),
                getTitle("Inv\nParty", padding: EdgeInsets.only(left: 5)),
                getTitle("Bal.\nPcs", textAlign: TextAlign.right),
                getTitle("Status", padding: EdgeInsets.only(left: 2)),
              ]
            ),
            TableRow(
              children: [
                // getInfo(order.OrderDate??""),
                getInfo(DateFormat("dd/MM/yyyy").format(DateTime.parse(order.OrderDate??""))),
                getInfo((order.DocNumber??"").trim()),
                getInfo(order.BrokerName??""),
                getInfo(order.TrTransportName??""),
                getInfo(order.ScreenName??""),
                getInfo((order.OrdQuantity1??0).toStringAsFixed(2), textAlign: TextAlign.right),
                getInfo((order.ItemRate??0).toStringAsFixed(2), textAlign: TextAlign.right),
                getInfo(order.InvDate??"", textAlign: TextAlign.right),
                getInfo((order.InvDocNumber??"").trim(), textAlign: TextAlign.right),
                getInfo(order.InvAccountName??"", padding: EdgeInsets.only(left: 5)),
                getInfo((order.BalanceQuantity1??0).toStringAsFixed(2), textAlign: TextAlign.right),
                getInfo(order.Status??"", textAlign: TextAlign.center),
              ]
            )
          ]
        ),
        if(index==orders.length-1)
          Column(
            children: [
              getTotalDesign("Party Total"),
              getTotalDesign("Grand Total"),
            ]
          )
      ]
    );
  }

  Widget getNewOrder(OrderModel order, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(
            thickness: 1,
            height: 0
        ),
        Table(
          border: TableBorder(
            horizontalInside: BorderSide()
          ),
          columnWidths: {
            0: FlexColumnWidth(1.2), // First column takes up 1/3 of the available width
            1: FlexColumnWidth(0.7),
            2: FlexColumnWidth(1.2),
            3: FlexColumnWidth(1.7),
            4: FlexColumnWidth(1.7),
            5: FlexColumnWidth(1.2),
            6: FlexColumnWidth(1),
            7: FlexColumnWidth(1.2),
            8: FlexColumnWidth(0.8),
            9: FlexColumnWidth(2),
            10: FlexColumnWidth(0.8),
            11: FlexColumnWidth(0.8),
          },
          children: [
            TableRow(
              children: [
                // getInfo(order.OrderDate??""),
                getInfo(DateFormat("dd/MM/yyyy").format(DateTime.parse(order.OrderDate??""))),
                getInfo((order.DocNumber??"").trim()),
                getInfo(order.BrokerName??""),
                getInfo(order.TrTransportName??""),
                getInfo(order.ScreenName??""),
                getInfo((order.OrdQuantity1??0).toStringAsFixed(2), textAlign: TextAlign.right),
                getInfo((order.ItemRate??0).toStringAsFixed(2), textAlign: TextAlign.right),
                getInfo(order.InvDate??"", textAlign: TextAlign.right),
                getInfo((order.InvDocNumber??"").trim(), textAlign: TextAlign.right),
                getInfo(order.InvAccountName??"", padding: EdgeInsets.only(left: 5)),
                getInfo((order.BalanceQuantity1??0).toStringAsFixed(2), textAlign: TextAlign.right),
                getInfo(order.Status??"", textAlign: TextAlign.center),
              ]
            )
          ]
        ),
        if(index==orders.length-1)
          Column(
              children: [
                getTotalDesign("Party Total"),
                getTotalDesign("Grand Total"),
              ]
          )
      ]
    );
  }

  Widget getScreenOrder(OrderModel order, int index) {
    return Column(
      children: [
        Divider(
          thickness: 1,
          height: 0
        ),
        Table(
          columnWidths: {
              0: FlexColumnWidth(1.2), // First column takes up 1/3 of the available width
              1: FlexColumnWidth(0.7),
              2: FlexColumnWidth(1.2),
              3: FlexColumnWidth(1.7),
              4: FlexColumnWidth(1.7),
              5: FlexColumnWidth(1.2),
              6: FlexColumnWidth(1),
              7: FlexColumnWidth(1.2),
              8: FlexColumnWidth(0.8),
              9: FlexColumnWidth(2),
              10: FlexColumnWidth(0.8),
              11: FlexColumnWidth(0.8),
            },
          children: [
            TableRow(
                children: [
                  getInfo(""),
                  getInfo(""),
                  getInfo(""),
                  getInfo(""),
                  getInfo(order.ScreenName??""),
                  getInfo((order.OrdQuantity1??0).toStringAsFixed(2), textAlign: TextAlign.right),
                  getInfo((order.ItemRate??0).toStringAsFixed(2), textAlign: TextAlign.right),
                  getInfo(order.InvDate??"", textAlign: TextAlign.right),
                  getInfo((order.InvDocNumber??"").trim(), textAlign: TextAlign.right),
                  getInfo(order.InvAccountName??"", padding: EdgeInsets.only(left: 5)),
                  getInfo((order.BalanceQuantity1??0).toStringAsFixed(2), textAlign: TextAlign.right),
                  getInfo(order.Status??"", textAlign: TextAlign.center),
                ]
            )
          ]
        ),
        if(index==orders.length-1)
          Column(
              children: [
                getTotalDesign("Party Total"),
                getTotalDesign("Grand Total"),
              ]
          )
      ]
    );
  }

  Widget getInvoiceOrder(OrderModel order, int index) {
    return Column(
      children: [
        Table(
          columnWidths: {
              0: FlexColumnWidth(1.2), // First column takes up 1/3 of the available width
              1: FlexColumnWidth(0.7),
              2: FlexColumnWidth(1.2),
              3: FlexColumnWidth(1.7),
              4: FlexColumnWidth(1.7),
              5: FlexColumnWidth(1.2),
              6: FlexColumnWidth(1),
              7: FlexColumnWidth(1.2),
              8: FlexColumnWidth(0.8),
              9: FlexColumnWidth(2),
              10: FlexColumnWidth(0.8),
              11: FlexColumnWidth(0.8),
            },
          children: [
            TableRow(
                children: [
                  getInfo(""),
                  getInfo(""),
                  getInfo(""),
                  getInfo(""),
                  getInfo(""),
                  getInfo(""),
                  getInfo(""),
                  getInfo(order.InvDate??"", textAlign: TextAlign.right),
                  getInfo((order.InvDocNumber??"").trim(), textAlign: TextAlign.right),
                  getInfo(order.InvAccountName??"", padding: EdgeInsets.only(left: 5)),
                  getInfo(""),
                  getInfo(""),
                ]
            )
          ]
        ),
        if(index==orders.length-1)
          Column(
              children: [
                getTotalDesign("Party Total"),
                getTotalDesign("Grand Total"),
              ]
          )
      ]
    );
  }

  Widget getTotalDesign(String title) {
    print("oppppp");
    print(op);
    return Column(
      children: [
        if(title.contains("Party"))
          Divider(
            thickness: 1,
            height: 2
          ),
        Table(
            columnWidths: {
              0: FlexColumnWidth(1.2), // First column takes up 1/3 of the available width
              1: FlexColumnWidth(0.7),
              2: FlexColumnWidth(1.2),
              3: FlexColumnWidth(1.7),
              4: FlexColumnWidth(1.7),
              5: FlexColumnWidth(1.2),
              6: FlexColumnWidth(1),
              7: FlexColumnWidth(1.2),
              8: FlexColumnWidth(0.8),
              9: FlexColumnWidth(2),
              10: FlexColumnWidth(0.8),
              11: FlexColumnWidth(0.8),
            },
            children: [
              title.contains("Party") ?
              TableRow(
                  children: [
                    getTitle(""),
                    getTitle(""),
                    getTitle(""),
                    getTitle(""),
                    getTitle("${title}:", textAlign: TextAlign.right, size: 9.5),
                    getTitle(op.toStringAsFixed(2), textAlign: TextAlign.right),
                    getTitle(""),
                    getTitle(""),
                    getTitle(""),
                    getTitle(""),
                    getTitle(bp.toStringAsFixed(2), textAlign: TextAlign.right),
                    getTitle(""),
                  ]
              )
              : TableRow(
                  children: [
                    getTitle(""),
                    getTitle(""),
                    getTitle(""),
                    getTitle(""),
                    getTitle("${title}:", textAlign: TextAlign.right, size: 9.5),
                    getTitle(gop.toStringAsFixed(2), textAlign: TextAlign.right),
                    getTitle(""),
                    getTitle(""),
                    getTitle(""),
                    getTitle(""),
                    getTitle(gbp.toStringAsFixed(2), textAlign: TextAlign.right),
                    getTitle(""),
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
              fontSize: size??9.5,
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
              fontSize: 8.5,
              font: semiBold
          ),
        )
    );
  }

  void shareFile() {
    XFile xFile =  XFile(file!.path);
    Essential.shareFile([xFile], "order Bill :  ${sd.toString()}");
  }

}
