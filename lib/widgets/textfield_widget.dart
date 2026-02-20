import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/color_utils.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final String? labelText;
  final String? hintText;
  final Widget? preFixIcon;
  final Widget? suffixIcon;
  final double borderRadius;
  final int? maxLength;
  final Color? enableBorderColor;
  final Color? hintTextColor;
  final Color? labelTextColor;
  final Color? focusBorderColor;
  final Color? cursorColor;
  final Color? disableBorderColor;

  final Color? fillColor;
  final Function(String)? onChanged;
  final String? Function(String?)? validation;
  final TextInputType? keyboardType;
  final bool? readOnly;
  final bool obscureText;
  final int? maxLines;
  final bool enabled;
  final void Function()? onTap;
  final void Function(String)? onFieldSubmitted;
  final List<TextInputFormatter>? inputFormatter;

  const TextFieldWidget({
    super.key,
    required this.controller,
    this.labelText,
    this.hintText,
    this.keyboardType,
    this.readOnly,
    this.maxLines,
    this.onTap,
    this.onFieldSubmitted,
    this.inputFormatter,
    required this.borderRadius,
    this.preFixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.validation,
    this.onChanged,
    this.maxLength,
    this.fillColor,
    this.floatingLabelBehavior,
    this.enableBorderColor,
    this.hintTextColor,
    this.labelTextColor,
    this.enabled = true, this.focusBorderColor, this.disableBorderColor, this.cursorColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Theme(
      data: theme.copyWith(
        inputDecorationTheme: const InputDecorationTheme(
          floatingLabelStyle: TextStyle(color: Colors.grey),
          labelStyle: TextStyle(color: Colors.grey),
          hintStyle: TextStyle(color: Colors.grey),
        ),
      ),
      child: TextFormField(
        enabled: enabled,
        maxLength: maxLength,
        onChanged: onChanged,
        cursorWidth: 1.5,
        validator: validation,
        obscureText: obscureText,
        controller: controller,
        onTap: onTap,
        // style: GoogleFonts.montserrat(
        //   textStyle: TextStyle(
        //       fontSize: 14,
        //       color:labelTextColor??ColorUtils.black,
        //       fontWeight: FontWeight.bold
        //   ),
        // ),
        keyboardType: keyboardType ?? TextInputType.text,
        cursorColor:cursorColor?? Colors.white,
        decoration: InputDecoration(
          labelText: labelText,
          enabled: enabled,
          labelStyle: GoogleFonts.montserrat(
            textStyle: TextStyle(
                fontSize: 15,
                color:labelTextColor??ColorUtils.black,
                fontWeight: FontWeight.bold
            ),
          ),
          floatingLabelBehavior: floatingLabelBehavior,
          counterText: '',
          hintText: hintText,
          prefixIcon: preFixIcon,
          suffixIcon: suffixIcon,
          // fillColor: Colors.black.withOpacity(0),
          fillColor: fillColor ?? Colors.transparent,
          filled: true,
          hintStyle: GoogleFonts.montserrat(
            textStyle: TextStyle(
                fontSize: 14,
                color:hintTextColor??ColorUtils.black,
                fontWeight: FontWeight.w400
            ),
          ),
      
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color:disableBorderColor??ColorUtils.black,
                width: 1.2),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color:enableBorderColor??ColorUtils.black.withOpacity(0.5),
                width: 1.2),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(
                color:focusBorderColor?? Colors.greenAccent, width: 1.2),
          ),
        ),
      ),
    );
  }
}