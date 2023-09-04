
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';




const primaryClr = bluishClr;
const darkGreyClr =_darkPrimaryColor ;

 const Color bluishClr = Color(0xFF4e5ae8);
 const Color yellowClr = Color(0xFFFFB746);
 const Color pinkClr = Color(0xFFff4667);
 const Color _lightOnPrimaryColor = Colors.black;

 const Color _darkPrimaryColor = Color(0xFF121212);
 const Color _darkPrimaryVariantColor = Color(0xFF424242);
 const Color _darkSecondaryColor = Colors.white;
 const Color _darkOnPrimaryColor = Colors.white;


class Themes {

  static final darkTheme = ThemeData(
    primaryColor: _darkPrimaryColor,
    brightness: Brightness.dark,
    backgroundColor: const Color(0xFF212121),
    // dividerColor: Colors.black12, colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey).copyWith(secondary: Colors.white),
  );

  static final lightTheme = ThemeData(
    primaryColor: bluishClr,
    brightness: Brightness.light,
    backgroundColor: Colors.white,
    // dividerColor: Colors.white54, colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey).copyWith(secondary: Colors.black),
  );

}

TextStyle get subHeadingStyle{
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.w400,
      color: Get.isDarkMode? Colors.grey[400]: Colors.grey
    ),
  );
}
TextStyle get HeadingStyle{
  return GoogleFonts.lato(
    textStyle: TextStyle(
        fontSize: 28.0,
        fontWeight: FontWeight.bold,
        color: Get.isDarkMode? Colors.white: Colors.black
    ),
  );
}
TextStyle get titleStyle{
  return GoogleFonts.lato(
    textStyle: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
        color: Get.isDarkMode? Colors.white: Colors.black
    ),
  );
}
TextStyle get subTitleStyle{
  return GoogleFonts.lato(
    textStyle: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
        color: Get.isDarkMode? Colors.grey[100] : Colors.grey[600]
    ),
  );
}

