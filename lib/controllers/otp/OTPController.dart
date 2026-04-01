import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rupay/colors/MyColors.dart';

// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rupay/essential/Essential.dart';
import 'package:pinput/pinput.dart';
import 'package:http/http.dart' as http;
import 'package:rupay/services/networking/ApiConstants.dart';

class OTPController extends GetxController {
  OTPController();

  TextEditingController otp = TextEditingController();

  late Timer timer;
  late int start_time = 60;
  late String mobile;
  late String code;
  late bool fromWhatsapp;

  late String generatedOTP;

  late String verificationIDReceived;

  late FirebaseAuth auth;

  late PinTheme defaultPinTheme;
  late PinTheme focusedPinTheme;
  late PinTheme submittedPinTheme;
  late bool sent;

  @override
  void onInit() {
    super.onInit();
    auth = FirebaseAuth.instance;
    sent = false;
    defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(fontSize: 20, color: MyColors.colorPrimary, fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: MyColors.colorPrimary),
        borderRadius: BorderRadius.circular(12),
      ),
    );

    focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: MyColors.colorPrimary),
      borderRadius: BorderRadius.circular(8),
    );

    submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: MyColors.colorLightPrimary.withOpacity(0.3),
      ),
    );
    mobile = Get.arguments['mobile'];
    code = Get.arguments['code'];
    fromWhatsapp = Get.arguments['fromWhatsapp'];
    generatedOTP = '';
    start_time = 60;
    startTimer();

    getOTP("OTP Sent");
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (start_time == 0) {
          timer.cancel();
        } else {
          start_time--;
        }
        update();
      },
    );
  }

  String generateOTP(int length) {
    const chars = '1234567890';
    final math.Random rnd = math.Random();
    return String.fromCharCodes(Iterable.generate(length, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));
  }

  getOTP(String message) async {
    generatedOTP = generateOTP(6);

    /// STATIC LOGIN
    if (mobile == '9999999999') {
      sent = true;
      update();
      await Future.delayed(1.seconds);
      Essential.showSnackBar(message, time: 1);
      return;
    }

    /// GLOBAL SETTING
    String settingUrl = '${ApiConstants.baseUrl}settings/';
    var settingRes = await http.get(Uri.parse(settingUrl));
    debugPrint(settingRes.body.toString());
    final decoded = jsonDecode(settingRes.body);
    String instanceId = decoded['data']?['sendbuddy_instance_id'] ?? '';
    String accessToken = decoded['data']?['sendbuddy_access_token'] ?? '';
    String apiKey = decoded['data']?['flashb_api_key'] ?? '';

    /// WHATSAPP SMS
    if (fromWhatsapp) {
      String text = 'Your RuPay Application OTP is *$generatedOTP* Kindly login with this OTP.\nPlease keep it confidential.\n*Thank you*.';
      String url =
          'https://aa.sendbuddy.in/api/send?number=${code.substring(1)}$mobile&type=media&message=${Uri.encodeComponent(text)}&instance_id=$instanceId&access_token=$accessToken';
      debugPrint(url);
      var res = await http.get(Uri.parse(url));
      debugPrint(res.body.toString());
      sent = true;
      Essential.showSnackBar(message, time: 1);
      update();
      return;
    }

    /// TEXT SMS
    String text = 'Your%20OTP%20Code%20is%20$generatedOTP%20FROM%20RuPay%20-%20FLASHB';
    String url = 'https://sms.mobileadz.in/api/push?apikey=$apiKey&sender=FLASHB&mobileno=${mobile}&text=$text';
    debugPrint(url);
    var res = await http.get(Uri.parse(url));
    debugPrint(res.body);
    sent = true;
    Essential.showSnackBar(message, time: 1);
    update();
    return;
  }

  void resendOTP() {
    start_time = 60;
    sent = false;
    update();
    startTimer();
    getOTP("OTP Resent");
  }

  Future<String?> checkOTP(String otp) async {
    if (mobile == '9999999999' && otp == '123456') {
      Get.back(result: "verified");
      return null;
    }
    if (fromWhatsapp) {
      if (generatedOTP == otp) {
        Get.back(result: "verified");
        return null;
      } else {
        Essential.showSnackBar("Invalid OTP", time: 1);
        return "Invalid OTP";
        // Get.snackbar("", "Invalid OTP", snackPosition: SnackPosition.BOTTOM,
        //     backgroundColor: MyColors.black,
        //     margin: EdgeInsets.all(5),
        //     colorText: MyColors.white);
      }
    }

    /// OTP LOGIN VIA API
    if (generatedOTP != '') {
      if (generatedOTP == otp) {
        Get.back(result: "verified");
        return null;
      } else {
        Get.snackbar("", "Invalid OTP", snackPosition: SnackPosition.BOTTOM, backgroundColor: MyColors.black, margin: const EdgeInsets.all(5), colorText: MyColors.white);
      }
    }
    return null;
    // PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationIDReceived, smsCode: otp);
    // try {
    //   await auth.signInWithCredential(credential).then((value) {
    //     print(value);
    //     if (value.user != null) {
    //       // if (otp=="123456") {
    //       Get.back(result: "verified");
    //       return null;
    //     } else {
    //       Essential.showSnackBar("Invalid OTP", time: 1);
    //       return "Invalid OTP";
    //       // Get.snackbar("", "Invalid OTP", snackPosition: SnackPosition.BOTTOM,
    //       //     backgroundColor: MyColors.black,
    //       //     margin: EdgeInsets.all(5),
    //       //     colorText: MyColors.white);
    //     }
    //   });
    // } catch (e1) {
    //   print(e1.toString());
    //   Essential.showSnackBar("Invalid Code", time: 1);
    //   // Get.snackbar("", "Invalid Code", snackPosition: SnackPosition.BOTTOM,
    //   //     backgroundColor: MyColors.black,
    //   //     margin: EdgeInsets.all(5),
    //   //     colorText: MyColors.white);
    //   return "Invalid Code";
    // }
  }
}
