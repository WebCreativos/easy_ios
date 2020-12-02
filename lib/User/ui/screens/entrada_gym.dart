import 'package:easygymclub/User/model/user_model.dart';
import 'package:easygymclub/utils/user.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class EntradaGym extends StatefulWidget{

  @override
  _EntradaGymState createState() => _EntradaGymState();
}

class _EntradaGymState extends State<EntradaGym> {

  Future<UserModel> user;

  @override
  void initState() {
    super.initState();
    user = User.getSavedUser();
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<UserModel>(
      future: user,
      builder: (context,snap){
        if(!snap.hasData){
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        UserModel user = snap.data;
         return Container(
          child: Center(
            child: QrImage(
              backgroundColor: Colors.greenAccent,
              data: user.pk.toString(),
              version: QrVersions.auto,
              size: 200.0,
            ),
          ),
        );
      },
    );
  }
}