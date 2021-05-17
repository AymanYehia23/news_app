import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CashHelper{

  static SharedPreferences sharedPreferences;

  static init() async
  {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> putBoolean({key, value}) async{
    return await sharedPreferences.setBool(key, value);
  }

  static bool getBoolean({@required key}){
    return sharedPreferences.getBool(key);
  }
}