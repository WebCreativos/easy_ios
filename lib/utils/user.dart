import 'package:shared_preferences/shared_preferences.dart';
import 'package:easygymclub/User/model/user_model.dart';
import 'dart:convert';
class User {

  static Future<UserModel> getSavedUser() async {
  SharedPreferences  _pref = await SharedPreferences.getInstance();
    try {
      UserModel user =  UserModel.fromJson(jsonDecode(_pref.getString("user")));
      return user;
    }catch(e){
      print("Error $e");
      print("There's no user logged"); 
      return null;
    }
  }

}