import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:metapos_owner/controller_model/controller/login_controller.dart';
import 'package:metapos_owner/utils/color_utils.dart';
import 'package:metapos_owner/widgets/button_widget.dart';
import 'package:metapos_owner/widgets/text_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../bottomNavBar/home/home.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String? selectedValue;
  bool _obscurePassword = true;

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  void _handleLogin() async {
    if (selectedValue == null) {
      Get.snackbar(
        "Role Required",
        "Please select either Owner or Manager.",
        duration: Duration(seconds: 3),
      );
      return;
    }

    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();

      final body = {
        "email": emailController.text.trim(),
        "password": passwordController.text.trim(),
        "role": selectedValue,
      };

      /// Call API
      loginController.getLoginDetails(body).then((value) async {

        if (value == true) {  // 👈 When login is successful
          SharedPreferences prefs = await SharedPreferences.getInstance();

          await prefs.setBool("isLoggedIn", true);
          await prefs.setString("email", body["email"]!);
          await prefs.setString("role", body["role"]!);

          /// If you have token from API:
          /// await prefs.setString("token", loginController.token);

          Get.offAll(() => Home());  // Navigate to Home Screen
        }
      });
    }
  }


  LoginController loginController = Get.put(LoginController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtils.lightBackgroundColor,
      body:GetBuilder<LoginController>(
          builder: (controller){
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 200, left: 50, right: 50, bottom: 50),
                    child: Image.asset("assets/images/MetaPOS_Logo.png"),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: RadioListTile(
                            visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                            value: "owner",
                            groupValue: selectedValue,
                            onChanged: (value) {
                              setState(() {
                                selectedValue = value.toString();
                              });
                            },
                            title: const Text(
                              "OWNER",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            activeColor: ColorUtils.red,
                          ),
                        ),
                        Expanded(
                          child: RadioListTile(
                            visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                            value: "manager",
                            groupValue: selectedValue,
                            onChanged: (value) {
                              setState(() {
                                selectedValue = value.toString();
                              });
                            },
                            title: const Text(
                              "MANAGER",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            activeColor: ColorUtils.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          title: "Email ID",
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          textColor: ColorUtils.black,
                        ),
                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: "Enter your email",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter your email";
                            } else if (!isValidEmail(value)) {
                              return "Please enter a valid email";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextWidget(
                          title: "Password",
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          textColor: ColorUtils.black,
                        ),
                        TextFormField(
                          controller: passwordController,
                          obscureText: _obscurePassword,
                          decoration: InputDecoration(
                            hintText: "Enter your password",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: ColorUtils.grey,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter your password";
                            } else if (value.length < 6) {
                              return "Password must be at least 6 characters";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 50),
                        ButtonWidget(
                          navigateTo: _handleLogin,
                          buttonColor: selectedValue == null
                              ? Colors.grey.shade400
                              : ColorUtils.red,
                          buttonName: "Submit",
                          borderRadius: 10,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
          }
      )
    );
  }
}
