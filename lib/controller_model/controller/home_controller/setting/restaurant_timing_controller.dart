import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:metapos_owner/controller_model/model/home/setting/restaurant_timing_model.dart';
import 'package:metapos_owner/utils/app_url.dart';
import 'package:metapos_owner/utils/shared_preferences/prif_utils.dart';

class RestaurantTimingController extends GetxController {
  List<RestaurantsList> _restaurantsList = [];
  List<RestaurantsList> get restaurantsList => _restaurantsList;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  /// GET SPECIFIC RESTAURANT TIMING
  RestaurantsList? getRestaurantTimingById(int restaurantId) {
    try {
      return _restaurantsList.firstWhere((item) => item.id == restaurantId);
    } catch (e) {
      return null;
    }
  }

  /// LOAD TIMING API
  Future<void> getRestaurantTiming(Map<String, String> body) async {
    _isLoading = true;
    update();

    String token = prifUtils.getUserToken() ?? "";

    var headers = {"Authorization": "Bearer $token"};

    try {
      var response = await http.post(
        Uri.parse(AppUrl.restaurantTiming),
        body: body,
        headers: headers,
      );

      log("API => ${AppUrl.restaurantTiming}");
      log("Body => $body");
      log("Response => ${response.body}");

      if (response.statusCode == 200) {
        RestaurantTimingModel timingModel =
        RestaurantTimingModel.fromJson(jsonDecode(response.body));

        if (timingModel.error == "0" && timingModel.restaurantsList != null) {
          _restaurantsList = timingModel.restaurantsList!;
          log("✔ Loaded Timing Count: ${_restaurantsList.length}");
          Get.snackbar("Success", "Timing Loaded Successfully");
        } else {
          log("API Error: ${timingModel.error}");
          Get.snackbar("Error", "Invalid API Response");
        }
      } else {
        log("HTTP Error: ${response.statusCode}");
        Get.snackbar("HTTP Error", response.statusCode.toString());
      }
    } catch (e, stack) {
      log("Exception: $e");
      log("Stack: $stack");
      Get.snackbar("Exception", e.toString());
    } finally {
      _isLoading = false;
      update();
    }
  }

  /// UPDATE RESTAURANT PUBLISH STATUS
  Future<bool> updateRestaurantTiming({
    required int restaurantId,
    required int published, // 1 = Open, 2 = Closed
  }) async {
    String token = prifUtils.getUserToken() ?? "";
    var headers = {"Authorization": "Bearer $token"};

    var body = {
      "restaurant_id": restaurantId.toString(),
      "published": published.toString(),
    };

    try {
      var response = await http.post(
        Uri.parse(AppUrl.restaurantTiming), // <-- make sure backend has separate endpoint
        body: body,
        headers: headers,
      );

      log("Update API => ${AppUrl.restaurantTiming}");
      log("Body => $body");
      log("Response => ${response.body}");

      if (response.statusCode == 200) {
        var jsonResp = jsonDecode(response.body);
        if (jsonResp["error"] == "0") {
          // Update local list
          int index = _restaurantsList.indexWhere((element) => element.id == restaurantId);
          if (index != -1) {
            _restaurantsList[index].published = published;
            update();
          }
          Get.snackbar("Success", "Restaurant status updated");
          return true;
        } else {
          Get.snackbar("Error", jsonResp["message"] ?? "Failed to update status");
          return false;
        }
      } else {
        Get.snackbar("HTTP Error", response.statusCode.toString());
        return false;
      }
    } catch (e, stack) {
      log("Exception: $e");
      log("Stack: $stack");
      Get.snackbar("Exception", e.toString());
      return false;
    }
  }
}
