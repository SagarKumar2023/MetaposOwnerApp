import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:metapos_owner/controller_model/model/home/setting/CategoryListModel.dart';
import 'package:metapos_owner/utils/app_url.dart';

class CategoryController extends GetxController {
  List<CatData> _data = [];
  List<CatData> get data => _data;

  List<CatData> _originalData = [];
  List<CatData> get originalData => _originalData;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> getCategoryData(body) async {
    _isLoading = true;
    update();

    String token =
        "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMWM2ZWE3YjU3YjI2Y2QwZmFiMjI3Y2JiYTQ2MmFlZDlkZTYyMDlkNGE5OWI3NGFlY2M0ZDhlYjA0MDVkODk1NWQ0YWUxODFhYmJiY2M4ZGUiLCJpYXQiOjE3NjQyMzMzMDkuOTc2MzEyLCJuYmYiOjE3NjQyMzMzMDkuOTc2MzE0LCJleHAiOjE3OTU3NjkzMDkuOTcyMzA2LCJzdWIiOiI3MjU5Iiwic2NvcGVzIjpbXX0.HMl_kyES_m2mqKHA844DgKLQzIu7nj04QlPKO5jrsoEcT8XMGYUngu89RCiD2ZJnPWfGBVV1eBFA2tkJGqbRH5qsj-NMdFGQO5MrwIHXkNllhaMN6MvjS4j850NEXzNEmPpV3rRkcLbI4uq-jMTBVkdrsgt4NZcLID4tb_bkR533J9H69TiS_YyMyqXrQ-gMR3uUExinqABCH1nulGNFC6T0pUkBnvCkXBy_LJTDbnN6boizD4Xv9Gjjr8JywtJWiuxdLBFz64211toDBQgl7D4peg2fW3f2H6ajMX7C5LJvRC73-1zqyhJGItG_v-xFovEIJGIJRrMw0-GtFD6AgmAs2rWwOm53fgB-XCJdC4883ek7cniZ38NyueZb0gqA1yPZInVDCDnciD6qsnjOuhdR-dQLKo-CEolDmYyZGPcHwMT1-mc-47SHrKX3B8dQay7XdblWgdOPF5oPftkTVK2llk9MpGtPtTV-qmfjwHT_hsQZhZhZPqcdWhw-aFE93Ga0pxOMK__hIJyrd1ojUh0-klsuQ6XSuXJptRhHcUBLi_c0cJ5KdQ6SvP6KSRcP-qVfcvBhN3FZXoJQImSyKOfte_j1qdV5BaHhZR6L93OQRsimYdEZPLC50qbKQ_uLc2EH-1lmn-nYbECJeXDsAx24G74Q1U87X7sadgcCr38";

    var headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };

    var body = jsonEncode({
      "type": "pos",
    });

    try {
    var response = await http.post(Uri.parse(AppUrl.categoryData),
      body: body,
      headers: headers,
    );

    log("Request Body => $body");
    log("Status Request => ${response.statusCode}");
    log("Body Response => ${response.body}");

    if (response.statusCode == 200) {
      CategoryListModel categoryListModel = CategoryListModel.fromJson(jsonDecode(response.body),
      );

      if (categoryListModel.error == "0") {
        _originalData = categoryListModel.data;
        _data = _originalData;

        _isLoading = false;
        update();

        log('Category Loaded Successfully');
        Get.snackbar("Success", "Category Data Loaded Successfully");
      } else {
        log("Error => ${categoryListModel.error}");
        Get.snackbar(
          "Error",
          categoryListModel.error.toString(),
          duration: Duration(seconds: 3),
        );
      }
    } else {
      log("HTTP Error => ${response.statusCode}");
      Get.snackbar(
        "HTTP Error",
        response.statusCode.toString(),
        duration: Duration(seconds: 3),
      );
    }

    }catch (e,stack){
      log("Exception => $e");
      log("StackTrace : $stack");
      _isLoading = false;
      update();
    }finally{
      _isLoading =false;
      update();
    }
  }

  onSearch(String value){

    if(value.isEmpty){
      _data = _originalData;
    }else{
     _data =  _originalData.where((element)=> element.name.toLowerCase().contains(value.toLowerCase() )).toList();
    }
    update();
  }
}
