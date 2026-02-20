import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart'as http;
import 'package:get/get.dart';
import 'package:metapos_owner/controller_model/model/report_models/staff_report_model.dart';
import 'package:metapos_owner/utils/app_url.dart';

class StaffReportController extends GetxController {

  List<StaffData> _staffData = [];
  List<StaffData> get staffData => _staffData;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> getStaffReport(Map<String, dynamic> body) async {

    _isLoading = true;
    update();

    String to = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMjdjNTQ2YmQ3OTNiZDRlN2EyZjUyZTUxMTc4NjU3Y2IzZmQ0MTM5NzQ2MjA0NDYwM2I4MjcwZjJjNThkNTg5NjY4ODJmOTUwZGJlNjY1YmIiLCJpYXQiOjE3NjQxMzI0NjMuNTIyNTY0LCJuYmYiOjE3NjQxMzI0NjMuNTIyNTY3LCJleHAiOjE3OTU2Njg0NjMuNTE3ODcsInN1YiI6IjcyNTkiLCJzY29wZXMiOltdfQ.IT3K4U1qEPWhFRMWSvdxPtqwk3r8le9Ad-EPCgmqEa5xJo5nVjk60oofzOfgT0PuFRLSFtlSXrnn_WiMSsv64wuHFb031ElyjAO74qS2zj_J411M899zrIFuO8LRHweY3FGg4cfiQfrSD8_RazLT4eNu00MVR8v_y0EKAWtLz88qf9HYeVv2rQ0xUf6d48syz52vm7phu9ZtXKzaqSamRvpjthd2J-B5j397XSRtOATdmUd18UfNDxGBwewy_mw1mvDMK5lhSgaL4xqIzqCvwhpRsKlHrc91T-ZSPgsYXrm56LhfGFVsMtVMeGI5FmAGB1lsbhliiMqLODCyPU3CoVATo0dN2L3bwSr9ZDxIEcOEKE4li_bx06qLNdrACWs0p3QzldIdLI2uD3-7qm5ZzBcu7LzxsfeZu0SGUf6ku660FBaJYv6pqzNEunu7UXqRYrc6XEFHbObm9XEMl9rJAq0XO2I91uM1k5KRft3lvxWrZDfanpLDAVIGCZ3BVCzX0rdx15gH5eK0WemJO6RGQDAPCMrDbkIvCwHqub1_Ak1A1QDdhnNVTpgIShkvJWliAyHXdXWfsjvwrMXfFOzgQfrn9UNKA3ful1fcwSYU3IxVcBpF5cKRZRS_jFG5_OpCIbzM0LeMVnJvQc0qRnPeN4JFzfNExn-tHK7jaNCLWTI';
    var headers = {
      "Authorization" : "Bearer $to"
    };
    
    try{
      var response = await http.post(Uri.parse(AppUrl.staffList),
      body: body,
        headers: headers,
      );

      if(response.statusCode == 200){

        log("API URL => ${AppUrl.staffList}");
        log("Response body: ${response.body}");

        StaffReportModel staffReportModel = StaffReportModel.fromJson(jsonDecode(response.body));

        if(staffReportModel.error == "0"){
          _staffData = staffReportModel.staffData!;
          _isLoading = false;
          update();

          log("Success Staff List Loaded Successfully");
          Get.snackbar("Success", "StaffList Loaded Successfully",duration: Duration(seconds: 3));
        }else{
          log("Error: ${staffReportModel.error}");
          Get.snackbar("Error", "${staffReportModel.error}");
          _isLoading = false;
          update();
        }
      }else {
        log("Error: ${response.statusCode}");
        Get.snackbar("Error", "${response.statusCode}");
        _isLoading = false;
        update();
      }
    }catch (e,stack){
      log("Exception: $e");
      log("StackTrace: $stack");
      _isLoading = false;
      update();
    }finally {
      _isLoading = false;
      update();
    }

  }

}