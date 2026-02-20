import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/color_utils.dart';

class TextWidget extends StatelessWidget {
  final String title;
  final double? fontSize;
  final TextAlign? textAlign;
  final FontWeight? fontWeight;
  final Color? textColor;
  final TextDecoration? textDecoration;
  final Color? textDecorationColor;
  final double? letterSpacing;
  final TextDecorationStyle? textDecorationStyle;
  const TextWidget({super.key, required this.title, this.fontSize, this.textAlign, this.fontWeight, this.textColor, this.textDecoration, this.textDecorationColor, this.letterSpacing, this.textDecorationStyle});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: textAlign,
      overflow: TextOverflow.visible,
      style: GoogleFonts.montserrat(
        textStyle: TextStyle(
            fontSize:fontSize??14,
            fontWeight:fontWeight?? FontWeight.w500,
            color: textColor?? ColorUtils.white,
            decoration: textDecoration,
            decorationColor: textDecorationColor,
            decorationStyle: textDecorationStyle,
            letterSpacing: letterSpacing
        ),
      ),
    );
  }
}




class MyRichText extends StatelessWidget {
  final String? textOne;
  final String? textTwo;
  final String? textThree;
  final String? textFour;
  final Color? textColor;
  final Color? textTwoColor;
  final FontWeight? fontWeight;
  final double? fontSize;
  final TextAlign? textAlign;


  const MyRichText({
    super.key,
    this.textOne,
    this.textTwo,
    this.textThree,
    this.textColor,
    this.textTwoColor,
    this.fontWeight,
    this.fontSize, this.textFour, this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: textAlign!,
      text: TextSpan(
        children: <InlineSpan>[
          if (textOne != null)
            TextSpan(
              text: textOne,
              /// GoogleFonts.montserrat
              style: GoogleFonts.playfairDisplay(
                textStyle: TextStyle(
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                  color: textColor,
                ),
              ),
            ),
          if (textTwo != null)
            TextSpan(
              text: textTwo,
              style: GoogleFonts.playfairDisplay(
                textStyle: TextStyle(
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                  color: textTwoColor,
                ),
              ),
            ),
          if (textThree != null)
            TextSpan(
              text: textThree,
              style: GoogleFonts.playfairDisplay(
                textStyle: TextStyle(
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                  color: textColor,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
