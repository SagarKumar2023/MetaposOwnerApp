import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:metapos_owner/ui/bottomNavBar/home/home.dart';
import 'package:metapos_owner/ui/bottomNavBar/profile/profile_Screen.dart';
import 'package:metapos_owner/ui/bottomNavBar/report/report_screen.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {

  int currentScreen = 1;

  List screenList = [
    ProfileScreen(),
    Home(),
    ReportScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screenList[currentScreen],
      bottomNavigationBar: CircleNavBar(
          activeIndex: currentScreen,
          activeIcons: const [
            Icon(Icons.person, color: Colors.white,size: 30,),
            Icon(Icons.home, color: Colors.white,size: 30),
            Icon(Icons.receipt_long_outlined, color: Colors.white,size: 30),
          ],
        inactiveIcons: const [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.person, color: Colors.white, size: 20),
              SizedBox(height: 4),
              Text(
                "Profile",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 12),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.home, color: Colors.white, size: 20),
              SizedBox(height: 4),
              Text(
                "Home",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 12),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.receipt_long_outlined, color: Colors.white, size: 20),
              SizedBox(height: 4),
              Text(
                "Report",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 12),
              ),
            ],
          ),
        ],
        color: Colors.white,
        circleColor: Colors.white,
        height: 60,
        circleWidth: 60,
        onTap: (index){
            setState(() {
              currentScreen = index;
            });
        },
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
        cornerRadius: const BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
          bottomRight: Radius.circular(24),
          bottomLeft: Radius.circular(24),
        ),
        shadowColor: Colors.grey,
        circleShadowColor: Colors.grey,
        elevation: 5,
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [ Color(0xFFC62828), Color(0xFFC62828) ],
        ),
        circleGradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [ Color(0xFFC62828), Color(0xFFC62828) ],
        ),
      )
    );
  }
}