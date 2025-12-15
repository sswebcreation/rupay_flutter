import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rupay/colors/MyColors.dart';
import 'package:rupay/constants/CommonConstants.dart';
import 'package:rupay/dialogs/BasicDialog.dart';
import 'package:rupay/dialogs/InfoDialog.dart';
import 'package:rupay/dialogs/ProcessDialog.dart';
import 'package:rupay/providers/TokenProvider.dart';
import 'package:rupay/repositories/TokenRepository.dart';
import 'package:rupay/services/networking/ApiConstants.dart';
import 'package:rupay/services/networking/ApiService.dart';
import 'package:rupay/size/MySize.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:share_plus/share_plus.dart';

class Essential {
  static void showDialog(Widget child, BuildContext context) {
    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => Container(
          height: 216,
          padding: const EdgeInsets.only(top: 6.0),
          // The Bottom margin is provided to align the popup above the system navigation bar.
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          // Provide a background color for the popup.
          color: CupertinoColors.systemBackground.resolveFrom(context),
          // Use a SafeArea widget to avoid system overlaps.
          child: SafeArea(
            top: false,
            child: child,
          ),
        ));
  }


  static void checkLength(int length, TextEditingController controller) {
    if(controller!.text.length>length) {
      controller!.text = controller!.text.substring(0, length);
      controller!.selection = TextSelection.fromPosition(TextPosition(offset: controller!.text.length));
    }
    else {
    }
  }


  static String generateOTP() {
    var rnd = math.Random();
    var next = rnd.nextDouble() * 1000000;
    while (next < 100000) {
      next *= 10;
    }
    return next.toInt().toString();
  }

  static link(String link) {
    launchUrlString(link);
  }

  static extLink(String link) {
    launchUrlString(link, mode: LaunchMode.externalApplication);
  }

  static call(String mobile) {
    launchUrlString("tel:$mobile", mode: LaunchMode.externalApplication);
  }

  static email(String email) {
    launchUrlString("mailto:$email");
  }

  static sms(String mobile) {
    launchUrlString("sms:$mobile");
  }

  static share(String content, String title) {
    Share.share(content, subject: title);
    // Share.share("https://play.google.com/store/apps/details?id=com.ss.itm", subject: 'Hey, looking for an app to grow your income?\n Here it is!');
  }


  static shareFile(List<XFile> files, String title) {
    Share.shareXFiles(files, subject: title);
    // Share.share("https://play.google.com/store/apps/details?id=com.ss.itm", subject: 'Hey, looking for an app to grow your income?\n Here it is!');
  }


  static Future<bool> inform(String text, String btn) {
    return Get.dialog(
      InfoDialog(
        text: text,
        btn : btn,
      ),
      barrierDismissible: false,
    ).then((value) {
      return true;
    });
  }

  static Future<bool> popUp(String text, String btn1, String btn2) {
    return Get.dialog(
      BasicDialog(
        text: text,
        btn1 : btn1,
        btn2: btn2,
      ),
      barrierDismissible: false,
    ).then((value) {
      if(value==btn1) {
        return true;
      }
      return false;
    });
  }

  static Future<String?> choose(String text, String btn1, String btn2) {
    return Get.dialog(
      BasicDialog(
        text: text,
        btn1 : btn1,
        btn2: btn2,
      ),
      barrierDismissible: false,
    ).then((value) {
      return value;
    });
  }

  static Future<void> process(String text) {
    return Get.dialog(
      ProcessDialog(
        text: text,
      ),
      barrierDismissible: false,
    );
  }

  static openwhatsapp(String mobile) async{
    var whatsapp ="+91$mobile";
    var whatsappURl_android = "whatsapp://send?phone=$whatsapp&text=hello";
    var whatappURL_ios ="https://wa.me/$whatsapp?text=${Uri.parse("hello")}";
    if(Platform.isIOS){
      // for iOS phone only
      if(await launch(whatappURL_ios, forceSafariVC: false)){

      }

    }else{
      // android , web
      if( await launch(whatsappURl_android)) {
      }


    }

  }

  static void showBoardList() {
    Get.toNamed('/boardList')?.then((value) {
      Get.offAllNamed('/home');
    });
  }

  static showSnackBar(String message, {int? time}) {
    Get.snackbar( "", message, snackPosition: SnackPosition.BOTTOM, backgroundColor: MyColors.black, margin: EdgeInsets.all(5),  colorText: MyColors.white, duration: Duration(seconds: time??2));
  }

  static final TokenRepository tokenRepository = Get.put(TokenRepository(Get.put(ApiService(Get.find()), permanent: true)));
  static late TokenProvider tokenProvider;
  static final storage = GetStorage();
  static Future<dynamic> getNewAccessToken() async {
    tokenProvider = Get.put(TokenProvider(tokenRepository));


    Map<String, String> data = {
     "token" : storage.read("refresh")??""
    };
    print(data);

    return await tokenProvider.access(data, storage.read("access")??CommonConstants.essential).then((response) async {
      print(response.toJson());
      if(response.code==1) {
        print(response.access_token);
        storage.write("access", response.access_token);
        return true;
      }
      else {
        print("logout");
        await logout();
      }
    });
  }

  static Future<void> logout() async {
    storage.write("access", "essential");
    storage.write("refresh", "");
    storage.write("status", "logged out");
    storage.write("company", null);
    Get.offAllNamed('/login');
  }

  static getShimmerContainer(BuildContext context, double height, {double? width}) {
    return Shimmer.fromColors(
      baseColor: Get.isDarkMode ? Colors.grey.shade100 : Colors.grey.shade300,
      highlightColor: Get.isDarkMode ? Colors.grey.shade600 : Colors.grey.shade100,
      child: Container(
        height: height,
        width: width??MySize.size100(context),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(3),
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(143, 148, 251, .2),
                offset: Offset(0.0, 1.0), //(x,y)
                blurRadius: 1.0,
              )
            ]
        ),
      ),
    );
  }

  static List<String> ones = [
    '', 'one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine', 'ten', 'eleven', 'twelve', 'thirteen', 'fourteen', 'fifteen', 'sixteen', 'seventeen', 'eighteen', 'nineteen'
  ];
  // static List<String> doubles = [
  //
  // ];
  static List<String> tens = [
    '', '', 'twenty', 'thirty', 'forty', 'fifty', 'sixty', 'seventy', 'eighty', 'ninety'
  ];
  static List<String> scales = [
    '', 'thousand', 'lakh', 'crore'
  ];

  static String getRupeeWords(int number) {
    String words = '';


    // Convert the number to a string and pad with zeros if necessary
    String numStr = number.toString().padLeft(12, '0');

    // Split the string into groups of three digits
    List<String> groups = [
      numStr.substring(0, 3),
      numStr.substring(3, 6),
      numStr.substring(6, 9),
      numStr.substring(9),
    ];

    // Loop through the groups and convert each group to words
    for (int i = 0; i < groups.length; i++) {
      int groupNum = int.parse(groups[i]);

      // Add the scale to the words if the group is not zero
      if (groupNum > 0) {
        words += '${convertThreeDigitNumber(groupNum)} ${scales[groups.length - i - 1]} ';
      }
    }

    // Add the currency to the words
    words += ' Only.';

    return words;
  }

  static String convertThreeDigitNumber(int number) {
    String words = '';

    // Get the hundreds digit and add it to the words if it's not zero
    int hundreds = number ~/ 100;
    if (hundreds > 0) {
      words += '${ones[hundreds]} hundred ';
    }

    // Get the last two digits of the number
    int lastTwoDigits = number % 100;

    // If the last two digits are less than 10, add the ones digit to the words
    if (lastTwoDigits < 10) {
      words += '${ones[lastTwoDigits]}';
    }
    // If the last two digits are between 10 and 19, add the appropriate word to the words
    else if (lastTwoDigits < 20) {
      words += '${ones[lastTwoDigits]}';
    }
    // If the last two digits are greater than 19, add the tens digit and ones digit to the words
    else {
      int tensDigit = lastTwoDigits ~/ 10;
      int onesDigit = lastTwoDigits % 10;
      words += '${tens[tensDigit]} ${ones[onesDigit]}';
    }

    return words.trim();
  }

  static String getInitial(String name) {
    String initial = "";
    if(name.trim().isNotEmpty) {
      List<String> words = name.trim().split(" ");
      for (var element in words) {
        initial+=element[0];
      }
    }
    return initial;
  }

  static Future<PermissionStatus> requestPermission() async {
    if(Platform.isAndroid) {
      DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
      AndroidDeviceInfo androidDeviceInfo = await deviceInfoPlugin.androidInfo;

      if(androidDeviceInfo.version.sdkInt>=33)  {
        return PermissionStatus.granted;
      }
      else  {
        return await Permission.storage.request();
      }
    }
    else {
      return await Permission.storage.request();
    }
  }

  static Future<AndroidDeviceInfo> getAndroidDeviceInfo() async {
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    AndroidDeviceInfo androidDeviceInfo = await deviceInfoPlugin.androidInfo;
    return androidDeviceInfo;
  }

  static Future<IosDeviceInfo> getIOSDeviceInfo() async {
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    IosDeviceInfo iosDeviceInfo = await deviceInfoPlugin.iosInfo;
    return iosDeviceInfo;
  }

  static String getItems(String data) {
    print("hellu");
    print(data);
    print("data");
    try {
      List<dynamic> items = json.decode(data);
      String item = "";
      for (int i = 0; i < (items.length >= 2 ? 2 : 1); i++) {
        item += ", ${items[i]}";
      }
      return "${item.substring(2)}${items.length > 2 ? " +${items.length -
          2} more" : ""}";
    }
    catch(ex) {
      print("ex.toString()");
      print(ex.toString());
      print(data);
      print("data1111");
    }
    return "";
  }

  static String getQuantity(String data) {
    print("hellu");
    print(data);
    print("data");
    try {
      List<dynamic> qty = json.decode(data);
      double qt = 0;
      for (int i = 0; i < qty.length; i++) {
        qt += double.parse(qty[i].toString());
      }
      return qt.toStringAsFixed(2);
    }
    catch(ex) {
      print("ex.toString()");
      print(ex.toString());
      print(data);
      print("data1111");
    }
    return "";
  }

  static void logPrint(Object object) async {
    int defaultPrintLength = 1020;
    if (object == null || object.toString().length <= defaultPrintLength) {
      print(object);
    } else {
      String log = object.toString();
      int start = 0;
      int endIndex = defaultPrintLength;
      int logLength = log.length;
      int tmpLogLength = log.length;
      while (endIndex < logLength) {
        print(log.substring(start, endIndex));
        endIndex += defaultPrintLength;
        start += defaultPrintLength;
        tmpLogLength -= defaultPrintLength;
      }
      if (tmpLogLength > 0) {
        print(log.substring(start, logLength));
      }
    }
  }
}