import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:metapos_owner/controller_model/controller/login_controller.dart';
import 'package:metapos_owner/ui/bottomNavBar/bottom_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../controller_model/model/login_model.dart';
import '../../utils/color_utils.dart';
import '../../utils/shared_preferences/prif_utils.dart';
import 'login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  LoginController loginController = Get.put(LoginController());

  @override
  void initState() {
    super.initState();
    _navigateUser();
  }

  Future<void> _navigateUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool isLoggedIn = prefs.getBool("isLoggedIn") ?? false;
    String? savedCode = prefs.getString("restaurantCode");

    await Future.delayed(Duration(seconds: 3));

    if (isLoggedIn && savedCode != null && savedCode.isNotEmpty) {

      // Restore Restaurants List from SharedPreferences
      String savedList = prifUtils.getRestaurantsList();

      if (savedList.isNotEmpty) {
        List<dynamic> decoded = jsonDecode(savedList);

        loginController.restaurantsList.clear();
        loginController.restaurantsList.addAll(
          decoded.map((e) => RestaurantsList.fromJson(e)).toList(),
        );
      }

      // Auto login → Home
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => BottomNavigation()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtils.lightBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Center(
          child: Image(image: AssetImage("assets/images/MetaPOS_Logo.png")),
        ),
      ),
    );
  }
}