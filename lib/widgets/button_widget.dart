import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:google_fonts/google_fonts.dart';
import '../utils/color_utils.dart';

class ButtonWidget extends StatelessWidget {
  final VoidCallback? navigateTo;
  final String buttonName;
  final double? height;
  final double? width;
  final Color? buttonColor;
  final Color? buttonTextColor;
  final double? fontsize;
  final double? borderRadius;
  final EdgeInsetsGeometry? margin;

  const ButtonWidget({
    super.key,
    required this.navigateTo,
    required this.buttonName,
    this.margin,
    this.height,
    this.width,
    this.buttonColor,
    this.fontsize,
    this.borderRadius,
    this.buttonTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: navigateTo,
      child: Container(
        padding: EdgeInsets.only(left: 8,right: 8),
        height: height ?? 45,
        margin: margin,
        width: width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius ?? 45),
            color: buttonColor ?? ColorUtils.grey
        ),
        child: Center(
          child: Text(
            buttonName,
            style: GoogleFonts.robotoSlab(
              textStyle: TextStyle(
                  color: buttonTextColor ?? ColorUtils.white,
                  fontSize: fontsize ?? 16,
                  fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}