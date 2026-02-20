import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:metapos_owner/ui/authintication/login_code.dart';
import 'package:metapos_owner/utils/app_url.dart';
import 'package:metapos_owner/utils/shared_preferences/prif_utils.dart';
import '../model/login_model.dart';

class LoginController extends GetxController {

  final List<RestaurantsList> _restaurantsList = [];
  List<RestaurantsList> get restaurantsList => _restaurantsList;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future getLoginDetails(body) async {
    _isLoading = true;
    update();

    try {
      var response = await http.post(
        Uri.parse(AppUrl.ownerLogin),
        body: body,
      );

      log("API => ${AppUrl.ownerLogin}");
      log("Response Body => ${response.body}");

      if (response.statusCode == 200) {
        final loginModel = LoginModel.fromJson(jsonDecode(response.body));

        if (loginModel.error == 0 && loginModel.user != null) {

          prifUtils.setUserId(loginModel.user!.id.toString());
          prifUtils.setName(loginModel.user?.name ?? "");
          prifUtils.setUserEmail(loginModel.user?.email ?? "");
          prifUtils.setUserAddress(loginModel.user?.address ?? "");
          prifUtils.setUserPhone(loginModel.user?.phone ?? "");
          prifUtils.setUserToken(loginModel.accessToken ?? "");
          prifUtils.setRestaurantsList(jsonEncode(loginModel.restaurantsList ?? []));

          _restaurantsList.clear();
          _restaurantsList.addAll(loginModel.restaurantsList ?? []);
          log("Restaurants loaded: ${_restaurantsList.length}");

          _isLoading = false;
          update();

          Get.offAll(() => const LoginCode());
          Get.snackbar("Success", "Enter Restaurant Code", duration: const Duration(seconds: 2));

        } else {
          log("Login failed or user object is null");
          log("Full Response: ${response.body}");

          _isLoading = false;
          update();

          Get.snackbar("Error", "Invalid user data from server");
        }
      } else {
        log("HTTP Error: ${response.statusCode}");
        _isLoading = false;
        update();
        Get.snackbar("Error", "Server error: ${response.statusCode}");
      }

    } catch (e, stack) {
      log("Exception: $e");
      log("StackTrace: $stack");
      Get.snackbar("Exception", e.toString(), duration: const Duration(seconds: 2));
    } finally {
      _isLoading = false;
      update();
    }
  }
}