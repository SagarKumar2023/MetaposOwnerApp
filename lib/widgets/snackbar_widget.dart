// import 'package:flutter/material.dart';
//
// class AppSnackBar {
//   /// ✅ Generic method (if you want full control)
//   static void show({
//     required BuildContext context,
//     required String message,
//     required AnimatedSnackBarType type,
//     Duration duration = const Duration(seconds: 4),
//   }) {
//     AnimatedSnackBar.material(
//       message,
//       type: type,
//       mobileSnackBarPosition: MobileSnackBarPosition.top,
//       duration: duration,
//       animationCurve: Curves.elasticInOut,
//     ).show(context);
//   }
//
//   /// ✅ Success message
//   static void success(BuildContext context, String message) {
//     AnimatedSnackBar.material(
//       message,
//       type: AnimatedSnackBarType.success,
//       mobileSnackBarPosition: MobileSnackBarPosition.top,
//       duration: const Duration(seconds: 3),
//       animationCurve: Curves.easeInOutBack,
//     ).show(context);
//   }
//
//   /// ❌ Error message
//   static void error(BuildContext context, String message) {
//     AnimatedSnackBar.material(
//       message,
//       type: AnimatedSnackBarType.error,
//       mobileSnackBarPosition: MobileSnackBarPosition.top,
//       duration: const Duration(seconds: 3),
//       animationCurve: Curves.easeInOutBack,
//     ).show(context);
//   }
//
//   /// ⚠️ Warning message
//   static void warning(BuildContext context, String message) {
//     AnimatedSnackBar.material(
//       message,
//       type: AnimatedSnackBarType.warning,
//       mobileSnackBarPosition: MobileSnackBarPosition.bottom,
//       duration: const Duration(seconds: 3),
//       animationCurve: Curves.easeInOutBack,
//     ).show(context);
//   }
// }