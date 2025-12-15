import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rupay/colors/MyColors.dart';
import 'package:rupay/size/MySize.dart';


class ProcessDialog extends StatelessWidget {
  final String text;
  const ProcessDialog({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      child: Container(
        width: MySize.size100(context),
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircularProgressIndicator(
              color: MyColors.colorPrimary,
            ),
            SizedBox(
              width: 20,
            ),
            Text(text,
              style: GoogleFonts.manrope(
                  fontSize: 18,
                color: MyColors.black
              ),
            ),
          ],
        ),
      ),
    );
  }
}
