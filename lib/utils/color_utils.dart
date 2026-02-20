import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class ColorUtils{
  static Color lightBackgroundColor = const Color(0xfffaeff4);
  static Color lightScreenBackground = const Color(0xffF9FAFB);
  static Color appBarBackground =  const Color(0xffeaafaf);
  static Color darkScreenBackground = const Color(0xff454D54);
  static Color darkBoxColor = const Color(0xff343A40);
  static Color lightAppColor = const Color(0xff007BFF);
  static Color darkAppColor = const Color(0xff3D688E);
  static Color orangeColor = const Color(0xffF79B39);
  static Color darkAppGreen =   const Color(0xffD3FF56);
  static Color lightAppGreen =   const Color(0xff0D330E);
  static Color green =   const Color(0xff3EA055);
  static Color purple =   const Color(0xff800080);
  static Color lightGreen =  const Color(0xff77DD77);
  static Color white = const Color(0xffFFFFFF);
  static Color black = const Color(0xff000000);
  static Color grey = const Color(0xff717171);
  static Color grapGrey =   const Color(0xff36454F);
  static Color yellow = const Color(0xffE8E148);
  static Color pink = const Color(0xffF858D5);
  static Color red = const Color(0xffE41B17);
  static Color orange =   const Color(0xffFF6700);
  static Color darkMaroon =   const Color(0xff659EC7);
  static Color blue =   const Color(0xff0020C2).withOpacity(0.6);
  static Color lightPrimaryColor = Color(0xFF4F46E5); // Indigo-600 (modern violetish blue)
  static Color lightWhiteBackgroundColor = Color(0xFFF9FAFB); // very light grey (almost white)
  static Color darkPrimaryColor = Color(0xFF818CF8); // Indigo-300 (soft bluish)
  static Color darkBackgroundColor = Color(0xFF111827); // dark blue-grey (almost black)

}

class AppGradients {

  static LinearGradient get lightBackground => LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFFCDF4B8), // Top color
      Color(0xFFF4F4F4), // Bottom color
    ],
  );
  static LinearGradient get darkThemeGradient =>  LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF000000),
      Color(0xFF434343),
    ],
    stops: [0.1, 1.0],
  );

  static LinearGradient get lightThemeGradient =>  LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF6FC3F7),
      Color(0xFFC2FDFF),
    ],
  );

  static LinearGradient get lightUiGradient => LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF0CCDA3),
      Color(0xFFC1FCD3),
    ],
  );

  static LinearGradient get circleGradient =>  LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFFA2BFD),
      Color(0xFF4D02C1),
    ],
  );

  static LinearGradient get darkUiGradient => LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF434343),
      Color(0xFF000000),
    ],
    stops: [0.1, 1.0],
  );

  static LinearGradient get buttonGradient => LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Color(0xFFFFF720),
      Color(0xFF3CD500),
    ],
    stops: [0.1, 1.0],
  );

  static LinearGradient get screenBackground => LinearGradient(
      colors: [
        Color(0xffe6fff7),
        Color(0xffefffff),
        Color(0xffefffff),
        Color(0xffefffff),
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter
  );
}
