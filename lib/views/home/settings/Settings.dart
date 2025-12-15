import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:rupay/colors/MyColors.dart';
import 'package:rupay/controllers/settings/SettingsController.dart';
import 'package:rupay/essential/Essential.dart';
import 'package:rupay/services/networking/ApiConstants.dart';
import 'package:rupay/size/MySize.dart';

class Settings extends StatelessWidget {
  Settings({ Key? key }) {
    settingsController.onInit();
  }

  final SettingsController settingsController = Get.put<SettingsController>(SettingsController());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GetBuilder<SettingsController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              settingsController.company.NAME,
              // "SS WEB CREATION",
              style: GoogleFonts.manrope(
                fontSize: 16.0,
                color: MyColors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            centerTitle: true,
            backgroundColor: MyColors.colorSecondary,
            iconTheme: IconThemeData(
                color: MyColors.white
            ),
            elevation: 0,
          ),
          backgroundColor: MyColors.white,
          body: getBody(context)
        );
      },
    );
  }

  Widget getBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: CircleAvatar(
              radius: 52,
              child: (settingsController.company.LOGO??"").isNotEmpty ?
              CircleAvatar(
                radius: 50,
                backgroundColor: MyColors.white,
                backgroundImage: NetworkImage(
                    ApiConstants.assetUrl+(settingsController.company.LOGO??"")
                ),
              )
                  : CircleAvatar(
                radius: 50,
                backgroundColor: MyColors.white,
                child: Image.asset(
                    "assets/app_icon/icon.png"
                ),
              ),
            ),
          ),
          // getInfo("VISIT WEBSITE", "website"),
          // SizedBox(
          //   height: 20,
          // ),
          getInfo(settingsController.company.MOBILE1, "mobile"),
          // getInfo("+91 9925738893", "mobile"),
          SizedBox(
            height: 5,
          ),
          getInfo(settingsController.company.EMAIL??"", "email"),
          // getInfo("info@sswebcreation.in", "email"),
          SizedBox(
            height: 20,
          ),
          // getSettingsCard("myprofile.png", "My Profile", context),
          // getSettingsCard("contactus.png", "Contact Us", context),
          getSettingsCard("change.png", "Change Company", context),
          getSettingsCard("devices.png", "Device List", context),
          getSettingsCard("contactus.png", "Contact Us", context),
          getSettingsCard("share.png", "Share App", context),
          getSettingsCard("update.png", "Update App", context),
          if(settingsController.storage.read("mobile")=="9999999999")
            getSettingsCard("myprofile.png", "Delete Account", context),
          getSettingsCard("logout.png", "Logout", context),
        ],
      ),
    );
  }

  getInfo(String info, String label) {
    return GestureDetector(
      onTap: () {
        if(label=="mobile")
          Essential.call(info);
        else if(label=="email")
          Essential.email(info);
      },
      child: Text(
        info,
        style: TextStyle(
            color: MyColors.colorLightPrimary,
            fontSize: 14,
            fontWeight: FontWeight.w600
        ),
      ),
    );
  }

  getSettingsCard(String icon, String title, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: MySize.size10(context)),
      child: GestureDetector(
        onTap: () {
          if(title=="My Profile") {
          }
          // if(title=="Use Toll Free Numbers") {
          //   Navigator.of(context).push(
          //       MaterialPageRoute(
          //           builder: (BuildContext context) =>
          //               TollFreeList()));
          // }
          // else if(title=="Contact Us") {
          //   Navigator.of(context).push(
          //       MaterialPageRoute(
          //           builder: (BuildContext context) =>
          //               cp.ContactUs(contactUs: contactUs,)));
          // }
          else if(title=="Change Company") {
            settingsController.goto("/company", arguments: {"back" : true});
          }
          else if(title=="Device List") {
            settingsController.goto("/device");
          }
          else if(title=="Contact Us") {
            settingsController.goto("/contactUs");
          }
          else if(title=="Share App") {
            Share.share(Platform.isAndroid ?
            "https://play.google.com/store/apps/details?id=com.ss.rupay"
                : "https://apps.apple.com/in/app/rupay/id6475946639" , subject: 'Hey, looking for an app to manage your accounting?\n Here it is!');
          }
          else if(title=="Update App") {
            Essential.extLink(Platform.isAndroid ?
            "https://play.google.com/store/apps/details?id=com.ss.rupay"
                : "https://apps.apple.com/in/app/rupay/id6475946639");
            // Essential.extLink(Platform.isIOS ? "https://apps.apple.com/in/app/urmila-saree/id6448612801" : "https://play.google.com/store/apps/details?id=com.ss.rupay");
          }
          else if(title=="Delete Account") {
            settingsController.delete();
          }
          else if(title=="Logout") {
            settingsController.logout();
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Image.asset(
                  "assets/settings/"+icon,
                  height: 25,
                  color: MyColors.colorSecondary,
                ),
              ),
            ),
            Flexible(
              flex: 3,
              fit: FlexFit.tight,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  title,
                  style: TextStyle(
                      color: MyColors.colorPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.w600
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

}