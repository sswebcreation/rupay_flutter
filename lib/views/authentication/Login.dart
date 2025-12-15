import 'package:rupay/constants/CommonConstants.dart';
import 'package:rupay/size/Spacing.dart';
import 'package:rupay/size/WidgetSize.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rupay/colors/MyColors.dart';
import 'package:rupay/controllers/login/LoginController.dart';
import 'package:rupay/size/MySize.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../designer/button/Button.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);

  final LoginController loginController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      body: Container(
        width: MySize.size100(context),
        height: MySize.sizeh100(context),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        // decoration: const BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage(
        //       "assets/essential/bg.png"
        //     )
        //   )
        // ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 7,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 25.0),
                        child: Image.asset(
                          "assets/app_icon/ss.png",
                          height: 65,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Image.asset(
                          "assets/app_icon/icon.png",
                          height: 100,
                        ),
                      ),
                      // Container(
                      //   padding: EdgeInsets.only(top: standardVTBS),
                      //   width: MySize.size100(context),
                      //   alignment: Alignment.center,
                      //   child: Image.asset(
                      //     "assets/app_icon/icon.jpg",
                      //     width: 150,
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.only(top: 50.0, bottom: 8),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'User Login',
                            style: GoogleFonts.playfairDisplay(
                              fontSize: 32.0,
                              color: MyColors.black,
                              letterSpacing: 0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Login to ${CommonConstants.app_name} for accounts & more!',
                          style: GoogleFonts.manrope(
                            fontSize: 18.0,
                            color: MyColors.black11,
                            letterSpacing: 0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  margin: EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(color: MyColors.white, borderRadius: BorderRadius.circular(24)),
                  child: Form(
                    key: loginController.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            'Mobile No.',
                            style: GoogleFonts.manrope(
                              fontSize: 16.0,
                              color: MyColors.black,
                              letterSpacing: 0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: TextFormField(
                            controller: loginController.mobile,
                            keyboardType: TextInputType.number,
                            maxLength: 10,
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            style: GoogleFonts.manrope(
                              fontSize: 16.0,
                              color: MyColors.black,
                              letterSpacing: 0,
                              fontWeight: FontWeight.w400,
                            ),
                            validator: (value) {
                              if (value!.isNotEmpty) {
                                if (value.length != 10) {
                                  return "* Invalid Mobile No.";
                                } else {
                                  return null;
                                }
                              } else {
                                return "* Required";
                              }
                            },
                            decoration: InputDecoration(
                              counterText: "",
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: MyColors.colorButton,
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                hintText: "Enter Mobile No.",
                                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                                prefixIcon: GestureDetector(
                                  onTap: () {},
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 5),
                                        child: Text(
                                          '+91',
                                          style: GoogleFonts.manrope(
                                            fontSize: 16.0,
                                            color: MyColors.black,
                                            letterSpacing: 0,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(right: 5),
                                        color: MyColors.colorDivider,
                                        width: 2,
                                        height: 20,
                                      )
                                    ],
                                  ),
                                )),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            loginController.validate(fromWhatsapp: true);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset("assets/common/whatsapp.png", height: 25),
                                const SizedBox(width: 5),
                                Text("VERIFY USING WHATSAPP",
                                    style: GoogleFonts.manrope(
                                        fontSize: 14.0,
                                        color: MyColors.black,
                                        letterSpacing: 0,
                                        fontWeight: FontWeight.w500,
                                        decoration: TextDecoration.underline)),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: Text(
                            'By Login, you agree to our Terms & Conditions and Privacy Policy.',
                            style: GoogleFonts.manrope(
                              fontSize: 12.0,
                              color: MyColors.black,
                              letterSpacing: 0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            loginController.validate();
                          },
                          child: standardButton(
                            context: context,
                            backgroundColor: MyColors.colorPrimary,
                            borderColor: MyColors.colorPrimary,
                            margin: const EdgeInsets.only(top: 40),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right: standardHTIS),
                                  child: Text(
                                    'GET OTP',
                                    style: GoogleFonts.manrope(
                                      fontSize: 16.0,
                                      color: MyColors.white,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Image.asset("assets/controls/arrow_next_icon.png",
                                    height: standardArrowH, width: standardArrowW, color: MyColors.white)
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
