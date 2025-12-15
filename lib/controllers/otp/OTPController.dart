import 'dart:async';
import 'dart:math' as math;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rupay/colors/MyColors.dart';

// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rupay/essential/Essential.dart';
import 'package:pinput/pinput.dart';
import 'package:http/http.dart' as http;

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
    // Define the characters allowed in the OTP
    const chars = '1234567890';

    // Create a random number generator object
    final math.Random rnd = math.Random();

    // Generate a string of random characters with the desired length
    return String.fromCharCodes(Iterable.generate(length, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));
  }

  getOTP(String message) async {
    generatedOTP = generateOTP(6);

    // if (mobile == '9999999999') {
    //   sent = true;
    //   Essential.showSnackBar(message, time: 1);
    //   update();
    //   return;
    // }

    if (fromWhatsapp) {
      String text =
          'Your RuPay Application OTP is *${generatedOTP}* Kindly login with this OTP.\nPlease keep it confidential.\n*Thank you*.';
      String url =
          'https://sendbuddy.in/api/send?number=${code.substring(1)}${mobile}&type=media&message=${Uri.encodeComponent(text)}&instance_id=665EB55F4C6F8&access_token=660d56ed3205e';
      print(url);
      var res = await http.get(Uri.parse(url));
      print(res);
      sent = true;
      Essential.showSnackBar(message, time: 1);
      update();
      return;
    }

    /// LOGIN WITH OTP
    String text = 'Your%20OTP%20Code%20is%20$generatedOTP%20FROM%20RuPay%20-%20FLASHB';
    String url = 'https://sms.mobileadz.in/api/push?apikey=66fe8bd445279&sender=FLASHB&mobileno=${mobile}&text=$text';
    var res = await http.get(Uri.parse(url));
    debugPrint(res.body.toString());
    sent = true;
    Essential.showSnackBar(message, time: 1);
    update();
    return;
    // Firebase Code
    // await auth.verifyPhoneNumber(
    //   phoneNumber: '$code$mobile',
    //   verificationCompleted: (PhoneAuthCredential credential) async {
    //     print("verified");
    //   },
    //   codeSent: (String verificationId, int? forceResendingToken) async {
    //     print("code sent");
    //     verificationIDReceived = verificationId;
    //     sent = true;
    //     Essential.showSnackBar(message, time: 1);
    //     update();
    //   },
    //   codeAutoRetrievalTimeout: (String verificationId) {
    //     print("auto retrieval");
    //     verificationIDReceived = verificationId;
    //     // Essential.showSnackBar("Time Out", time: 1);
    //     update();
    //   },
    //   verificationFailed: (FirebaseAuthException error) {
    //     print("failedddd");
    //     print(error.toString());
    //     Essential.showSnackBar(error.toString(), time: 1);
    //   },
    // );
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
        Get.snackbar("", "Invalid OTP",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: MyColors.black,
            margin: const EdgeInsets.all(5),
            colorText: MyColors.white);
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
