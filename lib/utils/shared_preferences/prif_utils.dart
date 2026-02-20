import 'Prefs.dart';
import 'SharedPrefsKeys.dart';

class prifUtils{

  static String? setUserId(String userid) {
    Prefs.prefs!.setString(SharedPrefsKeys.id, userid);
  }

  static String getUserId() {
    final String? value = Prefs.prefs!.getString(SharedPrefsKeys.id);
    return value ?? '';
  }

  static String? setName(String name){
    Prefs.prefs!.setString(SharedPrefsKeys.name, name);
  }

  static String? getName() {
    final String? value = Prefs.prefs!.getString(SharedPrefsKeys.name);
    return value ?? '';
  }

  static String? setUserEmail(String mail){
    Prefs.prefs!.setString(SharedPrefsKeys.email, mail);
  }

  static String? getUserEmail() {
    final String? value = Prefs.prefs!.getString(SharedPrefsKeys.email);
    return value ?? '';
  }

  static String? setUserAddress(String address){
    Prefs.prefs!.setString(SharedPrefsKeys.address, address);
  }

  static String? getUserAddress(){
    final String? value = Prefs.prefs!.getString(SharedPrefsKeys.address);
    return value ?? '';
  }

  static String? setUserPhone(String phone){
    Prefs.prefs!.setString(SharedPrefsKeys.phone, phone);
  }

  static String? getUserPhone(){
    final String? value = Prefs.prefs!.getString(SharedPrefsKeys.phone);
    return value ?? '';
  }

  static String? setUserToken(String token){
    Prefs.prefs!.setString(SharedPrefsKeys.token, token);
  }

  static String? getUserToken(){
    final String? value = Prefs.prefs!.getString(SharedPrefsKeys.token);
    return value ?? '';
  }

  static String? setRestId(String restId){
    Prefs.prefs!.setString(SharedPrefsKeys.restId, restId);
  }

  static String? getRestId(){
    final String? value = Prefs.prefs!.getString(SharedPrefsKeys.restId);
    return value ?? '';
  }

  static String? setRestaurantCode(String restaurantCode){
    Prefs.prefs!.setString(SharedPrefsKeys.restaurantCode, restaurantCode);
  }

  static String? getRestaurantCode(){
    final String? value = Prefs.prefs!.getString(SharedPrefsKeys.restaurantCode);
    return value ?? '';
  }

  static Future<void> setRestaurantsList(String jsonList) async {
    Prefs.prefs!.setString(SharedPrefsKeys.restaurantsList, jsonList);
  }

  static String getRestaurantsList() {
    final String? value = Prefs.prefs!.getString(SharedPrefsKeys.restaurantsList);
    return value ?? '';
  }

}