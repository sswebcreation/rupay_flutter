import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rupay/essential/Essential.dart';
import 'package:rupay/services/networking/ApiConstants.dart';


class RateListController extends GetxController {
  RateListController();

  late bool load;
  File? file;
  final Completer<PDFViewController> controller =
  Completer<PDFViewController>();
  int? pages = 0;
  int? currentPage = 0;
  bool isReady = false;
  String errorMessage = '';


  @override
  void onInit() {
    super.onInit();
    load = false;
    start();
  }

  Future<void> start() async {
    createFileOfPdfUrl();
  }


  Future<File> createFileOfPdfUrl() async {
    Completer<File> completer = Completer();
    print("Start download file from internet!");
    try {
      // "https://berlin2017.droidcon.cod.newthinking.net/sites/global.droidcon.cod.newthinking.net/files/media/documents/Flutter%20-%2060FPS%20UI%20of%20the%20future%20%20-%20DroidconDE%2017.pdf";
      // final url = "https://pdfkit.org/docs/guide.pdf";
      final url = ApiConstants.assetUrl+"ratelist.pdf";
      // final url = "http://www.pdf995.com/samples/pdf.pdf";
      final filename = "RateList.pdf";
      var request = await HttpClient().getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      final dir = await getTemporaryDirectory();
      print("Download files");
      print("${dir?.path}/$filename");
      file = File("${dir?.path}/$filename");

      await file!.writeAsBytes(bytes, flush: true);

      completer.complete(file);
      load = true;

      update();
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
  }

  @override
  void dispose() {
    super.dispose();
  }


  void shareFile() {
    XFile xFile =  XFile(file!.path);
    Essential.shareFile([xFile], "Rate List");
  }

}
