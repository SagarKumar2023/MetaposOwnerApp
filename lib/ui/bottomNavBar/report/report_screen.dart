import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:metapos_owner/ui/bottomNavBar/report/all_reports/cash_drawer.dart';
import 'package:metapos_owner/ui/bottomNavBar/report/all_reports/customer_report.dart';
import 'package:metapos_owner/ui/bottomNavBar/report/all_reports/food_track_report.dart';
import 'package:metapos_owner/ui/bottomNavBar/report/all_reports/product_reports.dart';
import 'package:metapos_owner/ui/bottomNavBar/report/all_reports/sales_reports.dart';
import 'package:metapos_owner/ui/bottomNavBar/report/all_reports/staff_hour_report.dart';
import 'package:metapos_owner/ui/bottomNavBar/report/all_reports/staff_list.dart';
import 'package:metapos_owner/ui/bottomNavBar/report/all_reports/staff_report.dart';
import 'package:metapos_owner/ui/bottomNavBar/report/all_reports/terminal_reports.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../utils/color_utils.dart';
import '../../../widgets/text_widget.dart';
import '../../authintication/login.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  var reportLogo = [
    "assets/icons/sale-report.png",
    "assets/icons/product_report.png",
    "assets/icons/customer_report.png",
    "assets/icons/staff-hour_report.png",
    "assets/icons/staff_report.png",
    "assets/icons/terminal_report.png",
    "assets/icons/food-track_report.png",
    "assets/icons/staff_list.png",
    "assets/icons/cash_Drawer.png",
  ];

  var reportName = [
    "Sales Reports",
    "Product Reports",
    "Customer Reports",
    "Staff Hour Reports",
    "Staff Reports",
    "Terminal Reports",
    "Food Track Reports",
    "Staff List",
    "Cash Drawer",
  ];

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
      backgroundColor: ColorUtils.lightBackgroundColor,
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
          title: "MetaPOS Pizzaria",
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
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          physics: BouncingScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Two columns
            crossAxisSpacing: 1.0,
            mainAxisSpacing: 1.0,
            childAspectRatio: 1.0, // Square items
          ),
          itemCount: reportLogo.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                switch (index) {
                  case 0:
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SalesReports()),
                    );
                    break;
                  case 1:
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProductReports()),
                    );
                  case 2:
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CustomerReport()),
                    );
                  case 3:
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StaffHourReport(),
                      ),
                    );
                  case 4:
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => StaffReport()),
                    );
                  case 5:
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TerminalReports(),
                      ),
                    );
                  case 6:
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FoodTrackReport(),
                      ),
                    );
                  case 7:
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => StaffList()),
                    );
                  case 8:
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CashDrawer()),
                    );
                }
              },
              child: Container(
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withValues(alpha: 0.5),
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: Offset(1, 0),
                      blurStyle: BlurStyle.normal,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFC62828),
                      ),
                      child: Center(
                        child: Image(
                          image: AssetImage(reportLogo[index]),
                          height: 70,
                          width: 70,
                          color: ColorUtils.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextWidget(
                      title: reportName[index],
                      textColor: ColorUtils.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
