import "package:flutter/material.dart";
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';

SizedBox defaultHeightSpace = SizedBox(
  height: 24,
);
SizedBox spaceHeightLarge = SizedBox(height: 24);
SizedBox spaceHeightNormal = SizedBox(height: 20);
SizedBox spaceHeightSmall = SizedBox(height: 12);
SizedBox spaceHeightExtraSmall = SizedBox(height: 8);

SizedBox defaultWidthtSpace = SizedBox(
  width: 12,
);

final widthScreen = Get.mediaQuery.size.width;
final heightScreen = Get.mediaQuery.size.height;

class AppColor {
  static const Color blue500 = Color.fromRGBO(121, 146, 255, 1);
  static const Color button = Color.fromRGBO(52, 97, 253, 1);
  static const Color colorkey = Color.fromRGBO(214, 223, 255, 1);
  static const Color black = Color(0xff353535);
  static const Color grey = Color.fromRGBO(234, 239, 245, 1);
  static const Color white = Color(0xffFEFEFE);
  static const Color background = Color(0xffFAFAFA);
  static const Color txtcolor = Color.fromRGBO(42,78,202, 1);
}

figmaFontsize(int fontSize) {
  return fontSize * 1.2;
}

class AppTextStyle {
  static TextStyle tsBigTitleBold(Color color) {
    return GoogleFonts.manrope(
      fontSize: figmaFontsize(20),
      fontWeight: FontWeight.bold,
      color: color,
    );
  }

  static TextStyle tsTitleBold(Color color) {
    return GoogleFonts.manrope(
      fontSize: figmaFontsize(16),
      fontWeight: FontWeight.bold,
      color: color,
    );
  }

  static TextStyle tsBodyRegular(Color color) {
    return GoogleFonts.manrope(
      fontSize: figmaFontsize(14),
      fontWeight: FontWeight.normal,
      color: color,
    );
  }

  static TextStyle tsBodyBold(Color color) {
    return GoogleFonts.manrope(
      fontSize: figmaFontsize(14),
      fontWeight: FontWeight.bold,
      color: color,
    );
  }

  static TextStyle tsSmallRegular(Color color) {
    return GoogleFonts.manrope(
      fontSize: figmaFontsize(12),
      fontWeight: FontWeight.normal,
      color: color,
    );
  }

  static TextStyle tsSmallBold(Color color) {
    return GoogleFonts.manrope(
      fontSize: figmaFontsize(12),
      fontWeight: FontWeight.bold,
      color: color,
    );
  }

  static TextStyle tsTitle = GoogleFonts.manrope(
    fontSize: figmaFontsize(16),
    fontWeight: FontWeight.bold,
  );
  static TextStyle tsNormal = GoogleFonts.manrope(
    fontSize: figmaFontsize(12),
    fontWeight: FontWeight.w500,
  );
  static TextStyle tsLittle = GoogleFonts.manrope(
    fontSize: figmaFontsize(10),
    color: AppColor.black,
    fontWeight: FontWeight.w500,
  );
  static TextStyle tsTextContainer = GoogleFonts.manrope(
      fontSize: figmaFontsize(16),
      fontWeight: FontWeight.w800,
      color: AppColor.black);
}
