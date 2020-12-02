import 'dart:convert';

import 'package:easygymclub/User/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/test.dart';

void main(){
  test('UserModel test .fromJson',() async {

    SharedPreferences.setMockInitialValues({});
    SharedPreferences pref = await SharedPreferences.getInstance();
    final json = '{"username":"testing"}';
    Map jsonMap = jsonDecode(json);

    var user = UserModel.fromJson(jsonMap);
    var user2 = UserModel(username: "testing2");
    //print(jsonDecode(user));
    print(user.username);
    pref.setString("userTest", jsonEncode(user2));
    print(pref.getString("userTest"));

    pref.remove("userTest");
  });
}