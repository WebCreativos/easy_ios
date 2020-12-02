import 'package:flutter/widgets.dart';

abstract class StatusCodeErrors {

  factory StatusCodeErrors._() => null;

  void showStatusCodeErrors(int statusCode,VoidCallback callback){

    switch(statusCode){
      case 200: callback;
    }
  }
}