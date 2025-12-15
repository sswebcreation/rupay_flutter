import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rupay/constants/CommonConstants.dart';
import 'package:rupay/constants/UserConstants.dart';
import 'package:rupay/essential/Essential.dart';
import 'package:rupay/models/login/LoginModel.dart';
import 'package:rupay/notification_helper/NotificationHelper.dart';
import 'package:rupay/providers/UserProvider.dart';
import 'package:rupay/services/networking/ApiConstants.dart';

class LoginController extends GetxController {
  LoginController();

  final storage = GetStorage();
  late UserProvider userProvider = Get.find();
  final TextEditingController mobile = TextEditingController();
  late GlobalKey<FormState> formKey;

  @override
  void onInit() {
    super.onInit();
    formKey = GlobalKey<FormState>();
  }

  goto(String path, dynamic data, {LoginModel? loginModel}) {
    Get.toNamed(path, arguments: data)?.then((value) {
      if (value == "verified") {
        login();
      }
    });
  }

  void validate({fromWhatsapp = false}) {
    if (formKey.currentState!.validate()) {
      /// BYPASS
      // verify(fromWhatsapp: fromWhatsapp);
      login();
    }
  }

  Future<void> verify({fromWhatsapp}) async {
    final Map<String, String> data = {
      UserConstants.mobile: mobile.text,
    };
    userProvider.login(data, CommonConstants.essential, ApiConstants.verify).then((response) async {
      print(response.toJson());
      if (response.code == 1) {
        goto("/otp", {"mobile": mobile.text, "code": "+91", "fromWhatsapp": fromWhatsapp}, loginModel: response);
      } else {
        Essential.showSnackBar(response.message);
      }
    });
  }

  Future<void> login() async {
    String imei = "";
    String model = "";
    String os = "";

    if (Platform.isAndroid) {
      os = "ANDROID";

      AndroidDeviceInfo androidDeviceInfo = await Essential.getAndroidDeviceInfo();
      print(
          "---------------------------------------------------------androidDeviceInfo---------------------------------------------------------");
      imei = androidDeviceInfo.id;
      model = "${androidDeviceInfo.brand} ${androidDeviceInfo.model}";
      print(
          "---------------------------------------------------------androidDeviceInfo---------------------------------------------------------");
    } else if (Platform.isIOS) {
      os = "IOS";

      IosDeviceInfo iosDeviceInfo = await Essential.getIOSDeviceInfo();
      print(
          "---------------------------------------------------------iosDeviceInfo---------------------------------------------------------");
      imei = iosDeviceInfo.identifierForVendor ?? "";
      print(iosDeviceInfo.utsname.machine ?? "");
      model = "${CommonConstants.iPhoneModels[iosDeviceInfo.utsname.machine ?? ""] ?? ""} ${iosDeviceInfo.name ?? ""}";
      print(
          "---------------------------------------------------------iosDeviceInfo---------------------------------------------------------");
    }

    final Map<String, String> data = {
      UserConstants.mobile: mobile.text,
      "os": os,
      "model": model,
      "imei": imei,
      "fcm": await NotificationHelper.generateFcmToken(),
    };

    print(data);

    userProvider.login(data, CommonConstants.essential, ApiConstants.login).then((response) async {
      print(response.toJson());
      if (response.code == 1) {
        goToHome(response);
      } else {
        Essential.showSnackBar(response.message);
      }
    });
  }

  void goToHome(LoginModel response) {
    storage.write("status", "logged in");
    storage.write("access", response.access_token ?? "");
    storage.write("refresh", response.refresh_token ?? "");
    Get.offAllNamed("/company");
  }
}
