import 'package:google_fonts/google_fonts.dart';
import 'package:rupay/colors/MyColors.dart';
import 'package:flutter/material.dart';

class Themes {
  static ThemeData lightTheme = ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textTheme: GoogleFonts.latoTextTheme(
        TextTheme(
            displayLarge: TextStyle(
                letterSpacing: -1.5,
                fontSize: 48,
                color: Colors.black,
                fontWeight: FontWeight.bold
            ),
            displayMedium: TextStyle(
                letterSpacing: -1.0,
                fontSize: 40,
                color: Colors.black,
                fontWeight: FontWeight.bold
            ),
            displaySmall: TextStyle(
                letterSpacing: -1.0,
                fontSize: 32,
                color: Colors.black,
                fontWeight: FontWeight.bold
            ),
            headlineMedium: TextStyle(
                letterSpacing: -1.0,
                color: Colors.black,
                fontSize: 28,
                fontWeight: FontWeight.w600
            ),
            headlineSmall: TextStyle(
                letterSpacing: -1.0,
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.w500
            ),
            titleLarge: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w500
            ),
            titleMedium: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500
            ),
            titleSmall: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w500
            ),
            bodyLarge: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 16,
                fontWeight: FontWeight.w400
            ),
            bodyMedium: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 14,
                fontWeight: FontWeight.w400
            ),
            labelLarge: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600
            ),
            bodySmall: TextStyle(
                color: Colors.grey.shade800,
                fontSize: 12,
                fontWeight: FontWeight.w400
            ),
            labelSmall: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 10,
                fontWeight: FontWeight.w400,
                letterSpacing: -0.5
            )
        )
    ),
    primarySwatch: MyColors.generateMaterialColor(MyColors.colorPrimary),
    brightness: Brightness.light,
    appBarTheme: AppBarTheme(
      titleTextStyle: TextStyle(
        color: MyColors.black,
        fontWeight: FontWeight.w600
      ),
      iconTheme: IconThemeData(
        color: MyColors.black
      ),
      backgroundColor: MyColors.grey,
      elevation: 0
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(10)
      ),
      hintStyle: TextStyle(
        fontSize: 14,
      )
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: MyColors.red
    ),

  );

  static ThemeData darkTheme = ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textTheme: GoogleFonts.latoTextTheme(
        TextTheme(
            displayLarge: TextStyle(
                letterSpacing: -1.5,
                fontSize: 48,
                color: Colors.grey.shade50,
                fontWeight: FontWeight.bold
            ),
            displayMedium: TextStyle(
                letterSpacing: -1.0,
                fontSize: 40,
                color: Colors.grey.shade50,
                fontWeight: FontWeight.bold
            ),
            displaySmall: TextStyle(
                letterSpacing: -1.0,
                fontSize: 32,
                color: Colors.grey.shade50,
                fontWeight: FontWeight.bold
            ),
            headlineMedium: TextStyle(
                letterSpacing: -1.0,
                color: Colors.grey.shade50,
                fontSize: 28,
                fontWeight: FontWeight.w600
            ),
            headlineSmall: TextStyle(
                letterSpacing: -1.0,
                color: Colors.grey.shade50,
                fontSize: 24,
                fontWeight: FontWeight.w500
            ),
            titleLarge: TextStyle(
                color: Colors.grey.shade50,
                fontSize: 18,
                fontWeight: FontWeight.w500
            ),
            titleMedium: TextStyle(
                color: Colors.grey.shade50,
                fontSize: 16,
                fontWeight: FontWeight.w500
            ),
            titleSmall: TextStyle(
                color: Colors.grey.shade50,
                fontSize: 14,
                fontWeight: FontWeight.w500
            ),
            bodyLarge: TextStyle(
                color: Colors.grey.shade50,
                fontSize: 16,
                fontWeight: FontWeight.w400
            ),
            bodyMedium: TextStyle(
                color: Colors.grey.shade50,
                fontSize: 14,
                fontWeight: FontWeight.w400
            ),
            labelLarge: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600
            ),
            bodySmall: TextStyle(
                color: Colors.grey.shade50,
                fontSize: 12,
                fontWeight: FontWeight.w500
            ),
            labelSmall: TextStyle(
                color: Colors.grey.shade50,
                fontSize: 10,
                fontWeight: FontWeight.w400
            )
        )
    ),
    primaryColor: MyColors.colorPrimary,
    primarySwatch: MyColors.generateMaterialColor(MyColors.colorPrimary),
    brightness: Brightness.dark,
    scaffoldBackgroundColor: MyColors.black,
    appBarTheme: AppBarTheme(
      backgroundColor: MyColors.gray900,
      elevation: 0,
      iconTheme: IconThemeData(
        color: MyColors.white
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(10)
      ),
      hintStyle: TextStyle(
        fontSize: 14,
      )
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: MyColors.white
    ), bottomAppBarTheme: BottomAppBarTheme(color: MyColors.gray900),
  );
}
