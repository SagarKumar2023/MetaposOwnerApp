import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart'as http;
import 'package:get/get.dart';
import 'package:metapos_owner/controller_model/model/report_models/terminal_report_model.dart';
import 'package:metapos_owner/utils/app_url.dart';

class TerminalReportController extends GetxController{

  List<Data> _data = [];
  List<Data> get data => _data;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<String> get paymentTypes {
    final types = data.map((e) => e.payMethod ?? "").toSet().toList();
    types.removeWhere((e) => e.isEmpty);
    types.insert(0, "All Payments");
    return types;
  }

  Future<void> getTerminalReports(Map<String,dynamic> body) async {

    _isLoading = true;
    update();
    String to = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiOTI3MGEzZDM1OWQzYTMwYWMyOGM1MWQ5NDc3NWUwYjE0ZjAyODUyYjlhOWU2ZTJiODI0NGU5MWE0YWIyODNiMjkwNjc3MmYwNTVjYTc5MDgiLCJpYXQiOjE3NjQyMTg0MDAuMDk5ODIsIm5iZiI6MTc2NDIxODQwMC4wOTk4MjMsImV4cCI6MTc5NTc1NDQwMC4wOTYwMDUsInN1YiI6IjcyNTkiLCJzY29wZXMiOltdfQ.IqAnJ5dgDyTYA72b-3eFAfB31LadqoIrKALNugpeGxOUpTbj97R74rJQgPqAb9BjIPXIHVdHpwj-muNwJAzoj5t0q0SnEti8MRxuoWHhOLUkhP4ZUizkbKJCYCUeuCBzZb1gVgdReUxbLL1S7GivyKDOxQ0Qtf5k6G3hLgT6R8B353kOSE0CIgtEgbTacW-IM0uRveWkj1OM6uI_m-PIZn-rY_nJx0MajlNnTmysVDF56Yabcji6KKpqo8pqF_rmLSHhjX8T3Mx26G5EflvvVgLj_VcF1fKRJwFWgkRI-FAC01_mCQGaugitCMAEDwxwuWmrauJa0JMOq83HDwui_WEShy5be-xTNYk20q3wOPnSzg4BDYGBnj8MQyYEn2l4-k__CebAtNC6KUwVFR8I1kbsW-J19I9gINzyg5H3Mj8_UqFNievc_4Li8y9P3ZdvNISzXVAcW4uoItFYuUu4giW4XWMLk6616CZY88qwxAttrv-zr85l8jhwS5nsjLpvx2KGocozpXsxirCtGkDHgEYELtGh9PZyRH6u3WihQFKTyfqBBcX_l_fe7JPqAhNxRL1KwTL6ca7jbmfDxES2eUTH7j5BJ7SfrPUXBvYdOyfV04C206dtdKqNPetFnil_lgp5bomOQ40NLR-QgYPQc1yPxTtEKnmXSEOIuehOObU";
    var headers = {
      "Authorization": "Bearer $to",
    };
    
   // try{
      var response = await http.post(Uri.parse(AppUrl.terminalReport),
      body: body,
        headers: headers,
      );

      if(response.statusCode == 200){

        log("API URL => ${AppUrl.terminalReport}");
        log("Response Body => ${response.body}");

        TerminalReportModel terminalReportModel = TerminalReportModel.fromJson(jsonDecode(response.body));

        if(terminalReportModel.error == 0) {
          _data = terminalReportModel.data!;

          _isLoading = false;
          update();

          log("Terminal data Loaded Successfully");
          Get.snackbar("Success", "Terminal Data Loaded Successfully",duration: Duration(seconds: 3));
        }else {
          log("Error: ${terminalReportModel.error}");
          Get.snackbar("Error", terminalReportModel.error.toString(),duration: Duration(seconds: 3));
        }
      }else {
        log("Error: ${response.statusCode}");
        Get.snackbar("Api Error", response.statusCode.toString(),duration: Duration(seconds: 3));
      }
      
    // }catch(e,stack){
    //   log("Exception: $e");
    //   log("StackTrace: $stack");
    //   _isLoading = false;
    //   update();
    // }finally{
    //   _isLoading = false;
    //   update();
    // }
    
  }

}