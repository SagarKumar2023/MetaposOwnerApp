import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:metapos_owner/controller_model/controller/login_controller.dart';
import 'package:metapos_owner/ui/bottomNavBar/bottom_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/color_utils.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/text_widget.dart';

class LoginCode extends StatefulWidget {
  const LoginCode({super.key});

  @override
  State<LoginCode> createState() => _LoginCodeState();
}

class _LoginCodeState extends State<LoginCode> {
  final LoginController loginController = Get.find<LoginController>();
 // LoginController loginController = Get.put(LoginController());
  final TextEditingController restaurantCode = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  Future<void> _handleNext() async {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      setState(() => _isLoading = true);

      final enteredCode = restaurantCode.text.trim();
      final matchedRestaurant = loginController.restaurantsList.
      firstWhereOrNull((restaurant) =>
        restaurant.businessCode?.toLowerCase() == enteredCode.toLowerCase(),
      );

      if (matchedRestaurant != null) {
        debugPrint("Business Code Found: ${matchedRestaurant.businessCode}");

        // SAVE RESTAURANT CODE HERE
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool("isLoggedIn", true);
        await prefs.setString("restaurantCode", enteredCode);


        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const BottomNavigation()),
        );
      } else {
        Get.snackbar("Invalid restaurant code...", "Please Enter CorrectCode",duration: Duration(seconds: 3));
      }

      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtils.lightBackgroundColor,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding:
                const EdgeInsets.only(top: 200, left: 50, right: 50, bottom: 20),
                child: Image.asset("assets/images/MetaPOS_Logo.png"),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      title: "Restaurant Code",
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      textColor: ColorUtils.black,
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: restaurantCode,
                      cursorColor: ColorUtils.black,
                      decoration: InputDecoration(
                        hintText: "Enter restaurant code",
                        hintStyle: TextStyle(color: ColorUtils.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Please enter restaurant code";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              TextWidget(
                title: "If you have any problem please contact us",
                textColor: ColorUtils.black,
                fontWeight: FontWeight.w600,
              ),
              TextWidget(
                title: "www.metapose.com.au",
                textColor: ColorUtils.red,
                fontWeight: FontWeight.w700,
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: ButtonWidget(
                  navigateTo: _isLoading ? null : _handleNext,
                  buttonColor: _isLoading ? ColorUtils.grey : ColorUtils.red,
                  buttonName: _isLoading ? "Please wait..." : "Next",
                  fontsize: 18,
                  borderRadius: 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
