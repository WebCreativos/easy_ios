import 'package:flutter/material.dart';

class CustomTabs extends StatelessWidget{

  List<String> listOfTabs;

  VoidCallback callback;

  CustomTabs({Key key, this.listOfTabs,this.callback});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(bottom: 15.0),
      padding: EdgeInsets.only(right: 30.0,left:30.0),
      child: Row(
        children: _builder(),
      ),
    );
  }

  List<Widget> _builder(){
    return listOfTabs.map((title){
      return InkWell(
        child: Container(
          padding: EdgeInsets.all(15.0),
          margin: EdgeInsets.only(
            right: 5.0
          ),
          decoration: BoxDecoration(
            color: Colors.white70,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(15.0),
              topLeft: Radius.circular(15.0),
            )
          ),
          child: Text(title,textAlign: TextAlign.center,),
        ),
        onTap: this.callback,
      );
    }).toList();
  }


}