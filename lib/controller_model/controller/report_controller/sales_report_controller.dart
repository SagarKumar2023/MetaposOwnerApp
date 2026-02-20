import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:metapos_owner/controller_model/model/report_models/sales_report_model.dart';
import 'package:metapos_owner/utils/app_url.dart';
import 'package:metapos_owner/utils/shared_preferences/prif_utils.dart';

class SalesReportController extends GetxController{

  List<AllCategory> _allCategory = [];
  List<AllCategory> get allCategory => _allCategory;

  TableBookingData? _tableBookingData;
  TableBookingData? get tableBookingData => _tableBookingData;

  OrderPlatforms? _orderPlatforms;
  OrderPlatforms? get orderPlatforms => _orderPlatforms;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> getSalesReportData(Map<String,dynamic> body) async {

    _isLoading = true;
    update();

    String? token = prifUtils.getUserToken();
    var headers = {
      "Authorization" : "Bearer $token"
    };

    try{

      var response = await http.post(Uri.parse(AppUrl.salesReport),
        body: body,
        headers: headers,
      );

      if(response.statusCode == 200){

        log("Response Body: ${body}");
        log("Api Url => ${AppUrl.salesReport}");

        SalesReportModel salesReportModel = SalesReportModel.fromJson(jsonDecode(response.body));

        if(salesReportModel.error == "0"){

          _allCategory = salesReportModel.allCategory;
          _tableBookingData = salesReportModel.tableBookingData;
          _orderPlatforms = salesReportModel.orderPlatforms;

          log("Success Sales Report Loaded Successfully");
          Get.snackbar("Success", "Sales Data Loaded Successfully");

          _isLoading = false;
          update();

        }else{
          log("Error 1: ${salesReportModel.error}");
          Get.snackbar("Error 1", salesReportModel.error.toString());
        }

      }else{
        log("Error 2: ${response.statusCode}");
        Get.snackbar("Error 2", response.statusCode.toString());
      }

    }catch(e,stack){
      log("Exception :$e");
      log("StackTrace => $stack");
    }finally {
      _isLoading = false;
      update();
    }
  }

}