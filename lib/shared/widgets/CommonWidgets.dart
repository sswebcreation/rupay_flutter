import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:rupay/colors/MyColors.dart';
import 'package:pdf/widgets.dart' as pdf;

class CommonWidgets {
  static void snackBar(String type, String message) async {
    Get.snackbar(
      type, message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: type == 'error' ? Colors.red : Colors.green,
      colorText: Colors.white,
      icon: Icon(Icons.error, color: Colors.white)
    );
  }

  static void showSuccessToast(String title, String message) async {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      icon: Icon(Icons.check_circle, color: Colors.white),
    );
  }
}

Widget horizontalDivider() {
  return Container(
    height: 1,
    color: MyColors.colorBorder,
  );
}

Widget verticalDivider() {
  return Container(
    width: 1,
    color: MyColors.colorBorder,
  );
}

pdf.Widget pdfVerticalDivider() {
  return pdf.Container(
    width: 1,
    color: PdfColors.black,
  );
}