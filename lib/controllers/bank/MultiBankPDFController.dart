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
import 'package:rupay/models/bank/BankModel.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:path_provider/path_provider.dart';


class MultiBankPDFController extends GetxController {
  MultiBankPDFController();

  final storage = GetStorage();


  late CompanyModel company;

  // late BankModel bank;
  late List<BankModel> banks;
  late int id;
  late bool load;
  File? file;
  final Completer<PDFViewController> controller =
  Completer<PDFViewController>();
  int? pages = 0;
  int? currentPage = 0;
  bool isReady = false;
  String errorMessage = '';

  late ByteData fontData;
  late Font light, regular, medium, semiBold, bold;
  late DateTime sd, ed;
  int size = 35;

  @override
  void onInit() {
    super.onInit();
    banks = Get.arguments['bank'];
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
    String name = "US-Bank-"+DateFormat("dd MMM, yyyy").format(sd)+" - "+DateFormat("dd MMM, yyyy").format(ed);
    file = File('${directory?.path}/${name}.pdf');

    await file!.writeAsBytes(pdfBytes);
    }
    load = true;

    update();
  }

  double debit = 0;
  double credit = 0;
  double balance = 0;

  Future<Uint8List> generatePDF() async {
    debit = 0;
    credit = 0;
    balance = 0;
    update();

    final Document doc = Document(pageMode: PdfPageMode.fullscreen);


    // print(bank.last.DOCNUMBER);
    // print(bank.length);
    // print(bank.length/size);
    // print((bank.length/size).ceil());
    // int len = (banks.length/size).ceil();
    int len = banks.length;
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
            return getBanks(len);
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
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(),
                    Text('Bank Register - Partywise Without Item Detail',
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
              Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Daybooks: bank INVOICE B2B (GSTIN CUSTOMERS)",
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
                      "Type of Supply: ALL",
                      style: TextStyle(
                          fontSize: 9,
                          font: regular
                      ),
                    ),
                    Text(
                      "Invoice Type: ALL",
                      style: TextStyle(
                          fontSize: 9,
                          font: regular
                      ),
                    )
                  ]
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Invoice Sub Type: ALL",
                  style: TextStyle(
                    fontSize: 9,
                    font: regular
                  ),
                )
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

  List<Widget> getBanks(int len) {
    return List.generate(len, (index)  {
      int ind = index;
      index = index;
      bool old = true;
      bool total = false;
      if(ind==0) {
        old = false;
      }

      if(index==0) {
        print("hello0");
        old = false;
      }
      else if(banks[index].ACCOUNTNAME!=banks[index-1].ACCOUNTNAME) {
        print("hello1");

        total = true;
        old = false;
      }
      return old ? getBank(banks[index], index) : getPartyBank(banks[index], index, total);
    },);
  }

  // Widget getTableInfo() {
  //   return Table(
  //     children: List.generate(bank.length, (index) => () {
  //       return TableRow(children: children)
  //     })
  //   );
  // }
  //
  // Widget getTableInfo() {
  //   return Table(
  //     children: List.generate(bank.length, (index) => () {
  //       return TableRow(children: children)
  //     })
  //   );
  // }

  Widget getPartyBank(BankModel bank, int index, bool total) {
    if(total==false) {
      if (bank.Amount?.isNegative == true) {
        balance += (bank.Amount ?? 0).abs();
        debit += (bank.Amount ?? 0).abs();
      }
      else {
        balance -= (bank.Amount ?? 0).abs();
        credit += (bank.Amount ?? 0).abs();
      }
      update();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(index!=0 && total)
          getTotalDesign(bank),
        RichText(
          text: TextSpan(
            text: "Party: ",
            style: TextStyle(
              fontSize: 9,
              font: regular
            ),
            children: [
              TextSpan(
                text: bank.ACCOUNTNAME,
                style: TextStyle(
                    fontSize: 9,
                    font: bold
                ),
              ),
            ]
          ),
        ),
        // Text(
        //   "Address: ${bank.ADD1??""}${(bank.ADD1??"").isNotEmpty && ((bank.ADD1??"").endsWith(", ") || (bank.ADD1??"").endsWith(",")) ? ", " : ""}${bank.ADD2??""}, ${bank.CITY??""} - ${bank.PINCODE??""}",
        //   style: TextStyle(
        //     fontSize: 9,
        //     font: regular
        //   ),
        // ),
        Divider(
          thickness: 1,
          height: 0
        ),
        Table(
          border: TableBorder(
            horizontalInside: BorderSide()
          ),
          columnWidths: {
            0: FlexColumnWidth(1.1), // First column takes up 1/3 of the available width
            1: FlexColumnWidth(0.4),
            2: FlexColumnWidth(2.5),
            3: FlexColumnWidth(2.7),
            4: FlexColumnWidth(0.7),
            5: FlexColumnWidth(1.2),
            6: FlexColumnWidth(1),
            7: FlexColumnWidth(1.2),
          },
          children: [
            TableRow(
              children: [
                getTitle("Date"),
                getTitle("Doc #"),
                getTitle("Remarks"),
                getTitle("Contra Account"),
                getTitle("Chq No."),
                getTitle("Debit.", textAlign: TextAlign.right),
                getTitle("Credit", textAlign: TextAlign.right),
                getTitle("Balance", textAlign: TextAlign.right),
              ]
            ),
            TableRow(
              children: [
                getInfo(bank.DOCNUMBER!="0" ? DateFormat("dd/MM/yyyy").format(DateTime.parse(bank.TXNDATE??"")) : "-"),
                getInfo((bank.DOCNUMBER??"").trim()),
                getInfo(bank.DAYBOOKNAME??""),
                getInfo(bank.ContraAccountName??""),
                getInfo(bank.ChequeNo??""),
                getInfo(bank.Amount?.isNegative==true ? (bank.Amount??0).abs().toStringAsFixed(2) : "", textAlign: TextAlign.right),
                getInfo(bank.Amount?.isNegative==true ? "" : (bank.Amount??0).abs().toStringAsFixed(2), textAlign: TextAlign.right),
                getInfo(balance.abs().toStringAsFixed(2), textAlign: TextAlign.right),
              ]
            )
          ]
        ),
        if(index==banks.length-1)
          getTotalDesign(bank),
        // Divider(
        //   thickness: 1,
        //   height: 0
        // )
      ]
    );
  }

  Widget getBank(BankModel bank, int index) {
    if(bank.Amount?.isNegative==true) {
      balance += (bank.Amount??0).abs();
      debit += (bank.Amount??0).abs();
    }
    else {
      balance -= (bank.Amount??0).abs();
      credit += (bank.Amount??0).abs();
    }
    update();

    return Column(
      children: [
        Table(
            columnWidths: {
              0: FlexColumnWidth(1.1), // First column takes up 1/3 of the available width
              1: FlexColumnWidth(0.4),
              2: FlexColumnWidth(2.5),
              3: FlexColumnWidth(2.7),
              4: FlexColumnWidth(0.7),
              5: FlexColumnWidth(1.2),
              6: FlexColumnWidth(1),
              7: FlexColumnWidth(1.2),
            },
            children: [
              TableRow(
                  children: [
                    getInfo(bank.DOCNUMBER!="0" ? DateFormat("dd/MM/yyyy").format(DateTime.parse(bank.TXNDATE??"")) : "-"),
                    getInfo((bank.DOCNUMBER??"").trim()),
                    getInfo(bank.DAYBOOKNAME??""),
                    getInfo(bank.ContraAccountName??""),
                    getInfo(bank.ChequeNo??""),
                    getInfo(bank.Amount?.isNegative==true ? (bank.Amount??0).abs().toStringAsFixed(2) : "", textAlign: TextAlign.right),
                    getInfo(bank.Amount?.isNegative==true ? "" : (bank.Amount??0).abs().toStringAsFixed(2), textAlign: TextAlign.right),
                    getInfo(balance.abs().toStringAsFixed(2), textAlign: TextAlign.right),
                  ]
              )
            ]
        ),
        if(index==banks.length-1)
          getTotalDesign(bank),
      ]
    );
  }

  Widget getTotalDesign(BankModel bank) {
    Widget widget = Column(
      children: [
        Divider(
          thickness: 1,
          height: 2
        ),
        Table(
            columnWidths: {
              0: FlexColumnWidth(1.1), // First column takes up 1/3 of the available width
              1: FlexColumnWidth(0.4),
              2: FlexColumnWidth(2.5),
              3: FlexColumnWidth(2.7),
              4: FlexColumnWidth(0.7),
              5: FlexColumnWidth(1.2),
              6: FlexColumnWidth(1),
              7: FlexColumnWidth(1.2),
            },
            children: [
              TableRow(
                  children: [
                    getInfo(""),
                    getInfo(""),
                    getInfo(""),
                    getInfo(""),
                    getInfo("Total:"),
                    getInfo(debit.toStringAsFixed(2), textAlign: TextAlign.right),
                    getInfo(credit.toStringAsFixed(2), textAlign: TextAlign.right),
                    getInfo(balance.toStringAsFixed(2), textAlign: TextAlign.right),
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
    debit = 0;
    credit = 0;
    balance = 0;
    if (bank.Amount?.isNegative == false) {
      balance += (bank.Amount ?? 0).abs();
      debit += (bank.Amount ?? 0).abs();
    }
    else {
      balance -= (bank.Amount ?? 0).abs();
      credit += (bank.Amount ?? 0).abs();
    }
    update();
    return widget;
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

  Widget getTitle(String data, {EdgeInsets? padding, TextAlign? textAlign}) {
    return Padding(
        padding: padding??EdgeInsets.zero,
        child: Text(
          data,
          textAlign: textAlign??TextAlign.left,
          style: TextStyle(
              fontSize: 10,
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
              fontSize: 10,
              font: semiBold
          ),
        )
    );
  }

  void shareFile() {
    XFile xFile =  XFile(file!.path);
    Essential.shareFile([xFile], "Bank Bill :  ${sd.toString()}");
  }

}
