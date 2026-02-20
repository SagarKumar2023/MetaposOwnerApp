// import 'package:flutter/material.dart';
// import 'package:o2cure_project/provider/theme_provider.dart';
// import 'package:o2cure_project/utils/color_utils.dart';
// import 'package:provider/provider.dart';
// import 'package:toggle_switch/toggle_switch.dart';
//
// class ThemeToggleSwitch extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final themeProvider = Provider.of<DarkThemeProvider>(context);
//     return Padding(
//       padding: const EdgeInsets.only(right: 8),
//       child: ToggleSwitch(
//         minWidth: 55.0,
//         minHeight: 30,
//         cornerRadius: 20.0,
//         activeBgColors:  [
//           [ColorUtils.appColor],
//           [ColorUtils.appColor]
//         ],
//         activeFgColor:themeProvider.darkTheme ?  ColorUtils.black: ColorUtils.white,
//         inactiveBgColor:themeProvider.darkTheme ?  ColorUtils.black: ColorUtils.black,
//         inactiveFgColor:themeProvider.darkTheme ?  ColorUtils.black: ColorUtils.white,
//         initialLabelIndex: themeProvider.darkTheme ? 0 : 1,
//         totalSwitches: 2,
//         labels: const ['Dark', 'Light'],
//         radiusStyle: true,
//         onToggle: (index) {
//           themeProvider.darkTheme = index == 0; // 0 for Dark, 1 for Light
//           print('switched to: $index');
//         },
//       ),
//     );
//   }
// }
///=============================================================================

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:toggle_switch/toggle_switch.dart';
//
// import '../utils/color_utils.dart';
//
// class ThemeToggleSwitch extends ConsumerWidget {
//   const ThemeToggleSwitch({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final themeState = ref.watch(darkThemeProvider);
//     final themeNotifier = ref.read(darkThemeProvider.notifier);
//
//     final isDark = themeState.value ?? false;
//
//     return Padding(
//       padding: const EdgeInsets.only(right: 8),
//       child: ToggleSwitch(
//         minWidth: 55.0,
//         minHeight: 30,
//         cornerRadius: 20.0,
//         activeBgColors: [
//           [ColorUtils.lightAppColor],
//           [ColorUtils.lightAppColor]
//         ],
//         activeFgColor: isDark ? ColorUtils.black : ColorUtils.white,
//         inactiveBgColor: isDark ? ColorUtils.black : ColorUtils.black,
//         inactiveFgColor: isDark ? ColorUtils.black : ColorUtils.white,
//         initialLabelIndex: isDark ? 0 : 1,
//         totalSwitches: 2,
//         labels: const ['Dark', 'Light'],
//         radiusStyle: true,
//         onToggle: (index) async {
//           await themeNotifier.toggleTheme(index == 0);
//         },
//       ),
//     );
//   }
// }
