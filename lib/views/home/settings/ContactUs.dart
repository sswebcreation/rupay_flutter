import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rupay/essential/Essential.dart';
import '../../../colors/MyColors.dart';

class ContactUs extends StatelessWidget {
  ContactUs({Key? key}) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Contact Us",
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
        body: SafeArea(
            bottom: false, // child: getTable(context)
            child: getBody(context)));
  }

  Widget getBody(BuildContext context) {
    return Container(
      color: MyColors.white,
      child: SafeArea(
        child: Column(
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              getSupportCard(
                                context,
                                MyColors.colorBorder,
                                "assets/settings/web.png",
                                "Website",
                                "https://www.sswebcreation.in",

                              ),
                              const SizedBox(width: 8),
                              getSupportCard(
                                  context,
                                  MyColors.colorSecondary.withOpacity(0.5),
                                  "assets/settings/email.png",
                                  "Email Address",
                                  "info@sswebcreation.in"),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              getSupportCard(
                                  context,
                                  MyColors.colorPrimary.withOpacity(0.5),
                                  "assets/settings/phone.png",
                                  "Phone Number",
                                  "+91 9925738893"),
                              const SizedBox(width: 8),
                              getSupportCard(
                                  context,
                                  Color(0xFFFFFFE1E1),
                                  "assets/settings/location.png",
                                  "Location",
                                  "Surat, Gujarat"),
                                  // "B-336, SS WEB CREATION, 3rd Floor, Avadh Arena, VIP Road, Nr. Shyambaba Temple, Opp. Marvella Coridoor, Vesu, Surat, Gujarat 395007"),
                            ],
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/app_icon/icon.png',
                            height: 50,
                          ),
                        ],
                      )
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getSupportCard(BuildContext context, Color color, String icon, String label, String info) {
    return Flexible(
      flex: 1,
      fit: FlexFit.tight,
      child: GestureDetector(
        onTap: () {
          if(label=="Website") {
            Essential.extLink(info);
          }
          else if(label.contains("Email")) {
            Essential.email(info);
          }
          else if(label.contains("Phone")) {
            Essential.call(info);
          }
          else if(label=="Location") {
            Essential.extLink("https://www.google.com/search?q=$info");
          }
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(color: MyColors.colorBorder),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              getCard(color, icon),
              const SizedBox(
                height: 12,
              ),
              Text(label,
                  style: GoogleFonts.inter(
                      color: Color(
                          0xFFFF71717A), //Gyan mat dena static meh rakh deta
                      fontSize: 14,
                      fontWeight: FontWeight.w400)),
              const SizedBox(
                height: 2,
              ),
              Text(info,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                      color: Colors.black, //Gyan mat dena static meh rakh deta
                      fontSize: 10,
                      fontWeight: FontWeight.w600))
            ],
          ),
        ),
      ),
    );
  }

  Widget getCard(Color color, String icon) {
    return Container(
      height: 96,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: color,
      ),
      child: Center(
        child: Image.asset(
          icon,
          width: 28,
          height: 28,
          color: icon.contains("phone") ? MyColors.colorPrimary : null,
        ),
      ),
    );
  }
}
