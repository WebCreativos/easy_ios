import 'package:flutter/material.dart';

class Meta extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.005,
        bottom: MediaQuery.of(context).size.height * 0.005,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              child: Align(
                alignment: Alignment.topCenter,
                  child: Image.asset("assets/img/exito.png")
              ),
            margin: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.05),
          ),
          Container(
            //height: 100.0,
            width: MediaQuery.of(context).size.width * 0.7,
            padding: EdgeInsets.all(5.0),
            margin: EdgeInsets.only(top:MediaQuery.of(context).size.height * 0.01),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:  BorderRadius.only(
                topRight: Radius.circular(10.0),
                bottomLeft: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0),
              ),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26,
                    blurRadius: 5.0,
                    spreadRadius: -1.0,
                  offset: Offset(2.0,2.0)
                )
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Etiam ultricies nisi vel augue."),
                Text("Etiam ultricies nisi vel augue."),
                Text("Etiam ultricies nisi vel augue."),
              ],
            )
          ),
        ],
      ),
    );
  }



}