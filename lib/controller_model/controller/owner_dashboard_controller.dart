import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:metapos_owner/controller_model/model/owner_dashboard_model.dart';
import 'package:metapos_owner/utils/app_url.dart';

class OwnerDashboardController extends GetxController {

  Data? _ownerData;
  Data? get ownerData => _ownerData;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> getOwnerDashboard(Map<String,dynamic> body) async {

    _isLoading = true;
    update();
    String to = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiNTJiNDkwOWFjZjFjZTJlMjVmNzNiYWM3N2E2YTJhZmE0NWJmNWZhMjU5ZGUyZDgwNDY2OTAxMjhmNDQzY2Y0ZTY3YWI3M2NkYjJlMWNhYmEiLCJpYXQiOjE3NjI1MTM5NjkuOTkyNzQ3LCJuYmYiOjE3NjI1MTM5NjkuOTkyNzUsImV4cCI6MTc5NDA0OTk2OS45ODkwMDUsInN1YiI6IjcyNTkiLCJzY29wZXMiOltdfQ.yJGn7RugpkLOkfYCeXFyDs2t43L-QdwW0pE7T8_4OI3dHmvE4XegDuu-fdEeX7IjdM5UNcOryWkJpCrtmGZkyk9tQI6v-uwvLZDLoBvmVGCrev9K8fiksag8j8rihj3b2BOk2w2QaphQtzPxliW0GfOvaqCqUYPheWPf8XSuYgUOCCzAkC-iDhS2M8ssAhlbUSjLxLT3yRXe1bFCQHy3B6czg3fiRGbA3jf3x2aDk7iZltTsVyg5S-nfA7cS0Lt-z2869XOyG6OjMKCqYxSbXzrVtc7RxeywcHkjYER9Zeyn5IVZJrXX47LvPELlhlNZXyoqgnRs6v4yjF_EcSjCBrn22CPf0qUAQ92327q1z-XI-o9S4W4HcFQe8o6UoMnREylcVkKaiJly3s-3N3hq0CJZpnguz47sPUcnwFMh3PNggUHsQ59HSKKvqfglNwV_BDw9eE2bltRobgPycGeDox2oIibQQZ8pJpeXz73pcXtYgoDkb2Bxs5EUGFOA1Hnqg4txG8Yomcwui-WVl3xhIJUkg8kkPUDkedYON4pKCMwM0Fx6A7UlonJjs0hEv12YbgSecl0Mn86wuG4WSb_dEKqXz5ev1kIeyMfQKzDoJ_ewzThQEgaHSByBO_yOJ789-fwLV4m8qHDLh4tzKg3oXF24P03GdSW7fb6fm3kIlEM";
    var headers = {
      'Authorization': 'Bearer $to'
    };
    try {
    var response = await http.post(Uri.parse(AppUrl.ownerDashboard),
        body: body,
        headers: headers
    );

    if(response.statusCode == 200){
      log("API URL => ${AppUrl.ownerDashboard}");
      log("Response Body => ${response.body}");
      final ownerDashboardModel = OwnerDashboardModel.fromJson(jsonDecode(response.body));

      if(ownerDashboardModel.error == 0){
        _ownerData = ownerDashboardModel.data;
        log("Dashboard Loaded Successfully");
        Get.snackbar("Success", "Dashboard Loaded Successfully");

        _isLoading = false;
        update();

      }else {
        log("Error Loading Dashboard");
        Get.snackbar("Error1", "${ownerDashboardModel.error}");

        _isLoading = false;
        update();
      }
    }else{
      log("HTTp error: ${response.statusCode}");
      _isLoading = false;
      update();
      Get.snackbar("Error2", "${response.statusCode}");
      _isLoading = false;
      update();
    }
    } catch (e) {
      log("Exception Subtype=> $e");
      Get.snackbar("Error3", "Something went wrong");
     } finally {
       _isLoading = false;
       update();
     }
  }

}