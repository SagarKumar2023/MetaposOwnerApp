import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:metapos_owner/utils/color_utils.dart';
import 'package:metapos_owner/widgets/text_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../authintication/login.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  void _showLogoutDialog() {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorUtils.appBarBackground,
        leading: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ColorUtils.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Image(image: AssetImage("assets/icons/pos.webp")),
            ),
          ),
        ),
        title: TextWidget(
          title: "Hello,MetaPOS Pizzaria",
          textColor: ColorUtils.black,
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Row(
              children: [
                Icon(Icons.notifications_active_outlined, size: 27),
                SizedBox(width: 20),
                GestureDetector(
                  onTap: () {
                    _showLogoutDialog();
                  },
                  child: Icon(Icons.power_settings_new, size: 27),
                ),
              ],
            ),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: BoxBorder.all(color: Color(0xFFC62828), width: 5),
              ),
              child: Center(
                child: Image(
                  image: AssetImage("assets/icons/pos.webp"),
                  height: 150,
                  width: 150,
                ),
              ),
            ),
            SizedBox(height: 20),
            TextWidget(
              title: "Name",
              textColor: ColorUtils.black,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(height: 10),
            TextWidget(
              title: "MetaPOS Pizzaria",
              textColor: ColorUtils.black,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(height: 10),
            Divider(thickness: 0.5, color: ColorUtils.black),
            SizedBox(height: 10),
            TextWidget(
              title: "Mobile Number",
              textColor: ColorUtils.black,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(height: 10),
            TextWidget(
              title: "0974128976",
              textColor: ColorUtils.black,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(height: 10),
            Divider(thickness: 0.5, color: ColorUtils.black),
            SizedBox(height: 10),
            TextWidget(
              title: "Email ID",
              textColor: ColorUtils.black,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextWidget(
                  title: "owner@pizzaria.metapos.com.au",
                  textColor: ColorUtils.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                Icon(Icons.check_circle_outline, color: ColorUtils.grey),
              ],
            ),
            SizedBox(height: 10),
            Divider(thickness: 0.5, color: ColorUtils.black),
          ],
        ),
      ),
    );
  }
}
