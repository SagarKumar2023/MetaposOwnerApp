import 'dart:convert';
import 'dart:developer';
import "package:http/http.dart" as http;
import 'package:get/get.dart';
import 'package:metapos_owner/controller_model/model/report_models/staff_sales_report_model.dart';
import 'package:metapos_owner/utils/app_url.dart';

class StaffSalesReportController extends GetxController{

  List<Data> _data = [];
  List<Data> get data => _data;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<String> get paymentTypes {
    final types = data.map((e) => e.payMethod.toString()).toSet().toList();
    types.insert(0, "All Payments"); // optional
    return types;
  }


  Future<void> getStaffSalesReport(Map<String,dynamic> body) async{

    _isLoading = true;
    update();

    String to = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiNGM2ZGQwNjdlZTQxYzg1OTJlNWNiZDdjMWNmYjI5Mjc1NDAzOTIzNGUyOWM1ODk1ZmYwZmE0MWI0MWRiM2JjYjI1ZjgyNDkwMzMyMGFiZjMiLCJpYXQiOjE3NjQxNDc4MDMuODM4MTIyLCJuYmYiOjE3NjQxNDc4MDMuODM4MTI3LCJleHAiOjE3OTU2ODM4MDMuODM0MDYxLCJzdWIiOiI3MjU5Iiwic2NvcGVzIjpbXX0.wjXOice5RH2bB1dIGsipFbeh5lr6rtFZiktjJb81ak_avw0nQel2Q2F5LeVO6wZRhzFwFn0G38XqAeLXTYxqVfSenEKJxsLabywjLUdmMrpkO3Cwh2w8l4urDzD2MkV0oW4pNT8sYa2CmzdZCIiXZwEgEvDoop84wZVne_wL7l6pfj5XcOkrL1g6wcWZFFQq0oyWm5MUNf_G_CrVLwp9RNLX6S5xP4VvYaiIf7aOPJArxqYbvKSgP9ftV2zDcTHOIa-kSv596DwkTbxu3MmZJjk0TyziEzPbU-H_uwanKrbBwIIp4eNX1oxAa2mKN2skId1uNHsAs5YvUYCf9vYimoJI8rVOqzGmKJjAP5jy83yyLKo2UM8lUwCrfKuFUzb9oG6_dYRPwoZtT32TCdUDnLgeStTSbi53qac6r-COa7LYSPJMaN9GkaSOFE5vrdbEQw6THK4UZxCkQD2rcCg1yRgIYegzJSYhnrE-RMsBEpuz1SfyzzF7QKHxgZWUBcb4fLUkvkZfYilDjy5k4HaKAwU3OaawWtc3M8eDDYyADZoiBDotEGfTxgLlwVXrOgpt2VT--5JeZuWYRFnr8tdw8udhy2TqGXzvjTDS_HUYgtkBAzl0sIwWzUpo794HjwJES7UoMwwV7Ot8A-gMMovQgaNybycBY0Oup5aAlJpbbUc";
    var headers = {
      "Authorization": "Bearer $to"
    };
    
    //try{
      var response = await http.post(Uri.parse(AppUrl.staffSalesReport),
      body: body,
        headers: headers,
      );

      if(response.statusCode == 200){

        log("API URL => ${AppUrl.staffSalesReport}");
        log("Response body: ${response.body}");

        StaffSalesReportModel staffSalesReportModel = StaffSalesReportModel.fromJson(jsonDecode(response.body));

        if(staffSalesReportModel.error == 0){
          
          _data = staffSalesReportModel.data!;
          _isLoading = false;
          update();
          
          log("Success StaffSales Report Loaded Successfully");
          Get.snackbar("Success", "Staff Sales Report Loaded Successfully");
        }else {
          log("Error: ${staffSalesReportModel.error}");
          Get.snackbar("Error", staffSalesReportModel.error.toString(),duration: Duration(seconds: 3));
        }
      }else {
        log("Error: ${response.statusCode == 200}");
        Get.snackbar("Error", response.statusCode.toString());
      }

    // }catch (e,stack){
    //   log("Exception: $e");
    //   log("StackTrace: $stack");
    //   _isLoading = false;
    //   update();
    // }finally {
    //   _isLoading = false;
    //   update();
    // }

  }

}