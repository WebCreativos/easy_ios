import 'package:flutter/material.dart';

class CheckBox extends StatefulWidget{

  _CheckBox _checkbox;
  bool _checkState;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    _checkbox = _CheckBox();
    _checkState = false;

    return this._checkbox;
  }

  bool isChecked(){
    return this._checkState;
  }

}

class _CheckBox extends State<CheckBox>{

  Checkbox checkbox;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Theme(
      data: ThemeData(unselectedWidgetColor: Colors.white),
      child: Checkbox(
        value: widget._checkState,
        onChanged: (ok) => changeState(),
        autofocus: true,
        checkColor: Colors.white,
      ),
    );
  }

  void changeState(){
    setState(() {
      widget._checkState = !widget._checkState;
    });
  }


}