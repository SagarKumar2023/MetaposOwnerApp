import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:metapos_owner/widgets/text_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ui/authintication/login.dart';
import '../utils/color_utils.dart';

class CustomWidgets {

  void showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Center(
            child: TextWidget(
              title: "LOGOUT",
              fontSize: 18,
              textColor: ColorUtils.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: TextWidget(
            title: "Are you sure you want to logout from Metapos Owner?",
            textAlign: TextAlign.center,
            textColor: ColorUtils.black,
            fontWeight: FontWeight.w600,
          ),
          contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
          actionsPadding: EdgeInsets.zero,
          actions: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 20),
                const Divider(thickness: 1, height: 1, color: Colors.black),
                IntrinsicHeight(
                  child: Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(context); // close dialog
                          },
                          child: TextWidget(
                            title: "Cancel",
                            textColor: ColorUtils.black,
                          ),
                        ),
                      ),
                      const VerticalDivider(
                        thickness: 1,
                        width: 1,
                        color: Colors.black,
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: () async {
                            Navigator.pop(context); // close dialog
                            SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                            await prefs.setBool("isLoggedIn", false);
                            await prefs.remove("restaurantCode");
                            // Go to login screen
                            Get.offAll(() => const Login());
                          },
                          child: TextWidget(
                            title: "Logout",
                            textColor: Colors.redAccent,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget buildCardInfo(String title1, String title2) {
    return Column(
      children: [
        TextWidget(
          title: title1,
          textColor: ColorUtils.black,
          fontWeight: FontWeight.w700,
        ),
        TextWidget(
          title: title2,
          textColor: ColorUtils.green,
          fontWeight: FontWeight.w600,
        ),
      ],
    );
  }

  Widget buildOrderType(
      Color color,
      String title,
      String amount,
      String orderCount,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          children: [
            Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(shape: BoxShape.circle, color: color),
            ),
            const SizedBox(width: 5),
            TextWidget(
              title: title,
              textColor: ColorUtils.black,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
        TextWidget(
          title: amount,
          textColor: ColorUtils.red,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        TextWidget(
          title: orderCount,
          textColor: ColorUtils.black,
          fontSize: 10,
        ),
      ],
    );
  }

  Widget buildPlatform(
      Color color,
      String title,
      String amount,
      String orderCount,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          children: [
            Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(shape: BoxShape.circle, color: color),
            ),
            SizedBox(width: 5),
            TextWidget(
              title: title,
              textColor: ColorUtils.black,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
        TextWidget(
          title: amount,
          textColor: ColorUtils.red,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        TextWidget(
          title: orderCount,
          textColor: ColorUtils.black,
          fontSize: 10,
        ),
      ],
    );
  }

  Widget buildPaymentType(
      Color color,
      String title,
      String amount,
      String orderCount,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          children: [
            Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(shape: BoxShape.circle, color: color),
            ),
            SizedBox(width: 5),
            TextWidget(
              title: title,
              textColor: ColorUtils.black,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
        TextWidget(
          title: amount,
          textColor: ColorUtils.red,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        TextWidget(
          title: orderCount,
          textColor: ColorUtils.black,
          fontSize: 10,
        ),
      ],
    );
  }

  Widget buildTableBooking(
      Color color,
      String title,
      String amount,
      String orderCount,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          children: [
            Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(shape: BoxShape.circle, color: color),
            ),
            SizedBox(width: 5),
            TextWidget(
              title: title,
              textColor: ColorUtils.black,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
        TextWidget(
          title: amount,
          textColor: ColorUtils.red,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        TextWidget(
          title: orderCount,
          textColor: ColorUtils.black,
          fontSize: 10,
        ),
      ],
    );
  }

  Widget buildTopCategory(String title) {
    return TextWidget(
      title: title,
      textColor: ColorUtils.black,
      fontSize: 15,
      fontWeight: FontWeight.w600,
    );
  }

  Widget textWidget(String title) {
    return TextWidget(
      title: title,
      fontWeight: FontWeight.w700,
      textColor: ColorUtils.black,
    );
  }

  Widget allRestaurant(Color color, String title) {
    return Row(
      children: [
        Container(
          height: 12,
          width: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: 10,),
        TextWidget(
          title: title,
          fontSize: 11,
          fontWeight: FontWeight.w500,
          textColor: ColorUtils.black,
        ),
      ],
    );
  }


}