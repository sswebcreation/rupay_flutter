import 'package:rupay/size/Spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rupay/colors/MyColors.dart';
import 'package:rupay/controllers/signUp/SignUpController.dart';
import 'package:rupay/size/MySize.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../designer/button/Button.dart';

class SignUp extends StatelessWidget {
  SignUp({ Key? key }) : super(key: key);

  final SignUpController signUpController = Get.find();
  late BuildContext context;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
      backgroundColor: MyColors.colorPrimary,
      resizeToAvoidBottomInset: false,
      body: Container(
        width: MySize.size100(context),
        height: MySize.sizeh100(context),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        // decoration: BoxDecoration(
        //     image: const DecorationImage(
        //         image: AssetImage(
        //             "assets/essential/bg.png"
        //         )
        //     )
        // ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 25.0, bottom: 8),
                            child: Text(
                              'Get Started',
                              style: GoogleFonts.playfairDisplay(
                                fontSize: 32.0,
                                color: MyColors.black,
                                letterSpacing: 0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Text(
                            'Create your account now',
                            style: GoogleFonts.manrope(
                              fontSize: 18.0,
                              color: MyColors.black11,
                              letterSpacing: 0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    GetBuilder<SignUpController>(
                      builder: (controller) {
                        return Container(
                          // height: 500,
                          // padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                color: MyColors.white,
                                borderRadius: BorderRadius.circular(24)
                            ),
                            child: Theme(
                              data: ThemeData(
                                  colorScheme: Theme.of(context).colorScheme.copyWith(
                                    primary: MyColors.colorButton,
                                  ),
                                  shadowColor: Colors.transparent,
                                  canvasColor: MyColors.white
                              ),
                              child: Container(
                                height: 500,
                                padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
                                child: getCustomStepper(),
                              ),
                            )
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 25, bottom: 25),
              alignment: Alignment.center,
              child: RichText(
                text: TextSpan(
                    text: "Already have an account? ",
                    style: GoogleFonts.manrope(
                      fontSize: 16.0,
                      color: MyColors.black,
                      letterSpacing: 0,
                      fontWeight: FontWeight.w500,
                    ),
                    children: [
                      TextSpan(
                        text: "Login",
                        style: GoogleFonts.manrope(
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ]
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getSteps() {
    return Row(
      children: [
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: getStep(0),
        ),
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: getStep(1),
        ),
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: getStep(2),
        ),
      ],
    );
  }

  Widget getStep(int step) {
    return Column(
      children: [
        Container(
          height: 24,
          width: 24,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: MyColors.colorButton
          ),
          child: Text(
            (step+1).toString(),
          )
        )
      ],
    );
  }



  getStepDesign(int step) {
    return step==0 ? getStep1() : step==1 ? getStep2() : getStep3();
  }

  getStep1() {
    return Text(
        "Step 1"
    );
  }

  getStep2() {
    return Text(
        "Step 2"
    );
  }

  getStep3() {
    return Text(
        "Step 3"
    );
  }

  getStep5() {
    return Form(
      key: signUpController.step1,
      child: Column(
        mainAxisSize: MainAxisSize.min,
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
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly
              ],
              style: GoogleFonts.manrope(
                fontSize: 16.0,
                color: MyColors.black,
                letterSpacing: 0,
                fontWeight: FontWeight.w400,
              ),
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: MyColors.colorButton,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  hintText: "Enter Mobile No.",
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  prefixIcon: GestureDetector(
                    onTap: () {

                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 14),
                          child: Image.asset(
                            "assets/country/India.png",
                            height: 24,
                            width: 33,
                          ),
                        ),
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
                  )
              ),
            ),
          ),
          standardButton(
            context: context,
            backgroundColor: MyColors.colorButton,
            margin: const EdgeInsets.only(top: 24),
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
                Image.asset(
                    "assets/controls/arrow_next_icon.png"
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  getState(int step) {
    if(step==signUpController.current) {
      return StepState.editing;
    }
    else if(step<signUpController.current) {
      return StepState.complete;
    }
    else {
      return StepState.disabled;
    }
  }

  getActive(int step) {
    if(step==signUpController.current) {
      return true;
    }
    else if(step<signUpController.current) {
      return true;
    }
    else {
      return false;
    }
  }

  getConnector(int step) {
    return step!=2 ? Text(
      "---------",
      style: TextStyle(
          color: getColor(step)
      ),
    ) : Container();
  }

  getColor(int step) {
    if(step<signUpController.current) {
      return MyColors.colorButton;
    }
    else {
      return MyColors.colorDivider;
      // return Colors.grey.shade400;
    }
  }

  getCustomStepper() {
    return Column(
      children: [
        getSteps()
      ],
    );
  }

}