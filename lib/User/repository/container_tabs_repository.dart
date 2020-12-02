import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class ContainerTabsRepository {

  final BehaviorSubject<Widget> _controllerWidget = BehaviorSubject<Widget>();
  final BehaviorSubject<String> _controllerTabState = BehaviorSubject<String>();

  Stream<Widget> get getWindow => _controllerWidget.stream;
  Stream<String> get getTabState => _controllerTabState.stream;

  void setStream(Widget window){

    _controllerWidget.sink.add(window);
  }

  void setTabState(String selected){

    _controllerTabState.sink.add(selected);
  }

  void dispose(){

    _controllerWidget.close();
    _controllerTabState.close();
  }

}