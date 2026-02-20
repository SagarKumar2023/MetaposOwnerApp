import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:metapos_owner/controller_model/model/report_models/product_report_model.dart';
import 'package:metapos_owner/utils/app_url.dart';

class ProductReportController extends GetxController {

  List<TopProduct> _topProduct = [];
  List<TopProduct> get topProduct  => _topProduct;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> getProductReport(Map<String,dynamic> body) async {

    _isLoading = true;
    update();
    String to = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiZWQ1Yjk0OGFmMjk2ZDIzNDNhOGE3ZTU0YjViOTQ1NjFhYzkxMDcwYjc3ZmRlOGZhZTE5YjQwMjVjM2ExYjgwMzY2YmEyN2YwZGFjOTc3MzkiLCJpYXQiOjE3NjQwNDg3ODkuOTY5MzA4LCJuYmYiOjE3NjQwNDg3ODkuOTY5MzExLCJleHAiOjE3OTU1ODQ3ODkuOTY0OTIxLCJzdWIiOiI3MjU5Iiwic2NvcGVzIjpbXX0.y4UECePQPAerss7Wvd-vkAP6wSIZMXGxaV8lTWBvgjHuz1W0wq361G545Acq5NNk7qsOi8S2qpNmFBhDXNKZXj1A6aNiBLedjCnCRMZBqI5mHRD9nG-LSsamywWjUia8mJBYinC6YfTxbRyBWDMNmt7IG7UkopRClUUIDVXLf8bU609TteGlZRUBqJ8KQV2wxZxckWKOBOPpeqpD4uuc1pxtlZlI4WVmcjnzWbsZPCH3bfG76ltqF3Z5XeCi19uXIR5UEwjwRJh-UktxNOByF5OQcSUsMo9WQNLOahX9lifhVGy_n0wA3xx-7FOH80JRvOCPqOw2G3lL_bU0wTa5giP2XDaZhYhkItH8ceqy5-gTNkhneto-WEV6eHmO0QWXoAwvZ9ijQ5NlqkW6jd5A-tllCKm-sWsjbcBGU0pt_ARDuQMj6w3oeUUIhtnHRaJ0eUa-jkq3w3eqpkr-cTGc2hAXyNN4Mn18T_0Auxehc-peAoy0v0Eh1dDgFgficqp6u0DUjQsb814n_egFfCtodasC20wh_0b2LP0hgZ3K_kl1y7ZzDR7vl7jBs8sylELDRLg4H859OZBkgP8nJ3H5NTolQh6qXsNE0tFgn0HyYVQPF3DfDiA2_HlzlRVi4tTRyLcQIOckbkqcILATphVbTbMlBOb-9lbhkXswLrwQIjs";
    var headers = {
      "Authorization": 'Bearer $to',
    };

    try{
      var response = await http.post(Uri.parse(AppUrl.productReport),
      body: body,
        headers: headers,
      );
      if(response.statusCode == 200){
        log("API URL: ${AppUrl.productReport}");
        log("Response Body: ${response.body}");

        ProductReportModel productReportModel = ProductReportModel.fromJson(jsonDecode(response.body));

        if(productReportModel.error == 0){
          _topProduct = productReportModel.topProducts;

          log("Product report loaded Successfully");
          Get.snackbar("Success", "Product report loaded");

          _isLoading = false;
          update();
        }else{
          log("Error: Fail to load Product Model");
          Get.snackbar("Error", "${productReportModel.error}");
          _isLoading = false;
          update();
        }
      }else{
        log("HTTP Error: ${response.statusCode}");
        Get.snackbar("HTTP Error", "${response.statusCode}");
      }

    }catch (e,stack) {
      log("Exception: $e");
      log("StackTrace: $stack");
      Get.snackbar("Exception", e.toString(),duration: Duration(seconds: 3));
    }finally{
      _isLoading = false;
      update();
    }
  }

}