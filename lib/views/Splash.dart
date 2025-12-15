import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upgrader/upgrader.dart';
import 'package:rupay/colors/MyColors.dart';
import 'package:rupay/controllers/splash/SplashController.dart';

class Splash extends StatelessWidget {
  Splash({ Key? key }) : super(key: key);

  final SplashController splashController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      body: Platform.isIOS ? UpgradeAlert(
        upgrader: Upgrader(),
        child: getBody(context),
      ) : getBody(context),
    );
  }

  Widget getBody(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      alignment: Alignment.center,
      child: Image.asset(
          "assets/app_icon/icon.png"
      ),
    );
  }
}