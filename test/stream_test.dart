import 'dart:async';
import 'dart:io';

import 'package:easygymclub/User/model/user_model.dart';
import 'package:easygymclub/User/repository/user_repository.dart';
import 'package:flutter_test/flutter_test.dart' as flutter_test;
import 'package:test/test.dart';


void main(){
  flutter_test.TestWidgetsFlutterBinding.ensureInitialized();
  test("Testing two streams",() {

    final StreamController<UserModel> _controllerUser = StreamController<UserModel>();
    Stream<UserModel> userInstance = _controllerUser.stream.asBroadcastStream();

    _controllerUser.sink.add(UserModel(username: "some username"));

    final subscription1 = userInstance;
    final subscription2 = userInstance;

    print("sub1: ${subscription1.isBroadcast}");
    subscription1.listen( (data) => print("Data! ${data.username}") );

    print("sub2: ${subscription2.isBroadcast}");
    subscription2.listen( (data) => print("Second: ${data.username}"));

    //
    print("END TEST");
    _controllerUser.close();
    //repo.onDispose();
  });
}