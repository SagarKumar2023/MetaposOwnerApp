import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:metapos_owner/controller_model/model/home/setting/product_model.dart';
import 'package:http/http.dart'as http;
import 'package:metapos_owner/utils/app_url.dart';
class ProductController extends GetxController{

  List<Data> _data = [];
  List<Data> get data => _data;

  List<Data> _originalData = [];
  List<Data> get originalData => _originalData;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future getProductReport(body) async {

    _isLoading = true;
    update();

    String token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiZTQzYmY5ZDA2ZDVkMTUxMDA0NWFkY2QwMDg1NWUyZDc0MjdiOWM4MmMxMjE4OTliNjUxMWEzN2IxOGJiZTRhNTkyMjQ5NjdkNjE0NTI2NzkiLCJpYXQiOjE3NjQ2NTM0OTYuNTU4MzcsIm5iZiI6MTc2NDY1MzQ5Ni41NTgzNzMsImV4cCI6MTc5NjE4OTQ5Ni41NTQ3ODYsInN1YiI6IjcyNTkiLCJzY29wZXMiOltdfQ.OKFXt9evEJrQ9tPCW3DMySyvCcdpeM8Q8ZbcqwlKhBxakl2oJW8lBioq9bF1q32pfktoumNbkCZobNX3QEGeX6Kaup51-yroYkW9AhmCuI-xltSwjvZDWrtSq9xH3b_2V4ruDKoxqJv6O0xTu3gKuWFSvSKpyXfBl5N59slV6MsXORzTBs2Vm6EqWfwwTNoO8MtPOw35a2bKXlYcbIW0PLeMEDTgDHScqR0O5XEjLc8-5v81Fh-Sg8foPVQqpkfh9E7tbdwl0TJoz5EnS3NNimDxgpk6c8zXdc-duqdh0pxwvBF_3Mjgns9f7qDXwkwvX_Nz1OtXlejILqjyvpkjCvgLXzk19zfKnCXlluTNaiLfmdNibXbIZmAgRA8lBK0EOn0aDBA8eaCoMcY1Y1kZOLLDFQ-9c3o1_iFk0pMrzb95l8h3c0SiENsvGRq9aYKgEx49TR1F47poZPpjGb1czv9DsuRSNHT49kVlm9JA5v4akrMyO0L6WPRHTG9yFW-5YNu1UUbYfORsvjtL3ZZmSn_isu0OA5eVFEjXNYoEZ6yQWcWM1j8rkPq13Q-nT6vKQLPv-BN26jzj52xqZ6rLEaZRh4_NvIHPANMwh0zlx3UnI82ghEOMLoexHuX6VuoQT7SRqiVhYLf7HsxL3KaCU6cR6IBpU_qgRnTx05LTxjM";
    var headers = {
      "Authorization" : "Bearer $token",
    };

    try{
      var response = await http.post(Uri.parse(AppUrl.getProduct),
      body: body,
        headers: headers
      );
      
      log("response => $body");
      log("Body Response => ${response.body}");
      log("Status Request : ${response.statusCode}");
      
      if(response.statusCode == 200){
        ProductModel productModel = ProductModel.fromJson(jsonDecode(response.body));
        if(productModel.error == "0"){
          _originalData = productModel.data!;
          _data = _originalData;
          
          log("Product Data Loaded Successfully");
          Get.snackbar("Success", productModel.message.toString(),duration: Duration(seconds: 3));
        }else{
          log("Error: ${productModel.error}");
          Get.snackbar("Error", productModel.error.toString(),duration: Duration(seconds: 3));
        }
      }else{
        log("HTTP Error: ${response.statusCode}");
        Get.snackbar("Http Error", response.statusCode.toString(),duration: Duration(seconds: 3));
      }

    }catch (e,stack){
      log("Exception: $e");
      log("StackTrace: $stack");
    }finally{
      _isLoading = false;
      update();
    }

  }

  onSearch(String value){

    if(value.isEmpty){
      _data = _originalData;
    }else{
      _data = _originalData.where((element)=> element.name!.toLowerCase().contains(value.toLowerCase() )).toList();
    }
    update();
  }

}